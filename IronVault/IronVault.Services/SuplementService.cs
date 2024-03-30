﻿using IronVault.Model;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.SuplementStateMachine;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public class SuplementService : BaseCRUDService<Model.Suplement,SuplementSearchObject,Database.Suplement,SuplementInsertRequest,SuplementUpdateRequest>, ISuplementService
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

            return filteredQuery;
        }

        public override Model.Suplement Insert(SuplementInsertRequest request)
        {
            var state = BaseSuplementState.CreateState("initial");
            return state.Insert(request);
        }

        public override Model.Suplement Update(int id, SuplementUpdateRequest request)
        {
            var entity = GetById(id);
            var state = BaseSuplementState.CreateState(entity.StateMachine);
            return state.Update(id, request);

        }

        public Model.Suplement Activate(int id)
        {
            var entity = GetById(id);
            var state = BaseSuplementState.CreateState(entity.StateMachine);
            return state.Activate(id);
        }


    }
}
