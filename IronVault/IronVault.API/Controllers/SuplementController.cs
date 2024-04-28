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

        [AllowAnonymous]
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
        public Suplement Activate(int id)
        {
            return (_service as ISuplementService).Activate(id);
        }

        [HttpPut("{id}/edit")]
        public Suplement Edit(int id)
        {
            return (_service as ISuplementService).Edit(id);
        }

        [HttpPut("{id}/hide")]
        public Suplement Hide(int id)
        {
            return (_service as ISuplementService).Hide(id);
        }

        [HttpGet("{id}/allowedActions")]
        public List<string> AllowedActions(int id)
        {
            return (_service as ISuplementService).AllowedActions(id);
        }
    }
}
