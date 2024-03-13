using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Recenzija
{
    public int RecenzijaId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public string Zanimanje { get; set; } = null!;

    public string Tekst { get; set; } = null!;

    public string? Slika { get; set; }
}
