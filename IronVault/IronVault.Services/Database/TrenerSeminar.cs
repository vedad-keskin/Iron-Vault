using System;
using System.Collections.Generic;

namespace IronVault.Services.Database;

public partial class TrenerSeminar
{
    public int TrenerSeminarId { get; set; }

    public int TrenerId { get; set; }

    public int SeminarId { get; set; }

    public virtual Seminar Seminar { get; set; } = null!;

    public virtual Trener Trener { get; set; } = null!;
}
