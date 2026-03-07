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
    public class SpolController : BaseCRUDController<Model.Models.Spol,SpolSearchObject,SpolUpsertRequest, SpolUpsertRequest>
    {

        public SpolController(ISpolService service): base(service)
        {

        }

        [Authorize(Roles = "Administrator")]
        public override Spol Insert(SpolUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Spol Update(int id, SpolUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Spol> GetList([FromQuery] SpolSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Spol GetById(int id)
        {
            return base.GetById(id);
        }
    }
}
