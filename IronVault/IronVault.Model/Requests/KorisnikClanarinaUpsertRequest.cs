using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class KorisnikClanarinaUpsertRequest
    {

        public int KorisnikId { get; set; }

        public int ClanarinaId { get; set; }

        public DateTime DatumUplate { get; set; }

    }
}
