using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Seminar
    {
        public int SeminarId { get; set; }

        public string Tema { get; set; } = null!;

        public string Predavac { get; set; } = null!;

        public DateTime Datum { get; set; }
    }
}
