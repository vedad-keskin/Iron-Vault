using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model
{
    public class Korisnik
    {
        public int Id { get; set; }

        public string Ime { get; set; }

        public string Prezime { get; set; }

        public string? Slika { get; set; }

        public string BrojTelefona { get; set; }

        public float Visina { get; set; }

        public float Tezina { get; set; }
    }
}
