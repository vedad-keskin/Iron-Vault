using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class KorisnikNutricionist
    {
        public int KorisnikNutricionistId { get; set; }

        public int KorisnikId { get; set; }

        public int NutricionistId { get; set; }

        public DateTime DatumTermina { get; set; }

        public int ZakazanoSati { get; set; }

        public virtual Korisnik Korisnik { get; set; } = null!;

        public virtual Nutricionist Nutricionist { get; set; } = null!;
    }
}
