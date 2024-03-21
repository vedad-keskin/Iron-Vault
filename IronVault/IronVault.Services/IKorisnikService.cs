
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
    public interface IKorisnikService
    {
        List<Korisnik> GetList(KorisnikSearchObject searchObject);
        Korisnik Insert(KorisnikInsertRequest request);
        Korisnik Update(int id, KorisnikUpdateRequest request);
    }
}
