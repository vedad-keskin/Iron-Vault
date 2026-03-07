using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.SearchObjects
{
    public class SeminarSearchObject : BaseSearchObject
    {
        public string? Tema { get; set; }
        public string? Predavac { get; set; } 
    }
}
