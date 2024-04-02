using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Suplement
{
    public int SuplementId { get; set; }

    public string Naziv { get; set; } = null!;

    public float Cijena { get; set; }

    public float Gramaza { get; set; }

    public string Opis { get; set; } = null!;

    public byte[]? Slika { get; set; }

    public byte[]? SlikaThumb { get; set; }

    public string? StateMachine { get; set; }

    public double? ProsjecnaOcjena { get; set; }

    public int DobavljacId { get; set; }

    public int KategorijaId { get; set; }

    public virtual Dobavljac Dobavljac { get; set; } = null!;

    public virtual Kategorija Kategorija { get; set; } = null!;

    public virtual ICollection<KorisnikSuplement> KorisnikSuplements { get; set; } = new List<KorisnikSuplement>();

    public virtual ICollection<Recenzija> Recenzijas { get; set; } = new List<Recenzija>();
}
