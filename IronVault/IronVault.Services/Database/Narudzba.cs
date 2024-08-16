using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Narudzba
{
    public int NarudzbaId { get; set; }

    public int KorisnikId { get; set; }

    public string? Sifra { get; set; } = null!;

    public DateTime DatumVrijemeNarudzbe { get; set; }

    public bool? Status { get; set; }

    public bool? Otkazano { get; set; }

    public virtual Korisnik Korisnik { get; set; } = null!;

    public virtual ICollection<NarudzbaStavka> NarudzbaStavkas { get; set; } = new List<NarudzbaStavka>();
}
