using IronVault.Model.Models;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Interfaces
{
    public interface IKorisnikService : ICRUDService<Model.Models.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {

        Model.Models.Korisnik Login(string username, string password);

        public int GetUserId(string username);

    }
}
