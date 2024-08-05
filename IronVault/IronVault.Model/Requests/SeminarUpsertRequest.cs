using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class SeminarUpsertRequest
    {
        public string Tema { get; set; } = null!;

        public string Predavac { get; set; } = null!;

        public DateTime Datum { get; set; }
    }
}
