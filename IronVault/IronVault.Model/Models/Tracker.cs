using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public class Tracker
    {

        public int KorisnikId { get; set; }
        public Korisnik Korisnik { get; set; }
        public float? ukupnoKupljeno { get; set; }
        public int? ukupnoPrisutava { get; set; }
    }
}
