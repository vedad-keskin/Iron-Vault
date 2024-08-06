using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Methods
{
    public class TrenerService : BaseCRUDService<Model.Models.Trener, TrenerSearchObject, Database.Trener, TrenerUpsertRequest, TrenerUpsertRequest>, ITrenerService
    {


        public TrenerService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<Trener> AddFilter(TrenerSearchObject search, IQueryable<Trener> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            if (!string.IsNullOrWhiteSpace(search?.ImePrezime))
            {
                filteredQuery = filteredQuery.Where(x => x.Ime.Contains(search.ImePrezime) || x.Prezime.Contains(search.ImePrezime));
            }
         



            return filteredQuery;
        }


    }
}
