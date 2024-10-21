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

        public List<Model.Models.Suplement> GetDistinctBought(int id)
        {
            var kupljeniSuplementi = Context.NarudzbaStavkas
                .Include(x => x.Suplement)
                .Include(x => x.Narudzba)
                .Where(x => x.Narudzba.KorisnikId == id)
                .Select(x => x.Suplement)  // Select the supplements
                .Distinct()  // Ensure distinct supplements
                .ToList();

            var result = Mapper.Map<List<Model.Models.Suplement>>(kupljeniSuplementi);

            return result;
        }

        // Inicijaliziranje ML-a i locka da se osigura da se MLContext inicijalizira samo jednom

        static MLContext mlContext = null;
        static object isLocked = new object();
        static ITransformer model = null;

        public List<Model.Models.Suplement> Recommend(int userId)
        {
            if (mlContext == null)
            {
                lock (isLocked)
                {
                    mlContext = new MLContext();

                    // uzimanje svih narudzbi

                    var tmpData = Context.Narudzbas.Include(x => x.NarudzbaStavkas)
                                                   .ThenInclude(x => x.Suplement.Kategorija)
                                                   .Include(x => x.NarudzbaStavkas)
                                                   .ThenInclude(x => x.Suplement.Dobavljac)
                                                   .ToList();

                    var data = new List<SuplementFeatures>();

                    // uzimanje suplemenata iz tih narudzbi 

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

                    // Loadanje podataka u ML 
                    var traindata = mlContext.Data.LoadFromEnumerable(data);

                    // Definisanje pipeline-a i mapiranje podataka
                    var pipeline = mlContext.Transforms.Conversion.MapValueToKey(nameof(SuplementFeatures.SuplementID))
                        .Append(mlContext.Transforms.Text.FeaturizeText(nameof(SuplementFeatures.Category)))
                        .Append(mlContext.Transforms.Text.FeaturizeText(nameof(SuplementFeatures.Manufacturer)))
                        .Append(mlContext.Transforms.Concatenate("Features", nameof(SuplementFeatures.Category), nameof(SuplementFeatures.Manufacturer)))
                        .Append(mlContext.Transforms.NormalizeMinMax("Features"));

  
                    model = pipeline.Fit(traindata);
                }
            }

            // Dobavljanje narudzbi korisnika 
            var userPurchases = Context.Narudzbas.Include(x => x.NarudzbaStavkas)
                                                 .ThenInclude(x => x.Suplement)
                                                 .Where(x => x.KorisnikId == userId)
                                                 .SelectMany(x => x.NarudzbaStavkas)
                                                 .ToList();

            if (!userPurchases.Any())
            {
                // Ako korisnik nema narudzbi preporučuju su 3 najbolje ocjenjena suplementa
                var topRatedSupplements = Context.Suplements
                                                 .OrderByDescending(x => x.ProsjecnaOcjena)  // Order by average rating
                                                 .Take(3)  // Take top 3 highest-rated supplements
                                                 .ToList();

                
                return Mapper.Map<List<Model.Models.Suplement>>(topRatedSupplements);
            }

            // Dobivanje distinct suplemenata korisnika
            var distinctUserSuplements = userPurchases.Select(x => x.Suplement).Distinct().ToList();

            // Kreiranje engina za predikcije 
            var predictionEngine = mlContext.Model.CreatePredictionEngine<SuplementFeatures, TransformedSuplementFeatures>(model);

            var targetVectors = new List<TransformedSuplementFeatures>();

            // Kreiranje vektora za predickiju
            foreach (var userSupplement in distinctUserSuplements)
            {
                var targetFeatures = new SuplementFeatures
                {
                    SuplementID = (uint)userSupplement.SuplementId,
                    Category = userSupplement.Kategorija?.Naziv ?? "Unknown Category",  // Null check for Kategorija
                    Manufacturer = userSupplement.Dobavljac?.Naziv ?? "Unknown Manufacturer"  // Null check for Dobavljac
                };

                var targetVector = predictionEngine.Predict(targetFeatures);
                targetVectors.Add(targetVector);
            }

            // Traženje suplemenata koje korisnik nije ranije kupio da bi se našla najbolja predikcija 
            var suplements = Context.Suplements.Where(x => !distinctUserSuplements.Contains(x)).ToList();
            var predictionResult = new List<(Database.Suplement, float)>(); // List of (Supplement, similarity score)

            foreach (var suplement in suplements)
            {
                var category = suplement.Kategorija?.Naziv ?? "Unknown Category";
                var manufacturer = suplement.Dobavljac?.Naziv ?? "Unknown Manufacturer";

                var supplementFeatures = new SuplementFeatures
                {
                    SuplementID = (uint)suplement.SuplementId,
                    Category = category,
                    Manufacturer = manufacturer
                };

                var supplementVector = predictionEngine.Predict(supplementFeatures);

                // Compute the maximum similarity score between target vectors and current supplement
                float maxSimilarity = targetVectors.Max(tv => CosineSimilarity(tv.Features, supplementVector.Features));
                predictionResult.Add((suplement, maxSimilarity));
            }

            // Return top 3 similar supplements
            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(3).ToList();

            return Mapper.Map<List<Model.Models.Suplement>>(finalResult);
        }

        // Računanje sličnosti preko cosine similarity

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