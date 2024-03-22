using IronVault.Model.SearchObjects;
using IronVault.Services;
using Microsoft.AspNetCore.Mvc;

namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DobavljacController : ControllerBase
    {
        protected IDobavljacService _service;

        public DobavljacController(IDobavljacService service)
        {
            _service = service;
        }

        [HttpGet]
        public List<Model.Dobavljac> GetList([FromQuery] DobavljacSearchObject searchObject)
        {
            return _service.GetList(searchObject);
        }
    }
}
