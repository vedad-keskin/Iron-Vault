using IronVault.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public class DummySuplementiService : SuplementiService
    {

        public new List<Suplementi> List = new List<Suplementi>()
        {
            new Suplementi()
            {
                SuplementId = 1,
                Naziv = "100% Whey Protein",
                Cijena = 139
            }
        };


        public override List<Suplementi> GetList()
        {
            return List;
        }
    }
}
