using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Korisnik
{
    public int KorisnikId { get; set; }

    public string Ime { get; set; } = null!;

    public string Prezime { get; set; } = null!;

    public string KorisnickoIme { get; set; } = null!;

    public string Email { get; set; } = null!;

    public string LozinkaHash { get; set; } = null!;

    public string LozinkaSalt { get; set; } = null!;

    public byte[]? Slika { get; set; }

    public byte[]? SlikaThumb { get; set; }

    public string BrojTelefona { get; set; } = null!;

    public float Visina { get; set; }

    public float Tezina { get; set; }

    public int? Razina { get; set; }

    public TimeSpan? VrijemeUteretani { get; set; }

    public int GradId { get; set; }

    public int SpolId { get; set; }

    public int TeretanaId { get; set; }

    public virtual ICollection<Aktivnost> Aktivnosts { get; set; } = new List<Aktivnost>();

    public virtual Grad Grad { get; set; } = null!;

    public virtual ICollection<KorisnikClanarina> KorisnikClanarinas { get; set; } = new List<KorisnikClanarina>();

    public virtual ICollection<KorisnikNutricionst> KorisnikNutricionsts { get; set; } = new List<KorisnikNutricionst>();

    public virtual ICollection<KorisnikTrener> KorisnikTreners { get; set; } = new List<KorisnikTrener>();

    public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; set; } = new List<KorisnikUloga>();

    public virtual ICollection<Narudzba> Narudzbas { get; set; } = new List<Narudzba>();

    public virtual ICollection<Recenzija> Recenzijas { get; set; } = new List<Recenzija>();

    public virtual Spol Spol { get; set; } = null!;

    public virtual Teretana Teretana { get; set; } = null!;
}
