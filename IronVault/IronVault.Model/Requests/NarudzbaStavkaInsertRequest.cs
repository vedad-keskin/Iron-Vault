using IronVault.Model.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class NarudzbaStavkaInsertRequest
    {
        public int NarudzbaId { get; set; }
        public int SuplementId { get; set; }
        public int Kolicina { get; set; }

    }
}
