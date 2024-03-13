﻿using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Trener
{
    public int TrenerId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public string BrojTelefona { get; set; } = null!;

    public string? Slika { get; set; }

    public virtual ICollection<KorisnikTrener> KorisnikTreners { get; set; } = new List<KorisnikTrener>();

    public virtual ICollection<Seminar> Seminars { get; set; } = new List<Seminar>();
}
