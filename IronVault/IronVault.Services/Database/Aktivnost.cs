using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Aktivnost
{
    public int AktivnostId { get; set; }
    public int KorisnikId { get; set; }
    public DateTime DatumVrijemeUlaska { get; set; }
    public DateTime? DatumVrijemeIzlaska { get; set; }
    public virtual Korisnik Korisnik { get; set; } = null!;
}
