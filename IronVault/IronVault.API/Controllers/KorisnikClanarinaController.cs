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
    public class KorisnikClanarinaController : BaseCRUDController<KorisnikClanarina,KorisnikClanarinaSearchObject,KorisnikClanarinaUpsertRequest, KorisnikClanarinaUpsertRequest>
    {


        public KorisnikClanarinaController(IKorisnikClanarinaService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override KorisnikClanarina Insert(KorisnikClanarinaUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override KorisnikClanarina Update(int id, KorisnikClanarinaUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<KorisnikClanarina> GetList([FromQuery] KorisnikClanarinaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override KorisnikClanarina GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
