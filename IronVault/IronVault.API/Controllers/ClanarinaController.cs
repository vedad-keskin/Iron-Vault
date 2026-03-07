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
    public class ClanarinaController : BaseCRUDController<Clanarina,ClanarinaSearchObject,ClanarinaUpsertRequest, ClanarinaUpsertRequest>
    {


        public ClanarinaController(IClanarinaService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override Clanarina Insert(ClanarinaUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Clanarina Update(int id, ClanarinaUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Clanarina> GetList([FromQuery] ClanarinaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Clanarina GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
