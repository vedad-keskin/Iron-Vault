using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class KorisnikSuplement
{
    public int KorisnikSuplementId { get; set; }

    public int KorisnikId { get; set; }

    public int SuplementId { get; set; }

    public DateTime DatumVrijemeNarudzbe { get; set; }

    public int Kolicina { get; set; }

    public bool Isporuceno { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual Suplement Suplement { get; set; } = null!;
}
