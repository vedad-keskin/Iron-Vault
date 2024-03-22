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
    public class DobavljacService : IDobavljacService
    {

        public GmsDbContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public DobavljacService(GmsDbContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public virtual List<Model.Dobavljac> GetList(DobavljacSearchObject searchObject)
        {
            List<Model.Dobavljac> result = new List<Model.Dobavljac>();


            var query = Context.Dobavljacs.AsQueryable();

            if (!string.IsNullOrWhiteSpace(searchObject?.NazivGTE))
            {
                query = query.Where(x => x.Naziv.Contains(searchObject.NazivGTE) );
            }

            if (searchObject?.Page.HasValue == true && searchObject?.PageSize.HasValue == true)
            {
                query = query.Skip(searchObject.Page.Value * searchObject.PageSize.Value).Take(searchObject.PageSize.Value);
            }


            var list = query.ToList();

            result = Mapper.Map(list, result); 

            return result;
        }
    }
}
