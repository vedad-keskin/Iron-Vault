using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Methods
{
    public class KategorijaService : BaseCRUDService<Model.Models.Kategorija, KategorijaSearchObject, Database.Kategorija, KategorijaUpsertRequest, KategorijaUpsertRequest>, IKategorijaService
    {
        public KategorijaService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
