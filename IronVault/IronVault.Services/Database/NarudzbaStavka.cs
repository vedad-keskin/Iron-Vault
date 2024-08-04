using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class NarudzbaStavka
{
    public int NarudzbaStavkaId { get; set; }

    public int NarudzbaId { get; set; }

    public int SuplementId { get; set; }

    public int Kolicina { get; set; }

    public virtual Narudzba Narudzba { get; set; } = null!;

    public virtual Suplement Suplement { get; set; } = null!;
}
