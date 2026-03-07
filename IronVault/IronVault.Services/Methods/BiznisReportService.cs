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
using System.Xml.Schema;

namespace IronVault.Services.Methods
{
    public class BiznisReportService : IBiznisReportService
    {


        public GmsDbContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public BiznisReportService(GmsDbContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public virtual BiznisReport GetBiznisReport()
        {
            var biznisReport = new BiznisReport();

            // Ukupan broj korisnika dodanih

            biznisReport.UkupnoKorisnici = Context.Korisniks.Count();

            // Ukupan broj korisnika koji su trenutno u teretani

            biznisReport.KorisniciUTeretani = Context.Prisustvos.Where(x => x.DatumVrijemeIzlaska == null).Count();

            // Ukupna zarada trenutnog mjeseca na članarinama

            var uplateOvogMjesecaClanarine = Context.KorisnikClanarinas.Include(x=> x.Clanarina).Where(x => x.DatumUplate.Month >= DateTime.Now.Month && x.DatumUplate.Month < DateTime.Now.AddMonths(1).Month && DateTime.Now.Year == x.DatumUplate.Year).ToList();

            float ukupnaZaradaClanarina = 0;

            for (int i = 0; i < uplateOvogMjesecaClanarine.Count(); i++)
            {
                ukupnaZaradaClanarina += uplateOvogMjesecaClanarine[i].Clanarina.Cijena;
            }

            biznisReport.ZaradaMjesecaNaClanarinama = ukupnaZaradaClanarina;

            // ukupna zarada ovog mjeseca na kupovinama

            var uplateTrenutnogMjesecaKupovine = Context.NarudzbaStavkas.Include(x => x.Narudzba).Include(x=> x.Suplement).Where(x => x.Narudzba.DatumVrijemeNarudzbe.Month >= DateTime.Now.Month && x.Narudzba.DatumVrijemeNarudzbe.Month < DateTime.Now.AddMonths(1).Month && DateTime.Now.Year == x.Narudzba.DatumVrijemeNarudzbe.Year).ToList();

            float ukupnaZaradaKupovina = 0;

            for (int i = 0; i < uplateTrenutnogMjesecaKupovine.Count(); i++)
            {
                ukupnaZaradaKupovina += (uplateTrenutnogMjesecaKupovine[i].Kolicina * uplateTrenutnogMjesecaKupovine[i].Suplement.Cijena);
            }

            biznisReport.ZaradaMjesecaNaKupovinama = ukupnaZaradaKupovina;

            // ukupna zarada i na članarinama i na kupovinama

            biznisReport.UkupnaZaradaMjeseca = ukupnaZaradaKupovina + ukupnaZaradaClanarina;

            // najbolje ocjenjeni suplement

            var sviSuplementi = Context.Suplements.ToList();

            Model.Models.Suplement NajboljeOcjenjeniSuplement = new Model.Models.Suplement();

            double MIN = 0;
            for (int i = 0; i < sviSuplementi.Count(); i++)
            {
                if (sviSuplementi[i].ProsjecnaOcjena.HasValue && sviSuplementi[i].ProsjecnaOcjena > MIN)
                {
                    MIN = sviSuplementi[i].ProsjecnaOcjena.Value;
                    NajboljeOcjenjeniSuplement = Mapper.Map<Model.Models.Suplement>(sviSuplementi[i]);
                }
            }

            biznisReport.NajboljaOcjenaSuplement = NajboljeOcjenjeniSuplement;

            // najprodavaniji suplement


            var svekupovineStavke = Context.NarudzbaStavkas
                 .Include(x => x.Suplement)
                 .GroupBy(g => g.Suplement)
                 .Select(group => new
                 {
                     Suplement = group.Key,
                     TotalSold = group.Sum(g => g.Kolicina)
                 })
                 .OrderByDescending(g => g.TotalSold)
                 .FirstOrDefault();

            // Check if svekupovineStavke is not null
            if (svekupovineStavke != null)
            {
                biznisReport.NajprodavanijiSuplement = Mapper.Map<Model.Models.Suplement>(svekupovineStavke.Suplement); // Assign the most sold supplement
                biznisReport.NajprodavanijiSuplementCount = svekupovineStavke.TotalSold; // Assign the total count sold
            }
            else
            {
                biznisReport.NajprodavanijiSuplement = null; // Handle the case where no supplement was sold
                biznisReport.NajprodavanijiSuplementCount = 0; // Handle the case where no supplements were sold
            }


            // korisnik sa najvecom razinom


            var korisnikSaNajvecomRazinom = Context.Korisniks
                .OrderByDescending(k => k.Razina) 
                .FirstOrDefault();

            if(korisnikSaNajvecomRazinom != null)
            {
                biznisReport.NajaktivnijiKorisnik = Mapper.Map<Model.Models.Korisnik>(korisnikSaNajvecomRazinom);

            }
            else
            {
                biznisReport.NajaktivnijiKorisnik = null;
            }


            return biznisReport;
        }




    }
}
