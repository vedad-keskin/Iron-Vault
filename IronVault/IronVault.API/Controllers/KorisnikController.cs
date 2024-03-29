using IronVault.Model;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services;
using IronVault.Services.Database;
using Microsoft.AspNetCore.Mvc;


namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisnikController : BaseCRUDController<Model.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        public KorisnikController(IKorisnikService service)
            : base(service) { }

    }
}
