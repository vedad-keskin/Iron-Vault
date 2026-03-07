using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.SearchObjects
{
    public class SuplementSearchObject : BaseSearchObject
    {
        public string? FTS { get; set; }
        public string? Kategorija { get; set; }
        public string? Dobavljac { get; set; }
        public string? StateMachine { get; set; }

    }
}
