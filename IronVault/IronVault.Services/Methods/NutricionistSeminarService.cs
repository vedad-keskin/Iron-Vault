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
    public class NutricionistSeminarService : BaseCRUDService<Model.Models.NutricionistSeminar, NutricionistSeminarSearchObject, Database.NutricionistSeminar, NutricionistSeminarUpsertRequest, NutricionistSeminarUpsertRequest>, INutricionistSeminarService
    {


        public NutricionistSeminarService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<NutricionistSeminar> AddFilter(NutricionistSeminarSearchObject search, IQueryable<NutricionistSeminar> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Seminar);


            if (!string.IsNullOrWhiteSpace(search?.NutricionistId))
            {
                filteredQuery = filteredQuery.Where(x => x.NutricionistId.ToString() == search.NutricionistId);
            }
         



            return filteredQuery;
        }


    }
}
