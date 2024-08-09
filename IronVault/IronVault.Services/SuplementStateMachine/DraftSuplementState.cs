using EasyNetQ;
using IronVault.Model.Messages;
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

        public override Model.Models.Suplement Update(int id, SuplementUpdateRequest request)
        {
            var set = Context.Set<Database.Suplement>();

            var entity = set.Find(id);

            Mapper.Map(request, entity);

            Context.SaveChanges();

            return Mapper.Map<Model.Models.Suplement>(entity);
        }

        public override Model.Models.Suplement Activate(int id)
        {
            var set = Context.Set<Database.Suplement>();

            var entity = set.Find(id);

            entity.StateMachine = "active";

            Context.SaveChanges();

            // var bus = RabbitHutch.CreateBus("host=localhost:5673");

            var mappedEntity = Mapper.Map<Model.Models.Suplement>(entity);
            SuplementActivated message = new SuplementActivated { Suplement = mappedEntity };
            // bus.PubSub.Publish(message);

            return mappedEntity;
        }

        public override Model.Models.Suplement Hide(int id)
        {
            var set = Context.Set<Database.Suplement>();

            var entity = set.Find(id);

            entity.StateMachine = "hidden";

            Context.SaveChanges();

            return Mapper.Map<Model.Models.Suplement>(entity);
        }


        public override List<string> AllowedActions(Database.Suplement entity)
        {
            return new List<string> { nameof(Update), nameof(Activate), nameof(Hide) };
        }
    }
}
