using IronVault.Model;
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

namespace IronVault.Services
{
    public class KorisnikService : IKorisnikService
    {

        public GmsDbContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public KorisnikService(GmsDbContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public virtual List<Model.Korisnik> GetList(KorisnikSearchObject searchObject)
        {
            List<Model.Korisnik> result = new List<Model.Korisnik>();

            var query = Context.Korisniks.AsQueryable();

            if (!string.IsNullOrWhiteSpace(searchObject?.ImeGTE))
            {
                query = query.Where(x => x.Ime.StartsWith(searchObject.ImeGTE));
            }

            if (!string.IsNullOrWhiteSpace(searchObject?.PrezimeGTE))
            {
                query = query.Where(x => x.Prezime.StartsWith(searchObject.PrezimeGTE));
            }

            if (!string.IsNullOrWhiteSpace(searchObject?.Email))
            {
                query = query.Where(x => x.Email == searchObject.Email);
            }

            if (!string.IsNullOrWhiteSpace(searchObject?.KorisnickoIme))
            {
                query = query.Where(x => x.KorisnickoIme == searchObject.KorisnickoIme);
            }

            if (searchObject.IsKorisnikUlogaIncluded == true)
            {
                query = query.Include(x => x.KorisnikUlogas).ThenInclude(x => x.Uloga);
            }


            var list = query.ToList();

            result = Mapper.Map(list, result); 

            return result;
        }

        public Model.Korisnik Insert(KorisnikInsertRequest request)
        {
            if (request.Lozinka != request.LozinkaPotvrda)
            {
                throw new Exception("Lozinka i LozinkaPotvrda moraju biti iste");
            }

            Database.Korisnik entity = new Database.Korisnik();
            Mapper.Map(request, entity);

            entity.LozinkaSalt = GenerateSalt();
            entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);

            Context.Add(entity);
            Context.SaveChanges();


            return Mapper.Map<Model.Korisnik>(entity);

        }

        public static string GenerateSalt()
        {
            var byteArray = RNGCryptoServiceProvider.GetBytes(16);


            return Convert.ToBase64String(byteArray);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }

        public Model.Korisnik Update(int id, KorisnikUpdateRequest request)
        {
            var entity = Context.Korisniks.Find(id);

            Mapper.Map(request, entity);

            if (request.Lozinka != null)
            {
                if (request.Lozinka != request.LozinkaPotvrda)
                {
                    throw new Exception("Lozinka i LozinkaPotvrda moraju biti iste");
                }

                entity.LozinkaSalt = GenerateSalt();
                entity.LozinkaHash = GenerateHash(entity.LozinkaSalt, request.Lozinka);
            }

            Context.SaveChanges();

            return Mapper.Map<Model.Korisnik>(entity);
        }
    }
}

