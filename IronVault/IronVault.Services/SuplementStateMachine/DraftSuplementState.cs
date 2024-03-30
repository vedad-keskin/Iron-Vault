using IronVault.Model.Requests;
using IronVault.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.SuplementStateMachine
{
    public class DraftSuplementState : BaseSuplementState
    {
        public DraftSuplementState(GmsDbContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override Model.Suplement Update(int id, SuplementUpdateRequest request)
        {
            var set = Context.Set<Database.Suplement>();

            var entity = set.Find(id);

            Mapper.Map(request, entity);

            Context.SaveChanges();

            return Mapper.Map<Model.Suplement>(entity);
        }

        public override Model.Suplement Activate(int id)
        {
            var set = Context.Set<Database.Suplement>();

            var entity = set.Find(id);

            entity.StateMachine = "active";

            Context.SaveChanges();

            return Mapper.Map<Model.Suplement>(entity);
        }
    }
}
