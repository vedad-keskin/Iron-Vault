using IronVault.Model;
using IronVault.Model.Models;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Interfaces;
using IronVault.Services.Methods;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UlogaController : BaseCRUDController<Model.Models.Uloga,UlogaSearchObject,UlogaUpsertRequest, UlogaUpsertRequest>
    {

        public UlogaController(IUlogaService service): base(service)
        {

        }

        [Authorize(Roles = "Administrator")]
        public override Uloga Insert(UlogaUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Uloga Update(int id, UlogaUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Uloga> GetList([FromQuery] UlogaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Uloga GetById(int id)
        {
            return base.GetById(id);
        }
    }
}
