using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class KorisnickiNalog
{
    public int Id { get; set; }

    public string Username { get; set; } = null!;

    public string Password { get; set; } = null!;

    public bool Is2Factive { get; set; }

    public virtual Administrator? Administrator { get; set; }

    public virtual ICollection<AutentifikacijaToken> AutentifikacijaTokens { get; set; } = new List<AutentifikacijaToken>();

    public virtual Korisnik? Korisnik { get; set; }

    public virtual ICollection<LogKretanjePoSistemu> LogKretanjePoSistemus { get; set; } = new List<LogKretanjePoSistemu>();
}
