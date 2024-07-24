using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using IronVault.Services.SuplementStateMachine;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
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
    }
}
