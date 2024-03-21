using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.SearchObjects
{
    public class KorisnikSearchObject
    {
        public string? ImeGTE { get; set; }
        public string? PrezimeGTE { get; set; }
        public string? KorisnickoIme { get; set; }
        public string? Email { get; set; }
        public bool? IsKorisnikUlogaIncluded { get; set; }
    }
}
