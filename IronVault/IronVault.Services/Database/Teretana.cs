﻿using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Teretana
{
    public int TeretanaId { get; set; }

    public string Naziv { get; set; } = null!;

    public int GradId { get; set; }

    public string Adresa { get; set; } = null!;

    public virtual ICollection<Aktivnost> Aktivnosts { get; set; } = new List<Aktivnost>();

    public virtual Grad Grad { get; set; } = null!;

    public virtual ICollection<Korisnik> Korisniks { get; set; } = new List<Korisnik>();
}
