﻿using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class KorisnikUpdateRequest
    {
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string? Lozinka { get; set; }
        public string? LozinkaPotvrda { get; set; }
        public byte[]? Slika { get; set; }

        public string? BrojTelefona { get; set; }
        public float? Visina { get; set; }
        public float? Tezina { get; set; }
        public int? GradId { get; set; }
        public int? SpolId { get; set; }
    }
}
