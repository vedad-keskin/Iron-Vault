using IronVault.Model.Models;
using IronVault.Model.Requests;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.SuplementStateMachine
{
    public class InitialSuplementState : BaseSuplementState
    {
        public InitialSuplementState(Database.GmsDbContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override Suplement Insert(SuplementInsertRequest request)
        {
            var set = Context.Set<Database.Suplement>();
            var entity = Mapper.Map<Database.Suplement>(request);
            entity.StateMachine = "draft";
            set.Add(entity);
            Context.SaveChanges();

            return Mapper.Map<Suplement>(entity);
        }


    }
}
