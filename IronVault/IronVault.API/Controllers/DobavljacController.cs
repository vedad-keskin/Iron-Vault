using IronVault.Model.SearchObjects;
using IronVault.Services;
using Microsoft.AspNetCore.Mvc;

namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DobavljacController : BaseController<Model.Dobavljac,DobavljacSearchObject>
    {


        public DobavljacController(IDobavljacService service):base(service)
        {
           
        }


    }
}
