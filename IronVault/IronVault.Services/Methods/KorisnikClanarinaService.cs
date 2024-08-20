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
    public class KorisnikClanarinaService : BaseCRUDService<Model.Models.KorisnikClanarina, KorisnikClanarinaSearchObject, Database.KorisnikClanarina, KorisnikClanarinaUpsertRequest, KorisnikClanarinaUpsertRequest>, IKorisnikClanarinaService
    {


        public KorisnikClanarinaService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<KorisnikClanarina> AddFilter(KorisnikClanarinaSearchObject search, IQueryable<KorisnikClanarina> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Clanarina);


            if (!string.IsNullOrWhiteSpace(search?.KorisnikId))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId.ToString() == search.KorisnikId);
            }

            filteredQuery = filteredQuery.OrderByDescending( x=> x.KorisnikClanarinaId);



            return filteredQuery;
        }

        public override void BeforeInsert(KorisnikClanarinaUpsertRequest request, KorisnikClanarina entity)
        {


            // Datum isteka stavljen na iduci mjesec na isti dan 
            entity.DatumIsteka = request.DatumUplate.AddMonths(1);

            base.BeforeInsert(request, entity);
        }



    }
}
