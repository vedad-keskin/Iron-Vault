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
    public class KorisnikController : ControllerBase
    {
        protected IKorisnikService _service;

        public KorisnikController(IKorisnikService service)
        {
            _service = service;
        }

        [HttpGet]
        public PagedResult<Model.Korisnik> GetList([FromQuery] KorisnikSearchObject searchObject)
        {
            return _service.GetList(searchObject);
        }

        [HttpPost]
        public Model.Korisnik Insert(KorisnikInsertRequest request)
        {
            return _service.Insert(request);
        }

        [HttpPut("{id}")]
        public Model.Korisnik Update(int id, KorisnikUpdateRequest request)
        {
            return _service.Update(id, request);
        }

    }
}
