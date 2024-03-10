using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model
{
    public class Suplementi
    {
        public int SuplementId { get; set; }
        public string Naziv { get; set; }
        public float Cijena { get; set; }
        //public float Gramaza { get; set; }
        //public string Opis { get; set; }
        //public string? Slika { get; set; }

        //[ForeignKey(nameof(Dobavljac))]
        //public int DobavljacID { get; set; }
        //public Dobavljac Dobavljac { get; set; }
        //[ForeignKey(nameof(Kategorija))]
        //public int KategorijaID { get; set; }
        //public Kategorija Kategorija { get; set; }
    }
}
