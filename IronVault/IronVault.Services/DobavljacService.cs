using IronVault.Model;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public class DobavljacService : BaseCRUDService<Model.Dobavljac,DobavljacSearchObject,Database.Dobavljac,DobavljacUpsertRequest,DobavljacUpsertRequest>, IDobavljacService
    {


        public DobavljacService(GmsDbContext context, IMapper mapper):base(context,mapper)
        {

        }

    }
}
