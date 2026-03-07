using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Trener
{
    public int TrenerId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string BrojTelefona { get; set; } = null!;

    public byte[]? Slika { get; set; }

    public virtual ICollection<KorisnikTrener> KorisnikTreners { get; set; } = new List<KorisnikTrener>();

    public virtual ICollection<TrenerSeminar> TrenerSeminars { get; set; } = new List<TrenerSeminar>();
}
