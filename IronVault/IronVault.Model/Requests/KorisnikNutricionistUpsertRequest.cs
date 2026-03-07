using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class KorisnikNutricionistUpsertRequest
    {

        public int KorisnikId { get; set; }

        public int NutricionistId { get; set; }

        public DateTime DatumTermina { get; set; }

        public int ZakazanoSati { get; set; }

    }
}
