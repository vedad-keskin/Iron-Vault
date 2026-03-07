using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class KorisnikTrenerUpsertRequest
    {

        public int KorisnikId { get; set; }

        public int TrenerId { get; set; }

        public DateTime DatumTermina { get; set; }

        public int ZakazanoSati { get; set; }

    }
}
