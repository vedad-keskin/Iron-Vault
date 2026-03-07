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
    public class KorisnikUlogaService : BaseCRUDService<Model.Models.KorisnikUloga, KorisnikUlogaSearchObject, Database.KorisnikUloga, KorisnikUlogaUpsertRequest, KorisnikUlogaUpsertRequest>, IKorisnikUlogaService
    {


        public KorisnikUlogaService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<KorisnikUloga> AddFilter(KorisnikUlogaSearchObject search, IQueryable<KorisnikUloga> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Uloga);


            if (!string.IsNullOrWhiteSpace(search?.KorisnikId))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId.ToString() == search.KorisnikId);
            }
         



            return filteredQuery;
        }

        public override void BeforeInsert(KorisnikUlogaUpsertRequest request, KorisnikUloga entity)
        {

            entity.DatumIzmjene = DateTime.Now;

            base.BeforeInsert(request, entity);
        }


    }
}
