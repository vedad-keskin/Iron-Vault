using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class NutricionistSeminar
    {
        public int NutricionistSeminarId { get; set; }

        public int NutricionistId { get; set; }

        public int SeminarId { get; set; }

        public Seminar Seminar { get; set; }
    }
}
