using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class RecenzijaUpdateRequest
    {
        public int Ocjena { get; set; }
        public string Opis { get; set; } = null!;
    }
}
