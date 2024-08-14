using IronVault.Model.Models;
using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class NarudzbaInsertRequest
    {
        public int KorisnikId { get; set; }

        public DateTime DatumVrijemeNarudzbe { get; set; }

        public bool Status { get; set; }


    }
}
