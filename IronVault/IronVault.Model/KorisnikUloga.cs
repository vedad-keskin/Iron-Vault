using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model
{
    public partial class KorisnikUloga
    {
        public int KorisnikUlogaId { get; set; }
        public int KorisnikId { get; set; }
        public int UlogaId { get; set; }
        public DateTime DatumIzmjene { get; set; }
        public virtual Uloga Uloga { get; set; } = null!;
    }
}
