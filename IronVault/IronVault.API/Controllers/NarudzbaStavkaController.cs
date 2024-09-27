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
    public class NarudzbaStavkaController : BaseCRUDController<NarudzbaStavka,NarudzbaStavkaSearchObject,NarudzbaStavkaInsertRequest, NarudzbaStavkaUpdateRequest>
    {


        public NarudzbaStavkaController(INarudzbaStavkaService service):base(service)
        {
           
        }

        [Authorize(Roles = "User")]
        public override NarudzbaStavka Insert(NarudzbaStavkaInsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "User")]
        public override NarudzbaStavka Update(int id, NarudzbaStavkaUpdateRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<NarudzbaStavka> GetList([FromQuery] NarudzbaStavkaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override NarudzbaStavka GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
