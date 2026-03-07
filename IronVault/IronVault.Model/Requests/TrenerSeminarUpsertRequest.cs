using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public class TrenerSeminarUpsertRequest
    {
        public int TrenerId { get; set; }

        public int SeminarId { get; set; }
    }
}
