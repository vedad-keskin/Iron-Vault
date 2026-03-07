using IronVault.Model;
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
    public class KorisnikNutricionistService : BaseCRUDService<Model.Models.KorisnikNutricionist, KorisnikNutricionistSearchObject, Database.KorisnikNutricionst, KorisnikNutricionistUpsertRequest, KorisnikNutricionistUpsertRequest>, IKorisnikNutricionistService
    {

        private readonly IEmailService _emailService;
        private readonly IKorisnikService _korisnikService;
        private readonly INutricionistService _nutricionistService;


        public KorisnikNutricionistService(GmsDbContext context, IMapper mapper, IEmailService emailService, IKorisnikService korisnikService, INutricionistService nutricionistService) : base(context, mapper)
        {
            _emailService = emailService;
            _korisnikService = korisnikService;
            _nutricionistService = nutricionistService;
        }

        public override IQueryable<KorisnikNutricionst> AddFilter(KorisnikNutricionistSearchObject search, IQueryable<KorisnikNutricionst> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Nutricionist);


            if (!string.IsNullOrWhiteSpace(search?.KorisnikId))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId.ToString() == search.KorisnikId);
            }

            filteredQuery = filteredQuery.OrderByDescending( x=> x.KorisnikNutricionistId);



            return filteredQuery;
        }

        public override async void AfterInsert(KorisnikNutricionistUpsertRequest request, KorisnikNutricionst entity)
        {
            var korisnik = _korisnikService.GetById(request.KorisnikId);
            var nutricionista = _nutricionistService.GetById(request.NutricionistId);
            Model.Models.Notifikacija notifikacija = new Model.Models.Notifikacija
            {
                Korisnik = $"{korisnik.Ime} {korisnik.Prezime}",
                Email = nutricionista.Email,
                ZakazanoSati = request.ZakazanoSati,
                DatumTermina = request.DatumTermina,

            };
            _emailService.SendingObject(notifikacija);

            base.AfterInsert(request, entity);
        }


        public override void BeforeInsert(KorisnikNutricionistUpsertRequest request, KorisnikNutricionst entity)
        {

            var terminiNutricioniste = Context.KorisnikNutricionsts
                .Where(x => x.NutricionistId == request.NutricionistId)
                .ToList();

            // Racunanje pocetka i kraja zakazanog termina 
            var newEventStart = request.DatumTermina;
            var newEventEnd = newEventStart.AddHours(request.ZakazanoSati);

            // Proci kroz dosadasnje termine trenera 
            foreach (var termin in terminiNutricioniste)
            {
                var existingEventStart = termin.DatumTermina;
                var existingEventEnd = existingEventStart.AddHours(termin.ZakazanoSati);

                // Provjeravanje overlapa
                if (newEventStart < existingEventEnd && newEventEnd > existingEventStart)
                {
                    throw new UserException("Nutricionist je zauzet u tom terminu");
                }
            }

            base.BeforeInsert(request, entity);
        }



    }
}
