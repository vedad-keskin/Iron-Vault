using System;
using System.Collections.Generic;
using System.Text;

namespace IronVault.Model.Models
{
    public partial class KorisnikClanarina
    {
        public int KorisnikClanarinaId { get; set; }

        public int KorisnikId { get; set; }

        public int ClanarinaId { get; set; }

        public DateTime DatumUplate { get; set; }

        public DateTime DatumIsteka { get; set; }

        public virtual Clanarina Clanarina { get; set; } = null!;

    }
}
