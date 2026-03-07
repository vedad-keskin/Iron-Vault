using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class RecenzijaInsertRequest
    {
        public int KorisnikId { get; set; }
        public int SuplementId { get; set; }
        public int Ocjena { get; set; }
        public string Opis { get; set; } = null!;
    }
}
