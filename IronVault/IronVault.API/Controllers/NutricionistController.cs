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
    public class NutricionistController : BaseCRUDController<Nutricionist,NutricionistSearchObject,NutricionistUpsertRequest, NutricionistUpsertRequest>
    {


        public NutricionistController(INutricionistService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override Nutricionist Insert(NutricionistUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Nutricionist Update(int id, NutricionistUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Nutricionist> GetList([FromQuery] NutricionistSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Nutricionist GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
