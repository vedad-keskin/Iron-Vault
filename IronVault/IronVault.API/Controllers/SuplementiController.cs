using IronVault.Model;
using IronVault.Services;
using Microsoft.AspNetCore.Mvc;


namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SuplementiController : ControllerBase
    {
        protected ISuplementiService _service;

        public SuplementiController(ISuplementiService service)
        {
            _service = service;
        }

        [HttpGet]
        public List<Suplementi> GetList()
        {
            return _service.GetList(); 
        }

    }
}
