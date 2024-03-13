using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Faq
{
    public int Faqid { get; set; }

    public string Pitanje { get; set; } = null!;

    public string Odgovor { get; set; } = null!;
}
