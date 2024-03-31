using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Aktivnost
    {
        public int AktivnostId { get; set; }
        public int KorisnikId { get; set; }
        public int TeretanaId { get; set; }
        public DateTime DatumVrijemeUlaska { get; set; }
        public DateTime? DatumVrijemeIzlaska { get; set; }
    }
}
