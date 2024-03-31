using IronVault.Model.Models;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Interfaces;
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

        [HttpPut("{id}/activate")]
        public Suplement Activate(int id)
        {
            return (_service as ISuplementService).Activate(id);
        }
    }
}
