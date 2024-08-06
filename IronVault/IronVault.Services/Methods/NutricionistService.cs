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
    public class NutricionistService : BaseCRUDService<Model.Models.Nutricionist, NutricionistSearchObject, Database.Nutricionist, NutricionistUpsertRequest, NutricionistUpsertRequest>, INutricionistService
    {


        public NutricionistService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<Nutricionist> AddFilter(NutricionistSearchObject search, IQueryable<Nutricionist> query)
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
