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
    public class RecenzijaController : BaseCRUDController<Recenzija, RecenzijaSerachObject, RecenzijaInsertRequest, RecenzijaUpdateRequest>
    {


        public RecenzijaController(IRecenzijaService service) : base(service)
        {

        }

        [Authorize(Roles = "User")]
        public override Recenzija Insert(RecenzijaInsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "User")]
        public override Recenzija Update(int id, RecenzijaUpdateRequest request)
        {
            return base.Update(id, request);
        }

        [AllowAnonymous]
        public override PagedResult<Recenzija> GetList([FromQuery] RecenzijaSerachObject searchObject)
        {
            return base.GetList(searchObject);
        }


        [AllowAnonymous]
        public override Recenzija GetById(int id)
        {
            return base.GetById(id);
        }


        [HttpGet("{id}/GetListById")]
        [Authorize(Roles = "Administrator")]
        public List<Recenzija> GetListById(int id)
        {
            return (_service as IRecenzijaService).GetListById(id);
        }
    }
}
