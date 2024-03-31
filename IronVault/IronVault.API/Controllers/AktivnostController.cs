using IronVault.Model;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services;
using Microsoft.AspNetCore.Mvc;

namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AktivnostController : BaseCRUDController<Model.Aktivnost, AktivnostSearchObject, AktivnostInsertRequest, AktivnostUpdateRequest>
    {
        public AktivnostController(IAktivnostService service) : base(service)
        {

        }
    }
}
