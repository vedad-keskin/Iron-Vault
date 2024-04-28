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
    public class TeretanaController : BaseCRUDController<Teretana, TeretanaSearchObject, TeretanaUpsertRequest, TeretanaUpsertRequest>
    {


        public TeretanaController(ITeretanaService service) : base(service)
        {

        }

        [Authorize(Roles = "Administrator")]
        public override Teretana Insert(TeretanaUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Teretana Update(int id, TeretanaUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Teretana> GetList([FromQuery] TeretanaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Teretana GetById(int id)
        {
            return base.GetById(id);
        }

    }
}
