using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using IronVault.Services.SuplementStateMachine;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using Microsoft.ML;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Methods
{
    public class SuplementService : BaseCRUDService<Model.Models.Suplement, SuplementSearchObject, Database.Suplement, SuplementInsertRequest, SuplementUpdateRequest>, ISuplementService
    {
        ILogger<SuplementService> _logger;
        public BaseSuplementState BaseSuplementState { get; set; }

        public SuplementService(GmsDbContext context, IMapper mapper, BaseSuplementState baseSuplementState, ILogger<SuplementService> logger) : base(context, mapper)
        {
            BaseSuplementState = baseSuplementState;
            _logger = logger;
        }

        public override IQueryable<Database.Suplement> AddFilter(SuplementSearchObject search, IQueryable<Database.Suplement> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Dobavljac).Include(x => x.Kategorija);


            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.Contains(search.FTS));
            }
            if (!string.IsNullOrWhiteSpace(search?.Kategorija))
            {
                filteredQuery = filteredQuery.Where(x => x.Kategorija.Naziv.Contains(search.Kategorija));
            }
            if (!string.IsNullOrWhiteSpace(search?.Dobavljac))
            {
                filteredQuery = filteredQuery.Where(x => x.Dobavljac.Naziv.Contains(search.Dobavljac));
            }


            return filteredQuery;
        }

        public override Model.Models.Suplement Insert(SuplementInsertRequest request)
        {
            var state = BaseSuplementState.CreateState("initial");
            return state.Insert(request);
        }

        public override Model.Models.Suplement Update(int id, SuplementUpdateRequest request)
        {
            var entity = GetById(id);
            var state = BaseSuplementState.CreateState(entity.StateMachine);
            return state.Update(id, request);

        }

        public Model.Models.Suplement Activate(int id)
        {
            var entity = GetById(id);
            var state = BaseSuplementState.CreateState(entity.StateMachine);
            return state.Activate(id);
        }

        public Model.Models.Suplement Edit(int id)
        {
            var entity = GetById(id);
            var state = BaseSuplementState.CreateState(entity.StateMachine);
            return state.Edit(id);
        }

        public Model.Models.Suplement Hide(int id)
        {
            var entity = GetById(id);
            var state = BaseSuplementState.CreateState(entity.StateMachine);
            return state.Hide(id);
        }

        public List<string> AllowedActions(int id)
        {
            _logger.LogInformation($"allowed actions for id: {id}");

            if (id <= 0)
            {
                var state = BaseSuplementState.CreateState("initial");
                return state.AllowedActions(null);

            }
            else
            {
                var entity = Context.Suplements.Find(id);
                var state = BaseSuplementState.CreateState(entity.StateMachine);
                return state.AllowedActions(entity);
            }
        }
        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public List<Model.Models.Suplement> Recommend(int id)
        {
            if (mlContext == null)
            {
                lock (isLocked)
                {
                    mlContext = new MLContext();

                    var tmpData = Context.Narudzbas.Include(x=> x.NarudzbaStavkas)
                                                   .ThenInclude(x => x.Suplement.Kategorija)
                                                   .Include(x => x.NarudzbaStavkas)
                                                   .ThenInclude(x => x.Suplement.Dobavljac)
                                                   .ToList();

                    var data = new List<SuplementFeatures>();

                    foreach (var item in tmpData)
                    {
                        foreach (var stavka in item.NarudzbaStavkas)
                        {
                            data.Add(new SuplementFeatures()
                            {
                                SuplementID = (uint)stavka.SuplementId,
                                Category = stavka.Suplement.Kategorija.Naziv,
                                Manufacturer = stavka.Suplement.Dobavljac.Naziv
                            });
                        }
                    }

                    // Load data into ML.NET data view
                    var traindata = mlContext.Data.LoadFromEnumerable(data);

                    // Define the transformation pipeline
                    var pipeline = mlContext.Transforms.Conversion.MapValueToKey(nameof(SuplementFeatures.SuplementID))
                        .Append(mlContext.Transforms.Text.FeaturizeText(nameof(SuplementFeatures.Category)))
                        .Append(mlContext.Transforms.Text.FeaturizeText(nameof(SuplementFeatures.Manufacturer)))
                        .Append(mlContext.Transforms.Concatenate("Features", nameof(SuplementFeatures.Category), nameof(SuplementFeatures.Manufacturer)))
                        .Append(mlContext.Transforms.NormalizeMinMax("Features"));

                    // Fit the data transformations
                    model = pipeline.Fit(traindata);
                }
            }

            // Get the target supplement
            var targetSuplement = Context.Suplements.Include(x => x.Kategorija).Include(x => x.Dobavljac).FirstOrDefault(x => x.SuplementId == id);

            if (targetSuplement == null)
            {
                return new List<Model.Models.Suplement>();
            }

            // Create prediction engine
            var predictionEngine = mlContext.Model.CreatePredictionEngine<SuplementFeatures, TransformedSuplementFeatures>(model);

            // Create feature vector for target supplement
            var targetFeatures = new SuplementFeatures
            {
                SuplementID = (uint)targetSuplement.SuplementId,
                Category = targetSuplement.Kategorija.Naziv,
                Manufacturer = targetSuplement.Dobavljac.Naziv
            };

            var targetVector = predictionEngine.Predict(targetFeatures);

            // Get all other supplements
            var suplements = Context.Suplements.Where(x => x.SuplementId != id).ToList();
            var predictionResult = new List<(Database.Suplement, float)>();

            foreach (var suplement in suplements)
            {
                var supplementFeatures = new SuplementFeatures
                {
                    SuplementID = (uint)suplement.SuplementId,
                    Category = suplement.Kategorija.Naziv,
                    Manufacturer = suplement.Dobavljac.Naziv
                };

                var supplementVector = predictionEngine.Predict(supplementFeatures);

                // Compute similarity based on content features
                var similarityScore = CosineSimilarity(targetVector.Features, supplementVector.Features);
                predictionResult.Add((suplement, similarityScore));
            }

            // Return top 4 similar supplements
            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(4).ToList();

            return Mapper.Map<List<Model.Models.Suplement>>(finalResult);
        }

        private float CosineSimilarity(float[] vectorA, float[] vectorB)
        {
            if (vectorA.Length != vectorB.Length)
                throw new ArgumentException("Vectors must be of same length");

            float dotProduct = 0;
            float magnitudeA = 0;
            float magnitudeB = 0;

            for (int i = 0; i < vectorA.Length; i++)
            {
                dotProduct += vectorA[i] * vectorB[i];
                magnitudeA += vectorA[i] * vectorA[i];
                magnitudeB += vectorB[i] * vectorB[i];
            }

            return dotProduct / (float)(Math.Sqrt(magnitudeA) * Math.Sqrt(magnitudeB));
        }

        public class SuplementFeatures
        {
            [KeyType(count: 10000)]
            public uint SuplementID { get; set; }

            public string Category { get; set; }

            public string Manufacturer { get; set; }
        }

        // The transformed class to hold the Features vector after transformation
        public class TransformedSuplementFeatures
        {
            public float[] Features { get; set; }
        }




    }
}