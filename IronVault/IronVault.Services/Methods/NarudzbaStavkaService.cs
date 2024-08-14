using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Methods
{
    public class NarudzbaStavkaService : BaseCRUDService<Model.Models.NarudzbaStavka, NarudzbaStavkaSearchObject, Database.NarudzbaStavka, NarudzbaStavkaInsertRequest, NarudzbaStavkaUpdateRequest>, INarudzbaStavkaService
    {
        public NarudzbaStavkaService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<NarudzbaStavka> AddFilter(NarudzbaStavkaSearchObject search, IQueryable<NarudzbaStavka> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Suplement);

            if (!string.IsNullOrWhiteSpace(search?.SuplementId))
            {
                filteredQuery = filteredQuery.Where(x => x.SuplementId.ToString() == search.SuplementId );
            }



            return filteredQuery;
        }
    }
}
