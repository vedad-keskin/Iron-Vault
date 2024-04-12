using IronVault.Model.Requests;
using IronVault.Services.Database;
using MapsterMapper;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.SuplementStateMachine
{
    public class BaseSuplementState
    {
        public GmsDbContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public IServiceProvider ServiceProvider { get; set; }

        public BaseSuplementState(GmsDbContext context, IMapper mapper, IServiceProvider serviceProvider)
        {
            Context = context;
            Mapper = mapper;
            ServiceProvider = serviceProvider;
        }
        public virtual Model.Models.Suplement Insert(SuplementInsertRequest request)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Model.Models.Suplement Update(int id, SuplementUpdateRequest request)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Model.Models.Suplement Activate(int id)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Model.Models.Suplement Hide(int id)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Model.Models.Suplement Edit(int id)
        {
            throw new Exception("Method not allowed");
        }

        public virtual List<string> AllowedActions(Database.Suplement entity) 
        {
            throw new Exception("Method not allowed");
        }

        public BaseSuplementState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "initial":
                    return ServiceProvider.GetService<InitialSuplementState>();
                case "draft":
                    return ServiceProvider.GetService<DraftSuplementState>();
                case "active":
                    return ServiceProvider.GetService<ActiveSuplementState>();
                case "hidden":
                    return ServiceProvider.GetService<HiddenSuplementState>();
                default: throw new Exception("State not recognized");
            }
        }
    }
}
