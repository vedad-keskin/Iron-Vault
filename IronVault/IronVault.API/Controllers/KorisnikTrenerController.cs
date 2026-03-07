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
    public class KorisnikTrenerController : BaseCRUDController<KorisnikTrener,KorisnikTrenerSearchObject,KorisnikTrenerUpsertRequest, KorisnikTrenerUpsertRequest>
    {


        public KorisnikTrenerController(IKorisnikTrenerService service):base(service)
        {
           
        }

        [Authorize(Roles = "User")]
        public override KorisnikTrener Insert(KorisnikTrenerUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "User")]
        public override KorisnikTrener Update(int id, KorisnikTrenerUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [Authorize(Roles = "Administrator,User")]
        public override PagedResult<KorisnikTrener> GetList([FromQuery] KorisnikTrenerSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [Authorize(Roles = "Administrator,User")]
        public override KorisnikTrener GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
