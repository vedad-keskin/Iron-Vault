using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class SuplementUpdateRequest
    {
        public int SuplementId { get; set; }
        public string? Naziv { get; set; }
        public float? Cijena { get; set; }
        public float? Gramaza { get; set; }
        public string? Opis { get; set; }
        public string? Slika { get; set; }
        public int? DobavljacId { get; set; }
        public int? KategorijaId { get; set; }
    }
}
