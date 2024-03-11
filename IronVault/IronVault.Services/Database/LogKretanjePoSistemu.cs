using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class LogKretanjePoSistemu
{
    public int Id { get; set; }

    public int KorisnikId { get; set; }

    public string? QueryPath { get; set; }

    public string? PostData { get; set; }

    public DateTime Vrijeme { get; set; }

    public string? IpAdresa { get; set; }

    public string? ExceptionMessage { get; set; }

    public bool IsException { get; set; }

    public virtual KorisnickiNalog Korisnik { get; set; } = null!;
}
