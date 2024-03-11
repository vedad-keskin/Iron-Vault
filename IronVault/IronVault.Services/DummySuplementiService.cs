using IronVault.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public class DummySuplementiService : ISuplementiService
    {

        public new List<Suplement> List = new List<Suplement>()
        {
            new Suplement()
            {
                Id = 1,
                Naziv = "Whey",
                Cijena = 5
            }
        };

        public List<Suplement> GetList()
        {
            return List;
        }
    }
}
