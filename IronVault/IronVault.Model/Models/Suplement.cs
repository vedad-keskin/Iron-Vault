using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public class Suplement
    {
        public int SuplementId { get; set; }
        public string Naziv { get; set; }
        public float Cijena { get; set; }
        public float Gramaza { get; set; }
        public string Opis { get; set; }
        public string? Slika { get; set; }
        //public byte[]? SlikaThumb { get; set; }
        public string? StateMachine { get; set; }
        public double? ProsjecnaOcjena { get; set; }
        public int DobavljacId { get; set; }
        public virtual Dobavljac Dobavljac { get; set; } = null!;
        public int KategorijaId { get; set; }
        public virtual Kategorija Kategorija { get; set; } = null!;

    }
}
