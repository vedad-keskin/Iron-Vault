using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class KorisnikClanarina
{
    public int KorisnikId { get; set; }

    public int ClanarinaId { get; set; }

    public DateTime DatumUplate { get; set; }

    public DateTime DatumIsteka { get; set; }

    public virtual Clanarina Clanarina { get; set; } = null!;

    public virtual Korisnik Korisnik { get; set; } = null!;
}
