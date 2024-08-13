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
    public class KorisnikUlogaController : BaseCRUDController<KorisnikUloga,KorisnikUlogaSearchObject,KorisnikUlogaUpsertRequest, KorisnikUlogaUpsertRequest>
    {


        public KorisnikUlogaController(IKorisnikUlogaService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override KorisnikUloga Insert(KorisnikUlogaUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override KorisnikUloga Update(int id, KorisnikUlogaUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<KorisnikUloga> GetList([FromQuery] KorisnikUlogaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override KorisnikUloga GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
