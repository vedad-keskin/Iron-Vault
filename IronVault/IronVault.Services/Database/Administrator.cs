using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Administrator
{
    public int Id { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public virtual KorisnickiNalog IdNavigation { get; set; } = null!;
}
