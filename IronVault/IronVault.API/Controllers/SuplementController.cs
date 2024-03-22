using IronVault.Model;
using IronVault.Model.SearchObjects;
using IronVault.Services;
using IronVault.Services.Database;
using Microsoft.AspNetCore.Mvc;


namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SuplementController : BaseController<Model.Suplement,SuplementSearchObject>
    {
    

        public SuplementController(ISuplementService service):base(service)
        {
            
        }


    }
}
