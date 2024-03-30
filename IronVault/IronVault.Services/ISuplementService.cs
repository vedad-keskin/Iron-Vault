
using IronVault.Model;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public interface ISuplementService : ICRUDService<Suplement, SuplementSearchObject,SuplementInsertRequest,SuplementUpdateRequest>
    {
        public Suplement Activate(int id);
    }
}
