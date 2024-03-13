using IronVault.Model;
using IronVault.Services;
using IronVault.Services.Database;
using Microsoft.AspNetCore.Mvc;


namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisniciController : ControllerBase
    {
        protected IKorisniciService _service;

        public KorisniciController(IKorisniciService service)
        {
            _service = service;
        }

        [HttpGet]
        public List<Model.Korisnik> GetList()
        {
            return _service.GetList(); 
        }

    }
}
