using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class Seminar
{
    public int SeminarId { get; set; }

    public string Tema { get; set; } = null!;

    public string Predavac { get; set; } = null!;

    public DateTime Datum { get; set; }

    public virtual ICollection<NutricionistSeminar> NutricionistSeminars { get; set; } = new List<NutricionistSeminar>();

    public virtual ICollection<TrenerSeminar> TrenerSeminars { get; set; } = new List<TrenerSeminar>();
}
