using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Spol
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public virtual ICollection<Korisnik> Korisniks { get; set; } = new List<Korisnik>();
}
