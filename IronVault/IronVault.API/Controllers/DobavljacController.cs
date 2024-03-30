using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services;
using Microsoft.AspNetCore.Mvc;

namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DobavljacController : BaseCRUDController<Model.Dobavljac,DobavljacSearchObject,DobavljacUpsertRequest,DobavljacUpsertRequest>
    {


        public DobavljacController(IDobavljacService service):base(service)
        {
           
        }


    }
}
