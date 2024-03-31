using IronVault.Model.Models;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class TeretanaController : BaseCRUDController<Teretana, TeretanaSearchObject, TeretanaUpsertRequest, TeretanaUpsertRequest>
    {


        public TeretanaController(ITeretanaService service) : base(service)
        {

        }
    }
}
