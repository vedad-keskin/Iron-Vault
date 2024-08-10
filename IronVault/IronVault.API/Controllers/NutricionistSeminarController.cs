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
    public class NutricionistSeminarController : BaseCRUDController<NutricionistSeminar,NutricionistSeminarSearchObject,NutricionistSeminarUpsertRequest, NutricionistSeminarUpsertRequest>
    {


        public NutricionistSeminarController(INutricionistSeminarService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override NutricionistSeminar Insert(NutricionistSeminarUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override NutricionistSeminar Update(int id, NutricionistSeminarUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<NutricionistSeminar> GetList([FromQuery] NutricionistSeminarSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override NutricionistSeminar GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
