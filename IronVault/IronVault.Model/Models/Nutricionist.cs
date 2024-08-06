using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Nutricionist
    {
        public int NutricionistId { get; set; }

        public string Ime { get; set; } = null!;

        public string Prezime { get; set; } = null!;

        public string Email { get; set; } = null!;

        public string BrojTelefona { get; set; } = null!;

        public string? Slika { get; set; }
    }
}
