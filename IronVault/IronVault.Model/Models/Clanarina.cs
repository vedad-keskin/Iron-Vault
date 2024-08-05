using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Clanarina
    {
        public int ClanarinaId { get; set; }

        public string Naziv { get; set; } = null!;

        public float Cijena { get; set; }

        public string Opis { get; set; } = null!;
    }
}
