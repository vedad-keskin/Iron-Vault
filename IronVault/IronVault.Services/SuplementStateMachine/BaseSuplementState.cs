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
        public virtual Model.Suplement Insert(SuplementInsertRequest request)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Model.Suplement Update(int id, SuplementUpdateRequest request)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Model.Suplement Activate(int id)
        {
            throw new Exception("Method not allowed");
        }

        public virtual Model.Suplement Hide(int id)
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
                default: throw new Exception("State not recognized");
            }
        }
    }
}
