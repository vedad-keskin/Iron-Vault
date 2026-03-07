using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Faq
    {
        public int Faqid { get; set; }
        public string Pitanje { get; set; }

        public string Odgovor { get; set; }
    }
}
