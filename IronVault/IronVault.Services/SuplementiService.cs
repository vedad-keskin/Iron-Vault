using IronVault.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public class SuplementiService : ISuplementiService
    {

        public List<Suplementi> List = new List<Suplementi>() 
        {
            new Suplementi()
            {
                SuplementId = 1,
                Naziv = "100% Whey Protein",
                Cijena = 139
            },
            new Suplementi()
            {
                SuplementId = 2,
                Naziv = "Gold 100% Casein",
                Cijena = 99
            },
        };


        public virtual List<Suplementi> GetList()
        {
            return List;
        }
    }
}
