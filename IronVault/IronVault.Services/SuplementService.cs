using IronVault.Model;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public class SuplementService : ISuplementService
    {

        public GmsDbContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public SuplementService(GmsDbContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public virtual List<Model.Suplement> GetList(SuplementSearchObject searchObject)
        {
            List<Model.Suplement> result = new List<Model.Suplement>();


            var query = Context.Suplements.AsQueryable();

            if (!string.IsNullOrWhiteSpace(searchObject?.FTS))
            {
                query = query.Where(x => x.Naziv.Contains(searchObject.FTS) || x.Opis.Contains(searchObject.FTS));
            }


            var list = Context.Suplements.ToList();

            result = Mapper.Map(list, result); 

            return result;
        }
    }
}
