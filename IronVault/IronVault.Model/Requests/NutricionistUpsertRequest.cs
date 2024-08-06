using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class NutricionistUpsertRequest
    {
        public string Ime { get; set; }

        public string Prezime { get; set; }

        public string Email { get; set; }

        public string BrojTelefona { get; set; }

        public string? Slika { get; set; }
    }
}
