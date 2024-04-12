using IronVault.Model.Models;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Interfaces
{
    public interface ISuplementService : ICRUDService<Suplement, SuplementSearchObject, SuplementInsertRequest, SuplementUpdateRequest>
    {
        public Suplement Activate(int id);
        public Suplement Edit(int id);
        public Suplement Hide(int id);
        public List<string> AllowedActions(int id);

    }
}
