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
    public class KategorijaController : BaseCRUDController<Kategorija, KategorijaSearchObject, KategorijaUpsertRequest, KategorijaUpsertRequest>
    {


        public KategorijaController(IKategorijaService service) : base(service)
        {

        }


        [AllowAnonymous]
        public override PagedResult<Kategorija> GetList([FromQuery] KategorijaSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [AllowAnonymous]
        public override Kategorija GetById(int id)
        {
            return base.GetById(id);
        }

    }
}
