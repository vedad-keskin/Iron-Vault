using IronVault.Model.Models;
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
    public class TrackerService : ITrackerService
    {
        public GmsDbContext Context { get; set; }
        public IMapper Mapper { get; set; }

        public TrackerService(GmsDbContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public List<Tracker> GetAllTracker(TrackerSearchObject? search)
        {
            var Trackeri = new List<Tracker>();

            var SviKorisnici = Context.Korisniks.ToList();

            for (int i = 0; i < SviKorisnici.Count() ; i++)
            {

                var sveKupovineKorisnika = Context.Narudzbas.Include(x => x.NarudzbaStavkas).Where(x => x.KorisnikId == SviKorisnici[i].KorisnikId).ToList();

                // Trebalo je i implementirati da se filtrira po combo boxu na frontu gdje se moze selektovati suplement i da se ispise cijena samo narudzbi koje u sebi imaju suplement

                //var filtriraneKupovine = new List<Database.Narudzba>();

                //if (!string.IsNullOrWhiteSpace(search?.SuplementId))
                //{
                //    for (int j = 0; j < sveKupovineKorisnika.Count(); j++)
                //    {

                //          var kupovinaStavka = Context.NarudzbaStavkas.Where(x => x.NarudzbaId == sveKupovineKorisnika[j].NarudzbaId).ToList();

                //        for (int k = 0; k < kupovinaStavka.Count(); k++)
                //        {

                //            var mappedItem = Mapper.Map(sveKupovineKorisnika[j], new Database.Narudzba());

                //            // Dodavanje distinct itema 
                //            if (!filtriraneKupovine.Any(f => f.NarudzbaId == mappedItem.NarudzbaId))
                //            {
                //                filtriraneKupovine.Add(mappedItem);
                //            }


                //        }





                //    }

                //    sveKupovineKorisnika = filtriraneKupovine;
                //}




                float ukupno = 0;

                for (int j = 0; j < sveKupovineKorisnika.Count(); j++)
                {
                    var kupovinaStavka = Context.NarudzbaStavkas.Include(x=> x.Suplement).Where(x => x.NarudzbaId == sveKupovineKorisnika[j].NarudzbaId).ToList();

                    for (int k = 0; k < kupovinaStavka.Count(); k++)
                    {
                        ukupno = ukupno + (kupovinaStavka[k].Kolicina * kupovinaStavka[k].Suplement.Cijena);
                    }

                }


                var svaPrisustvaKorisnika = Context.Prisustvos.Where(x => x.KorisnikId == SviKorisnici[i].KorisnikId).ToList();

                if (search.datumOd != null)
                {
                    svaPrisustvaKorisnika = svaPrisustvaKorisnika.Where(x => x.DatumVrijemeUlaska >= search.datumOd).ToList();
                }
                if (search.DatumDo != null)
                {
                    svaPrisustvaKorisnika = svaPrisustvaKorisnika.Where(x => x.DatumVrijemeUlaska <= search.DatumDo).ToList();
                }


                
                var noviKorisnik = new Model.Models.Korisnik();

                var noviTracker = new Tracker()
                {
                    
                    KorisnikId = SviKorisnici[i].KorisnikId,
                    Korisnik = Mapper.Map(SviKorisnici[i], noviKorisnik),
                    ukupnoKupljeno = ukupno,
                    ukupnoPrisutava = svaPrisustvaKorisnika.Count(),

                };

                Trackeri.Add(noviTracker);


            }



            




            return Trackeri;
        }


    }
}
