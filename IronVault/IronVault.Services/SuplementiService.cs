using IronVault.Model;
using IronVault.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public class SuplementiService : ISuplementiService
    {

        public GmsDbContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public SuplementiService(GmsDbContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public virtual List<Model.Suplement> GetList()
        {
            List<Model.Suplement> result = new List<Model.Suplement>();

            var list = Context.Suplements.ToList();

            result = Mapper.Map(list, result); 

            return result;
        }
    }
}
