
using IronVault.Model;
using IronVault.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services
{
    public interface IKorisnikService
    {
        List<Korisnik> GetList();

        Korisnik Insert(KorisnikInsertRequest request);
        Korisnik Update(int id, KorisnikUpdateRequest request);
    }
}
