using IronVault.Model;
using IronVault.Model.SearchObjects;
using IronVault.Services;
using IronVault.Services.Database;
using Microsoft.AspNetCore.Mvc;


namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SuplementController : ControllerBase
    {
        protected ISuplementService _service;

        public SuplementController(ISuplementService service)
        {
            _service = service;
        }

        [HttpGet]
        public List<Model.Suplement> GetList([FromQuery] SuplementSearchObject searchObject)
        {
            return _service.GetList(searchObject); 
        }

    }
}
