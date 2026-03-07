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
    public class DobavljacController : BaseCRUDController<Dobavljac,DobavljacSearchObject,DobavljacUpsertRequest,DobavljacUpsertRequest>
    {


        public DobavljacController(IDobavljacService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override Dobavljac Insert(DobavljacUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Dobavljac Update(int id, DobavljacUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Dobavljac> GetList([FromQuery] DobavljacSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Dobavljac GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
