using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Seminar
{
    public int SeminarId { get; set; }

    public string Tema { get; set; } = null!;

    public string Predavac { get; set; } = null!;

    public DateTime Datum { get; set; }

    public virtual ICollection<Nutricionist> Nutricionists { get; set; } = new List<Nutricionist>();

    public virtual ICollection<Trener> Treners { get; set; } = new List<Trener>();
}
