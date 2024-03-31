using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class GradController : BaseCRUDController<Model.Models.Grad,GradSearchObject,GradUpsertRequest, GradUpsertRequest>
    {

        public GradController(IGradService service): base(service)
        {

        }
    }
}
