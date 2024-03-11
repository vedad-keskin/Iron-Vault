using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Clanarina
{
    public int Id { get; set; }

    public string Naziv { get; set; } = null!;

    public float Cijena { get; set; }

    public string Opis { get; set; } = null!;

    public virtual ICollection<KorisnikClanarina> KorisnikClanarinas { get; set; } = new List<KorisnikClanarina>();
}
