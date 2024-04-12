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
    public class RecenzijaService : BaseCRUDService<Model.Models.Recenzija, RecenzijaSerachObject, Database.Recenzija, RecenzijaInsertRequest, RecenzijaUpdateRequest>, IRecenzijaService
    {
        public RecenzijaService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Recenzija> AddFilter(RecenzijaSerachObject search, IQueryable<Recenzija> query)
        {
            query = base.AddFilter(search, query);

            query = query.Include(x => x.Korisnik).Include(x => x.Suplement);


            return base.AddFilter(search, query);
        }


        public override void BeforeInsert(RecenzijaInsertRequest request, Recenzija entity)
        {
            //TODO: Dodati zabranu kada se implementira kupovina suplemenata da ne moze
            //dati recenziju korisnik kojem nije isporucen suplement



            // Zabrana da jedan korisnik dva puta ocjenjuje isti suplement

            if(Context.Recenzijas.ToList().Exists(x=> x.KorisnikId == request.KorisnikId && x.SuplementId == request.SuplementId))
            {
                throw new Exception("Korisnik je već ocijenio taj suplement");
            }

            // Racunanje novog prosjeka suplementa kada recenzija prodje

            var PrethodneRecenzijeSuplementa = Context.Recenzijas.Where(x => x.SuplementId == request.SuplementId).ToList();

            double suma = 0;

            for (int i = 0; i < PrethodneRecenzijeSuplementa.Count(); i++)
            {
                suma += PrethodneRecenzijeSuplementa[i].Ocjena;
            }

            suma += request.Ocjena;

            var suplement = Context.Suplements.Find(request.SuplementId);

            suplement.ProsjecnaOcjena = suma / (PrethodneRecenzijeSuplementa.Count() + 1);

            Context.SaveChanges();


            base.BeforeInsert(request, entity);
        }

        public override void BeforeUpdate(RecenzijaUpdateRequest request, Recenzija entity)
        {
            // Kada mijenjamo ocjenu treba da se prosjek update-uje

            var suplement = Context.Suplements.Find(entity.SuplementId);

            var PrvobitneRecenzije = Context.Recenzijas.Where(x=> x.SuplementId == entity.SuplementId).ToList();

            PrvobitneRecenzije.Remove(entity);

            double suma = 0;

            for (int i = 0; i < PrvobitneRecenzije.Count(); i++)
            {
                suma += PrvobitneRecenzije[i].Ocjena;
            }

            suma += request.Ocjena;

            suplement.ProsjecnaOcjena = suma / (PrvobitneRecenzije.Count() + 1);

            Context.SaveChanges();


            base.BeforeUpdate(request, entity);
        }


    }
}
