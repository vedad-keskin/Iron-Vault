﻿using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Nutricionist
{
    public int NutricionistId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string BrojTelefona { get; set; } = null!;

    public byte[]? Slika { get; set; }

    public virtual ICollection<KorisnikNutricionst> KorisnikNutricionsts { get; set; } = new List<KorisnikNutricionst>();

    public virtual ICollection<NutricionistSeminar> NutricionistSeminars { get; set; } = new List<NutricionistSeminar>();
}
