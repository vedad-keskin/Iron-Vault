using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class Kategorija
    {
        public int KategorijaId { get; set; }
        public string Naziv { get; set; } = null!;
    }
}
