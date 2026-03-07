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
    public class TrenerController : BaseCRUDController<Trener,TrenerSearchObject,TrenerUpsertRequest, TrenerUpsertRequest>
    {


        public TrenerController(ITrenerService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override Trener Insert(TrenerUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Trener Update(int id, TrenerUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Trener> GetList([FromQuery] TrenerSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Trener GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
