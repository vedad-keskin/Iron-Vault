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
    public class NarudzbaService : BaseCRUDService<Model.Models.Narudzba, NarudzbaSearchObject, Database.Narudzba, NarudzbaInsertRequest, NarudzbaUpdateRequest>, INarudzbaService
    {
        public NarudzbaService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Narudzba> AddFilter(NarudzbaSearchObject search, IQueryable<Narudzba> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Korisnik);

            if (!string.IsNullOrWhiteSpace(search?.ImePrezime))
            {
                filteredQuery = filteredQuery.Where(x => x.Korisnik.Ime.Contains(search.ImePrezime) || x.Korisnik.Prezime.Contains(search.ImePrezime));
            }



            return filteredQuery;
        }
    }
}
