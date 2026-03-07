using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class BiznisReport
    {

        public int UkupnoKorisnici { get; set; }
        public int KorisniciUTeretani { get; set; }
        public float UkupnaZaradaMjeseca { get; set; }
        public float ZaradaMjesecaNaClanarinama { get; set; }
        public float ZaradaMjesecaNaKupovinama { get; set; }

        public Suplement? NajprodavanijiSuplement { get; set; }
        public int? NajprodavanijiSuplementCount { get; set; }

        public Suplement? NajboljaOcjenaSuplement { get; set; }

        public Korisnik? NajaktivnijiKorisnik { get; set; }


    }
}
