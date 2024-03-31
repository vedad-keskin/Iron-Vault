using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class TeretanaUpsertRequest
    {
        public string Naziv { get; set; } = null!;
        public string Adresa { get; set; } = null!;
        public int GradId { get; set; }
    }
}
