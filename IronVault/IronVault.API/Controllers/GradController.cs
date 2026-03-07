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
    public class GradController : BaseCRUDController<Model.Models.Grad,GradSearchObject,GradUpsertRequest, GradUpsertRequest>
    {

        public GradController(IGradService service): base(service)
        {

        }

        [Authorize(Roles = "Administrator")]
        public override Grad Insert(GradUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Grad Update(int id, GradUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Grad> GetList([FromQuery] GradSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Grad GetById(int id)
        {
            return base.GetById(id);
        }
    }
}
