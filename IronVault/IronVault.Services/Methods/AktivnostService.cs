using IronVault.Model.Models;
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
    public class AktivnostService : BaseCRUDService<Model.Models.Aktivnost, AktivnostSearchObject, Database.Aktivnost, AktivnostInsertRequest, AktivnostUpdateRequest>, IAktivnostService
    {
        public AktivnostService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

     

        public override void BeforeUpdate(AktivnostUpdateRequest request, Database.Aktivnost entity)
        {
            // racunanje razine korisnika i provedenog vremena u teretani za svaku aktivnost
            // razlikaIzmedjuDatuma predstavlja TimeSpan koji sadrzi koliko vremena je provedeno u teretani 
            // level predstavlja razinu koja se povecava svakih 10 sati provedenih u teretani 

            TimeSpan? VrijemeProvedenoUTeretani = new TimeSpan(0,0,0,0);

            var prethodneAktivnostiKorisnika = Context.Aktivnosts.Where(x => x.KorisnikId == entity.KorisnikId).ToList();

            for (int i = 0; i < prethodneAktivnostiKorisnika.Count(); i++)
            {
                // osiguravamo da ne prolazi za ovaj zapis gdje je datum izlaska null
                if (prethodneAktivnostiKorisnika[i].DatumVrijemeIzlaska != null)
                {
                    var razlikaIzmedjuPrethodnihDatuma = prethodneAktivnostiKorisnika[i].DatumVrijemeIzlaska - prethodneAktivnostiKorisnika[i].DatumVrijemeUlaska;

                    VrijemeProvedenoUTeretani += razlikaIzmedjuPrethodnihDatuma; // 21 za Vedad

                }
            }


            var razlikaIzmedjuDatuma = request.DatumVrijemeIzlaska - entity.DatumVrijemeUlaska;

            VrijemeProvedenoUTeretani += razlikaIzmedjuDatuma;

            int level = (int)VrijemeProvedenoUTeretani?.TotalMinutes / 600 + 1;


            var TekstZaBazu = $"{VrijemeProvedenoUTeretani?.Days} dana, {VrijemeProvedenoUTeretani?.Hours} sati i  {VrijemeProvedenoUTeretani?.Minutes} minuta";


            var korisnik = Context.Korisniks.Find(entity.KorisnikId);

            korisnik!.VrijemeUteretani = TekstZaBazu;

            korisnik!.Razina = level;


            Context.SaveChanges();


            base.BeforeUpdate(request, entity);
        }

        public override IQueryable<Database.Aktivnost> AddFilter(AktivnostSearchObject search, IQueryable<Database.Aktivnost> query)
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
