using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class KorisnikTrener
    {
        public int KorisnikTrenerId { get; set; }

        public int KorisnikId { get; set; }

        public int TrenerId { get; set; }

        public DateTime DatumTermina { get; set; }

        public int ZakazanoSati { get; set; }

        public virtual Korisnik Korisnik { get; set; } = null!;

        public virtual Trener Trener { get; set; } = null!;
    }
}
