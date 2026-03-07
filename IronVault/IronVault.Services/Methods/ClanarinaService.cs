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
    public class ClanarinaService : BaseCRUDService<Model.Models.Clanarina, ClanarinaSearchObject, Database.Clanarina, ClanarinaUpsertRequest, ClanarinaUpsertRequest>, IClanarinaService
    {


        public ClanarinaService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<Clanarina> AddFilter(ClanarinaSearchObject search, IQueryable<Clanarina> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.Contains(search.Naziv));
            }


            return filteredQuery;
        }


    }
}
