using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class AutentifikacijaToken
{
    public int Id { get; set; }

    public string Vrijednost { get; set; } = null!;

    public int KorisnickiNalogId { get; set; }

    public DateTime VrijemeEvidentiranja { get; set; }

    public string? IpAdresa { get; set; }

    public string? TwoFkey { get; set; }

    public bool IsOtkljucano { get; set; }

    public virtual KorisnickiNalog KorisnickiNalog { get; set; } = null!;
}
