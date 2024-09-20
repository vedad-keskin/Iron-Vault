using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Methods
{
    public class KorisnikTrenerService : BaseCRUDService<Model.Models.KorisnikTrener, KorisnikTrenerSearchObject, Database.KorisnikTrener, KorisnikTrenerUpsertRequest, KorisnikTrenerUpsertRequest>, IKorisnikTrenerService
    {


        public KorisnikTrenerService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<KorisnikTrener> AddFilter(KorisnikTrenerSearchObject search, IQueryable<KorisnikTrener> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Trener);


            if (!string.IsNullOrWhiteSpace(search?.KorisnikId))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId.ToString() == search.KorisnikId);
            }

            filteredQuery = filteredQuery.OrderByDescending( x=> x.KorisnikTrenerId);



            return filteredQuery;
        }




    }
}
