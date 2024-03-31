using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public class AktivnostService : BaseCRUDService<Model.Aktivnost, AktivnostSearchObject, Database.Aktivnost, AktivnostInsertRequest, AktivnostUpdateRequest>, IAktivnostService
    {
        public AktivnostService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override void BeforeUpdate(AktivnostUpdateRequest request, Aktivnost entity)
        {
            // racunanje razine korisnika i provedenog vremena u teretani za svaku aktivnost
            // razlikaIzmedjuDatuma predstavlja TimeSpan koji sadrzi koliko vremena je provedeno u teretani 
            // level predstavlja razinu koja se povecava svakih 10 sati provedenih u teretani 

            var razlikaIzmedjuDatuma = request.DatumVrijemeIzlaska - entity.DatumVrijemeUlaska;

            var korisnik = Context.Korisniks.Find(entity.KorisnikId);

            korisnik.VrijemeUteretani += razlikaIzmedjuDatuma;

            int level = (((int)((TimeSpan)(korisnik.VrijemeUteretani)).TotalMinutes) / 600) + 1;

            korisnik.Razina = level;

            Context.SaveChanges();


            base.BeforeUpdate(request, entity);
        }

        public override IQueryable<Aktivnost> AddFilter(AktivnostSearchObject search, IQueryable<Aktivnost> query)
        {

            query = base.AddFilter(search, query);

            if (search?.KorisnikId != null)
            {
                query = query.Where(x => x.KorisnikId == search.KorisnikId);
            }


            return query;
        }

    }
}
