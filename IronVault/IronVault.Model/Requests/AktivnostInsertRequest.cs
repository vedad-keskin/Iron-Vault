using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public partial class AktivnostInsertRequest
    {
        public int KorisnikId { get; set; }
        public DateTime DatumVrijemeUlaska { get; set; }
    }
}
