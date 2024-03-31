using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Teretana
    {
        public int TeretanaId { get; set; }
        public string Naziv { get; set; } = null!;
        public string Adresa { get; set; } = null!;
        public int GradId { get; set; }
        public virtual Grad Grad { get; set; } = null!;
    }
}
