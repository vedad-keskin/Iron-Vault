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
    public class SuplementService : BaseService<Model.Suplement,SuplementSearchObject,Database.Suplement>, ISuplementService
    {


        public SuplementService(GmsDbContext context, IMapper mapper):base(context,mapper)
        {
           
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



    }
}
