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
    public class PrisustvoService : BaseCRUDService<Model.Models.Prisustvo, PrisustvoSearchObject, Database.Prisustvo, PrisustvoInsertRequest, PrisustvoUpdateRequest>, IPrisustvoService
    {


        public PrisustvoService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<Prisustvo> AddFilter(PrisustvoSearchObject search, IQueryable<Prisustvo> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Korisnik);

            if (!string.IsNullOrWhiteSpace(search?.KorisnikId))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId.ToString() == search.KorisnikId);
            }
            if (!string.IsNullOrWhiteSpace(search?.KorisnikPrisutan) && search?.KorisnikPrisutan == "true")
            {
                filteredQuery = filteredQuery.Where(x => x.DatumVrijemeIzlaska == null);
            }




            return filteredQuery;
        }


        public override void BeforeUpdate(PrisustvoUpdateRequest request, Database.Prisustvo entity)
        {
            // racunanje razine korisnika i provedenog vremena u teretani za svaku aktivnost
            // razlikaIzmedjuDatuma predstavlja TimeSpan koji sadrzi koliko vremena je provedeno u teretani 
            // level predstavlja razinu koja se povecava svakih 10 sati provedenih u teretani 

            TimeSpan? VrijemeProvedenoUTeretani = new TimeSpan(0, 0, 0, 0);

            var prethodneAktivnostiKorisnika = Context.Prisustvos.Where(x => x.KorisnikId == entity.KorisnikId).ToList();

            for (int i = 0; i < prethodneAktivnostiKorisnika.Count(); i++)
            {
                // osiguravamo da ne prolazi za ovaj zapis gdje je datum izlaska null
                if (prethodneAktivnostiKorisnika[i].DatumVrijemeIzlaska != null)
                {
                    var razlikaIzmedjuPrethodnihDatuma = prethodneAktivnostiKorisnika[i].DatumVrijemeIzlaska - prethodneAktivnostiKorisnika[i].DatumVrijemeUlaska;

                    VrijemeProvedenoUTeretani += razlikaIzmedjuPrethodnihDatuma; // 21 za Vedad

                }
            }

            entity.DatumVrijemeIzlaska = DateTime.Now;

            var razlikaIzmedjuDatuma = entity.DatumVrijemeIzlaska - entity.DatumVrijemeUlaska;

            VrijemeProvedenoUTeretani += razlikaIzmedjuDatuma;

            int level = (int)VrijemeProvedenoUTeretani?.TotalMinutes / 600 + 1;


            var TekstZaBazu = $"{VrijemeProvedenoUTeretani?.Days} dana, {VrijemeProvedenoUTeretani?.Hours} sati i  {VrijemeProvedenoUTeretani?.Minutes} minuta";


            var korisnik = Context.Korisniks.Find(entity.KorisnikId);

            korisnik!.VrijemeUteretani = TekstZaBazu;

            korisnik!.Razina = level;


            Context.SaveChanges();


            base.BeforeUpdate(request, entity);
        }

        public override void BeforeInsert(PrisustvoInsertRequest request, Prisustvo entity)
        {

            entity.DatumVrijemeUlaska = DateTime.Now;

            base.BeforeInsert(request, entity);
        }

    }
}
