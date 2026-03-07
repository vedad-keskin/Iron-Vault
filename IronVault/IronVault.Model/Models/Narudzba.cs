using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Narudzba
    {
        public int NarudzbaId { get; set; }
        public string? Sifra { get; set; }
        public int KorisnikId { get; set; }

        public Korisnik Korisnik { get; set; }

        public DateTime DatumVrijemeNarudzbe { get; set; }

        public bool? Status { get; set; }

        public bool? Otkazano { get; set; }
    }
}
