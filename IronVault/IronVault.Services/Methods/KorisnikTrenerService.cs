﻿using IronVault.Model;
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
    public class KorisnikTrenerService : BaseCRUDService<Model.Models.KorisnikTrener, KorisnikTrenerSearchObject, Database.KorisnikTrener, KorisnikTrenerUpsertRequest, KorisnikTrenerUpsertRequest>, IKorisnikTrenerService
    {
        private readonly IEmailService _emailService;
        private readonly IKorisnikService _korisnikService;
        private readonly ITrenerService _trenerService;


        public KorisnikTrenerService(GmsDbContext context, IMapper mapper, IEmailService emailService, IKorisnikService korisnikService, ITrenerService trenerService) : base(context, mapper)
        {
            _emailService = emailService;
            _korisnikService = korisnikService;
            _trenerService = trenerService;
        }

        public override IQueryable<KorisnikTrener> AddFilter(KorisnikTrenerSearchObject search, IQueryable<KorisnikTrener> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Trener);


            if (!string.IsNullOrWhiteSpace(search?.KorisnikId))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnikId.ToString() == search.KorisnikId);
            }

            filteredQuery = filteredQuery.OrderByDescending(x => x.KorisnikTrenerId);



            return filteredQuery;
        }


        // Slanje maila nakon inserta termina
        public override async void AfterInsert(KorisnikTrenerUpsertRequest request, KorisnikTrener entity)
        {
            var korisnik = _korisnikService.GetById(request.KorisnikId);
            var trener = _trenerService.GetById(request.TrenerId);
            Model.Models.Notifikacija notifikacija = new Model.Models.Notifikacija
            {
                Korisnik = $"{korisnik.Ime} {korisnik.Prezime}",
                Email = trener.Email,
                ZakazanoSati = request.ZakazanoSati,
                DatumTermina = request.DatumTermina,

            };
            _emailService.SendingObject(notifikacija);

            base.AfterInsert(request, entity);
        }



        public override void BeforeInsert(KorisnikTrenerUpsertRequest request, KorisnikTrener entity)
        {
            var terminiTrenera = Context.KorisnikTreners
                .Where(x => x.TrenerId == request.TrenerId)
                .ToList();

            // Racunanje pocetka i kraja zakazanog termina 
            var newEventStart = request.DatumTermina;
            var newEventEnd = newEventStart.AddHours(request.ZakazanoSati);

            // Proci kroz dosadasnje termine trenera 
            foreach (var termin in terminiTrenera)
            {
                var existingEventStart = termin.DatumTermina;
                var existingEventEnd = existingEventStart.AddHours(termin.ZakazanoSati);

                // Provjeravanje overlapa
                if (newEventStart < existingEventEnd && newEventEnd > existingEventStart)
                {
                    throw new UserException("Trener je zauzet u tom terminu");
                }
            }

            base.BeforeInsert(request, entity);
        }




    }
}
