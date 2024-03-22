using IronVault.Model;
using IronVault.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public interface IDobavljacService
    {
        List<Dobavljac> GetList(DobavljacSearchObject searchObject);
    }
}
