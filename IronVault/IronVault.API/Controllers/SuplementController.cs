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
    public class SuplementController : BaseCRUDController<Suplement,SuplementSearchObject,SuplementInsertRequest,SuplementUpdateRequest>
    {

        public SuplementController(ISuplementService service):base(service)
        {
            
        }

        [Authorize(Roles = "Administrator")]
        public override Suplement Insert(SuplementInsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator")]
        public override Suplement Update(int id, SuplementUpdateRequest request)
        {
            return base.Update(id, request);
        }

        [Authorize(Roles = "Administrator")]
        public override PagedResult<Suplement> GetList([FromQuery] SuplementSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Suplement GetById(int id)
        {
            return base.GetById(id);
        }



        [HttpPut("{id}/activate")]
        [Authorize(Roles = "Administrator")]
        public Suplement Activate(int id)
        {
            return (_service as ISuplementService).Activate(id);
        }

        [HttpPut("{id}/edit")]
        [Authorize(Roles = "Administrator")]
        public Suplement Edit(int id)
        {
            return (_service as ISuplementService).Edit(id);
        }

        [HttpPut("{id}/hide")]
        [Authorize(Roles = "Administrator")]
        public Suplement Hide(int id)
        {
            return (_service as ISuplementService).Hide(id);
        }

        [HttpGet("{id}/allowedActions")]
        public List<string> AllowedActions(int id)
        {
            return (_service as ISuplementService).AllowedActions(id);
        }

        [HttpGet("{id}/recommend")]
        public List<Suplement> Recommend(int id)
        {
            return (_service as ISuplementService).Recommend(id);
        }
    }
}
