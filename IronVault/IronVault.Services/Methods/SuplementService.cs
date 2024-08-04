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

            if(id <= 0)
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

                //train
                lock (isLocked)
                {
                    mlContext = new MLContext();

                    var tmpData = Context.Narudzbas.Include("NarudzbaStavkas").ToList();

                    var data = new List<ProductEntry>();

                    foreach (var item in tmpData)
                    {
                        if (item.NarudzbaStavkas.Count > 1)
                        {
                            var distinctItemId = item.NarudzbaStavkas.Select(y => y.SuplementId).Distinct().ToList();

                            distinctItemId.ForEach(y =>
                            {
                                var relatedItems = item.NarudzbaStavkas.Where(z => z.SuplementId != y);

                                foreach (var z in relatedItems)
                                {
                                    data.Add(new ProductEntry()
                                    {
                                        ProductID = (uint)y,
                                        CoPurchaseProductID = (uint)z.SuplementId
                                    });
                                }
                            });
                        }
                    }

                    var traindata = mlContext.Data.LoadFromEnumerable(data);

                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductID);
                    options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductID);
                    options.LabelColumnName = "Label";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;
                    // For better results use the following parameters
                    options.NumberOfIterations = 100;
                    options.C = 0.00001;

                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(traindata);
                }
            }

            var suplements = Context.Suplements.Where(x => x.SuplementId != id);

            var predictionResult = new List<(Database.Suplement, float)>();

            foreach (var suplement in suplements)
            {
                var predictionengine = mlContext.Model.CreatePredictionEngine<ProductEntry, Copurchase_prediction>(model);
                var prediction = predictionengine.Predict(
                                         new ProductEntry()
                                         {
                                             ProductID = (uint)id,
                                             CoPurchaseProductID = (uint)suplement.SuplementId
                                         });

                predictionResult.Add(new(suplement, prediction.Score));
            }

            var finalResult = predictionResult.OrderByDescending(x => x.Item2).Select(x => x.Item1).Take(4).ToList();

            return Mapper.Map<List<Model.Models.Suplement>>(finalResult);
        }
    }

    public class Copurchase_prediction
    {
        public float Score { get; set; }
    }

    public class ProductEntry
    {
        [KeyType(count: 10000)]
        public uint ProductID { get; set; }

        [KeyType(count: 10000)]
        public uint CoPurchaseProductID { get; set; }

        public float Label { get; set; }
    }



}
