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
    public class KorisnikNutricionistService : BaseCRUDService<Model.Models.KorisnikNutricionist, KorisnikNutricionistSearchObject, Database.KorisnikNutricionst, KorisnikNutricionistUpsertRequest, KorisnikNutricionistUpsertRequest>, IKorisnikNutricionistService
    {


        public KorisnikNutricionistService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<KorisnikNutricionst> AddFilter(KorisnikNutricionistSearchObject search, IQueryable<KorisnikNutricionst> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Nutricionist);


            if (!string.IsNullOrWhiteSpace(search?.KorisnikId))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId.ToString() == search.KorisnikId);
            }

            filteredQuery = filteredQuery.OrderByDescending( x=> x.KorisnikNutricionistId);



            return filteredQuery;
        }




    }
}
