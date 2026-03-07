using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.SearchObjects
{
    public class PrisustvoSearchObject : BaseSearchObject
    {
        public string? KorisnikId { get; set; }
        public string? KorisnikPrisutan { get; set; }
    }
}
