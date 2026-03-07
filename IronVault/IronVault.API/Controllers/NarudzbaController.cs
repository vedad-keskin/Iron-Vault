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
    public class NarudzbaController : BaseCRUDController<Narudzba,NarudzbaSearchObject,NarudzbaInsertRequest, NarudzbaUpdateRequest>
    {


        public NarudzbaController(INarudzbaService service):base(service)
        {
           
        }

        [Authorize(Roles = "User")]
        public override Narudzba Insert(NarudzbaInsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "User")]
        public override Narudzba Update(int id, NarudzbaUpdateRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Narudzba> GetList([FromQuery] NarudzbaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Narudzba GetById(int id)
        {
            return base.GetById(id);
        }

        [HttpGet("{id}/GetLatestOrderIdByUserId")]
        [AllowAnonymous]
        public int GetLatestOrderIdByUserId(int id)
        {
            return (_service as INarudzbaService).GetLatestOrderIdByUserId(id);
        }

    }
}
