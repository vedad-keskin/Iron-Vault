using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Uloga
    {
        public int UlogaId { get; set; }
        public string Naziv { get; set; } = null!;
        public string? Opis { get; set; }
    }
}
