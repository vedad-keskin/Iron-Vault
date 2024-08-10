using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class TrenerSeminar
    {
        public int TrenerSeminarId { get; set; }

        public int TrenerId { get; set; }

        public int SeminarId { get; set; }

        public Seminar Seminar { get; set; }

    }
}
