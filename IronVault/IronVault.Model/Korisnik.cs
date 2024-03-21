﻿using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model
{
    public partial class Korisnik
    {
        public int KorisnikId { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public string KorisnickoIme { get; set; } = null!;
        public string? Email { get; set; }
        public string? Slika { get; set; }
        public string? BrojTelefona { get; set; }
        public float Visina { get; set; }
        public float Tezina { get; set; }
        public int GradId { get; set; }
        public int SpolId { get; set; }
        public int TeretanaId { get; set; }

        public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; set; } = new List<KorisnikUloga>();
    }
}
