using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.SearchObjects
{
    public partial class AktivnostSearchObject : BaseSearchObject
    {
        public int? KorisnikId { get; set; }
        public int? TeretanaId { get; set; }
    }
}
