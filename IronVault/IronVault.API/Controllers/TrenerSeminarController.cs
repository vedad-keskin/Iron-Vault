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
    public class TrenerSeminarController : BaseCRUDController<TrenerSeminar,TrenerSeminarSearchObject,TrenerSeminarUpsertRequest, TrenerSeminarUpsertRequest>
    {


        public TrenerSeminarController(ITrenerSeminarService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override TrenerSeminar Insert(TrenerSeminarUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override TrenerSeminar Update(int id, TrenerSeminarUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<TrenerSeminar> GetList([FromQuery] TrenerSeminarSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override TrenerSeminar GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
