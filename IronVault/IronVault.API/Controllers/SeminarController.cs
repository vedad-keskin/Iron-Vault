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
    public class SeminarController : BaseCRUDController<Seminar,SeminarSearchObject,SeminarUpsertRequest, SeminarUpsertRequest>
    {


        public SeminarController(ISeminarService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override Seminar Insert(SeminarUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Seminar Update(int id, SeminarUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Seminar> GetList([FromQuery] SeminarSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Seminar GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
