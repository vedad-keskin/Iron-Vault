﻿using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model
{
    public partial class Aktivnost
    {
        public int AktivnostId { get; set; }
        public int KorisnikId { get; set; }
        public DateTime DatumVrijemeUlaska { get; set; }
        public DateTime? DatumVrijemeIzlaska { get; set; }
    }
}
