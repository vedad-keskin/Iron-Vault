using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model
{
    public class Suplement
    {
        public int SuplementId { get; set; }
        public string Naziv { get; set; }
        public float Cijena { get; set; }
        public float Gramaza { get; set; }
        public string Opis { get; set; }
        public string? Slika { get; set; }
    }
}
