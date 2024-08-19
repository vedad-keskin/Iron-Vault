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
    public class PrisustvoController : BaseCRUDController<Prisustvo,PrisustvoSearchObject,PrisustvoInsertRequest, PrisustvoUpdateRequest>
    {


        public PrisustvoController(IPrisustvoService service):base(service)
        {
           
        }

        [Authorize(Roles = "Administrator")]
        public override Prisustvo Insert(PrisustvoInsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Prisustvo Update(int id, PrisustvoUpdateRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Prisustvo> GetList([FromQuery] PrisustvoSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Prisustvo GetById(int id)
        {
            return base.GetById(id);
        }


    }
}
