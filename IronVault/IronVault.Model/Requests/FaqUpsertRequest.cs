using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Requests
{
    public partial class FaqUpsertRequest
    {
        public string Pitanje { get; set; }
        public string Odgovor { get; set; }
    }
}
