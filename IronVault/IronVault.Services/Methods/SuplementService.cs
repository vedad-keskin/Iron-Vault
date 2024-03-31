using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using IronVault.Services.SuplementStateMachine;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Methods
{
    public class SuplementService : BaseCRUDService<Model.Models.Suplement, SuplementSearchObject, Database.Suplement, SuplementInsertRequest, SuplementUpdateRequest>, ISuplementService
    {

        public BaseSuplementState BaseSuplementState { get; set; }

        public SuplementService(GmsDbContext context, IMapper mapper, BaseSuplementState baseSuplementState) : base(context, mapper)
        {
            BaseSuplementState = baseSuplementState;
        }

        public override IQueryable<Database.Suplement> AddFilter(SuplementSearchObject search, IQueryable<Database.Suplement> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            if (!string.IsNullOrWhiteSpace(search?.FTS))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.Contains(search.FTS));
            }

            filteredQuery = filteredQuery.Include(x => x.Dobavljac).Include(x => x.Kategorija);

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


    }
}
