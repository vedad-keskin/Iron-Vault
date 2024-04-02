using IronVault.Model.Models;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Interfaces;
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

    }
}
