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
    public class KorisnikNutricionistController : BaseCRUDController<KorisnikNutricionist,KorisnikNutricionistSearchObject,KorisnikNutricionistUpsertRequest, KorisnikNutricionistUpsertRequest>
    {


        public KorisnikNutricionistController(IKorisnikNutricionistService service):base(service)
        {
           
        }

        [Authorize(Roles = "User")]
        public override KorisnikNutricionist Insert(KorisnikNutricionistUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "User")]
        public override KorisnikNutricionist Update(int id, KorisnikNutricionistUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [Authorize(Roles = "Administrator,User")]
        public override PagedResult<KorisnikNutricionist> GetList([FromQuery] KorisnikNutricionistSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [Authorize(Roles = "Administrator,User")]
        public override KorisnikNutricionist GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
