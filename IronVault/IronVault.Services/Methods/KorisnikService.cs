using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Linq.Dynamic;
using IronVault.Services.Interfaces;
using Microsoft.Extensions.Logging;
using IronVault.Model;

namespace IronVault.Services.Methods
{
    public class KorisnikService : BaseCRUDService<Model.Models.Korisnik, KorisnikSearchObject, Database.Korisnik, KorisnikInsertRequest, KorisnikUpdateRequest>, IKorisnikService

    {
        ILogger<KorisnikService> _logger;

        public KorisnikService(GmsDbContext context, IMapper mapper, ILogger<KorisnikService> logger) : base(context, mapper)
        {
            _logger = logger;
        }

        public override IQueryable<Database.Korisnik> AddFilter(KorisnikSearchObject searchObject, IQueryable<Database.Korisnik> query)
        {
            var filteredQuery = base.AddFilter(searchObject, query);

            filteredQuery = filteredQuery.Include(x => x.Spol).Include(x => x.Grad);

            if (!string.IsNullOrWhiteSpace(searchObject?.ImeGTE))
            {
                filteredQuery = filteredQuery.Where(x => x.Ime.StartsWith(searchObject.ImeGTE));
            }

            if (!string.IsNullOrWhiteSpace(searchObject?.PrezimeGTE))
            {
                filteredQuery = filteredQuery.Where(x => x.Prezime.StartsWith(searchObject.PrezimeGTE));
            }

            if (!string.IsNullOrWhiteSpace(searchObject?.Email))
            {
                filteredQuery = filteredQuery.Where(x => x.Email == searchObject.Email);
            }

            if (!string.IsNullOrWhiteSpace(searchObject?.KorisnickoIme))
            {
                filteredQuery = filteredQuery.Where(x => x.KorisnickoIme.Contains(searchObject.KorisnickoIme));
            }

            if (searchObject.IsKorisnikUlogaIncluded == true)
            {
                filteredQuery = filteredQuery.Include(x => x.KorisnikUlogas).ThenInclude(x => x.Uloga);
            }



            filteredQuery.Include(x => x.Spol).Include(x => x.Grad);

            return filteredQuery;
        }


        public override void BeforeInsert(KorisnikInsertRequest request, Database.Korisnik entity)
        {
            _logger.LogInformation($"Adding user: {entity.KorisnickoIme}");

            if (request.Lozinka != request.LozinkaPotvrda)
            {
                throw new UserException("Lozinka i LozinkaPotvrda moraju biti iste");
            }

            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);


            entity.Razina = 1;

            base.BeforeInsert(request, entity);

        }

        public override void AfterInsert(KorisnikInsertRequest request, Korisnik entity)
        {
            // Dodati pocetnu ulogu korisnicima tj. User

            var pocetnaKorisnikUloga = new KorisnikUloga()
            {
                KorisnikId = entity.KorisnikId,
                UlogaId = 2,
                DatumIzmjene = DateTime.Now
            };


            Context.KorisnikUlogas.Add(pocetnaKorisnikUloga);
            Context.SaveChanges();

            base.AfterInsert(request, entity);
        }


        public static string GenerateSalt()
        {
            var byteArray = RandomNumberGenerator.GetBytes(16);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public override void BeforeUpdate(KorisnikUpdateRequest request, Database.Korisnik entity)
        {
            if (request.Lozinka != null)
            {
                if (request.Lozinka != request.LozinkaPotvrda)
                {
                    throw new UserException("Lozinka i LozinkaPotvrda moraju biti iste");
                }

                entity.LozinkaSalt = GenerateSalt();
                entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);
            }

            base.BeforeUpdate(request, entity);
        }

        public Model.Models.Korisnik Login(string username, string password)
        {
            var entity = Context.Korisniks.Include(x => x.KorisnikUlogas).ThenInclude(y => y.Uloga).FirstOrDefault(x => x.KorisnickoIme == username);

            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.LozinkaSalt, password);

            if(hash != entity.LozinkaHash)
            {
                return null;
            }

            return this.Mapper.Map<Model.Models.Korisnik>(entity);
        }
    }
}

