using IronVault.Model;
using IronVault.Model.Models;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AktivnostController : BaseCRUDController<Aktivnost, AktivnostSearchObject, AktivnostInsertRequest, AktivnostUpdateRequest>
    {
        public AktivnostController(IAktivnostService service) : base(service)
        {

        }

        [Authorize(Roles = "Administrator")]
        public override Aktivnost Insert(AktivnostInsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Aktivnost Update(int id, AktivnostUpdateRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Aktivnost> GetList([FromQuery] AktivnostSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Aktivnost GetById(int id)
        {
            return base.GetById(id);
        }
    }
}
