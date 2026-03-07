using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public class Notifikacija
    {

        public Notifikacija() { }
      
        public string Email { get; set; } = null!;

        public string Korisnik { get; set; } = null!;

        public DateTime DatumTermina { get; set; } 

        public int ZakazanoSati { get; set; }
    }
}
