using IronVault.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.SuplementStateMachine
{
    public class HiddenSuplementState : BaseSuplementState
    {
        public HiddenSuplementState(GmsDbContext context, IMapper mapper, IServiceProvider serviceProvider) : base(context, mapper, serviceProvider)
        {
        }

        public override Model.Models.Suplement Edit(int id)
        {
            var set = Context.Set<Database.Suplement>();

            var entity = set.Find(id);

            entity.StateMachine = "draft";

            Context.SaveChanges();

            return Mapper.Map<Model.Models.Suplement>(entity);
        }

        public override List<string> AllowedActions(Database.Suplement entity)
        {
            return new List<string> {  nameof(Edit) };
        }
    }
}
