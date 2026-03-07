using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class NutricionistSeminar
{
    public int NutricionistSeminarId { get; set; }

    public int NutricionistId { get; set; }

    public int SeminarId { get; set; }

    public virtual Nutricionist Nutricionist { get; set; } = null!;

    public virtual Seminar Seminar { get; set; } = null!;
}
