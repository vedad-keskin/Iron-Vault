using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public partial class ClanarinaUpsertRequest
    {
        public string Naziv { get; set; } 

        public float Cijena { get; set; }

        public string Opis { get; set; }
    }
}
