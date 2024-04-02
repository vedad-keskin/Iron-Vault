﻿using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Recenzija
    {
        public int RecenzijaId { get; set; }
        public int KorisnikId { get; set; }
        public int SuplementId { get; set; }
        public int Ocjena { get; set; }
        public string Opis { get; set; } = null!;
        public virtual Korisnik Korisnik { get; set; } = null!;
        public virtual Suplement Suplement { get; set; } = null!;
    }
}
