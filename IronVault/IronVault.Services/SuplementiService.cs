using IronVault.Model;
using IronVault.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public class SuplementiService : ISuplementiService
    {

        public GmsDbContext Context { get; set; }
        public SuplementiService(GmsDbContext context)
        {
            Context = context;
        }

        public virtual List<Model.Suplement> GetList()
        {
            var list = Context.Suplements.ToList();
            var result = new List<Model.Suplement>();
            list.ForEach(item => {
                result.Add(new Model.Suplement()
                {
                    Id = item.Id,
                    Naziv = item.Naziv,
                    Gramaza = item.Gramaza,
                    Cijena = item.Cijena,
                    Opis = item.Opis,
                    Slika = item.Slika
                });
            });
            return result;
        }
    }
}
