using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Prisustvo
    {
        public int PrisustvoId { get; set; }

        public int KorisnikId { get; set; }
        public Korisnik Korisnik { get; set; }

        public DateTime DatumVrijemeUlaska { get; set; }

        public DateTime? DatumVrijemeIzlaska { get; set; }

    }
}
