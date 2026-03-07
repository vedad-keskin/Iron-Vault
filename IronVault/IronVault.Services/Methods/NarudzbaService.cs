using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using IronVault.Services.SuplementStateMachine;
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


        public override void AfterInsert(NarudzbaInsertRequest request, Narudzba entity)
        {
            
            if(entity.NarudzbaId.ToString().Length == 1)
            {
                entity.Sifra = $"SIF-000-00{entity.NarudzbaId}";
            }
            else if (entity.NarudzbaId.ToString().Length == 2)
            {
                entity.Sifra = $"SIF-000-0{entity.NarudzbaId}";
            }
            else if (entity.NarudzbaId.ToString().Length == 3)
            {
                entity.Sifra = $"SIF-000-{entity.NarudzbaId}";
            }
            else if (entity.NarudzbaId.ToString().Length == 4)
            {
                entity.Sifra = $"SIF-00{entity.NarudzbaId}";
            }
            else if (entity.NarudzbaId.ToString().Length == 5)
            {
                entity.Sifra = $"SIF-0{entity.NarudzbaId}";
            }
            else if (entity.NarudzbaId.ToString().Length == 6)
            {
                entity.Sifra = $"SIF-{entity.NarudzbaId}";
            }
            else
            {
                entity.Sifra = "SIF-000-000";
            }

            entity.Status = true;
            entity.Otkazano = false;

            Context.Update(entity);
            Context.SaveChanges();


            base.AfterInsert(request, entity);
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

        public int GetLatestOrderIdByUserId(int korisnikId)
        {
            var latestOrder = Context.Narudzbas
                .Where(x => x.KorisnikId == korisnikId)
                .OrderBy(x => x.NarudzbaId)  // redosljed da bi moglo uzeti zadnji
                .Last();  

            return latestOrder.NarudzbaId;
        }



    }
}
