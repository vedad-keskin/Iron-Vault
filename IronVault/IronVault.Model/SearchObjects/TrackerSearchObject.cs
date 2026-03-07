using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.SearchObjects
{
    public class TrackerSearchObject : BaseSearchObject
    {
        public string? ImePrezime { get; set; }
        public DateTime? datumOd { get; set; }
        public DateTime? DatumDo { get; set; }
        public string? SuplementId { get; set; }
    }
}
