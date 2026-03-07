using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class NarudzbaStavka
    {
        public int NarudzbaStavkaId { get; set; }

        public int NarudzbaId { get; set; }

        public int SuplementId { get; set; }

        public Suplement Suplement { get; set; }

        public int Kolicina { get; set; }
    }
}
