using IronVault.Model;
using IronVault.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public class KorisniciService : IKorisniciService
    {

        public GmsDbContext Context { get; set; }
        public IMapper Mapper { get; set; }
        public KorisniciService(GmsDbContext context, IMapper mapper)
        {
            Context = context;
            Mapper = mapper;
        }

        public virtual List<Model.Korisnik> GetList()
        {
            List<Model.Korisnik> result = new List<Model.Korisnik>();

            var list = Context.Korisniks.ToList();

            result = Mapper.Map(list, result); 

            return result;
        }
    }
}
