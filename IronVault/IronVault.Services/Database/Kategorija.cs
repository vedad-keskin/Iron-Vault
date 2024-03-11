using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Kategorija
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public virtual ICollection<Suplement> Suplements { get; set; } = new List<Suplement>();
}
