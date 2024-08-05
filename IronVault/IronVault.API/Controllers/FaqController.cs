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
    public class FaqController : BaseCRUDController<Faq,FaqSearchObject,FaqUpsertRequest, FaqUpsertRequest>
    {


        public FaqController(IFaqService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override Faq Insert(FaqUpsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Faq Update(int id, FaqUpsertRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Faq> GetList([FromQuery] FaqSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Faq GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
