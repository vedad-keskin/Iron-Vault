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
                SuplementId = 1,
                Naziv = "Whey",
                Cijena = 5,
                Gramaza = 100,
                Opis = "Opis",
                Slika = "slika"
            }
        };

        public List<Suplement> GetList()
        {
            return List;
        }
    }
}
