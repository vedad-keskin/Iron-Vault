using IronVault.Model;
using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;


namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class KorisnikController : BaseCRUDController<Model.Models.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        public KorisnikController(IKorisnikService service)
            : base(service) { }


        [HttpPost("login")]
        [AllowAnonymous]
        public Model.Models.Korisnik Login(string username, string password)
        {
            return (_service as IKorisnikService).Login(username, password);
        }


        [HttpGet("{username}/getUserId")]
        [AllowAnonymous]
        public int GetUserId(string username)
        {
            return (_service as IKorisnikService).GetUserId(username);
        }




        [Authorize(Roles = "Administrator")]
        public override Model.Models.Korisnik Insert(KorisnikInsertRequest request)
        {
            return base.Insert(request);
        }

        [Authorize(Roles = "Administrator,User")]
        public override Model.Models.Korisnik Update(int id, KorisnikUpdateRequest request)
        {
            return base.Update(id, request);
        }

        [Authorize(Roles = "Administrator")]
        public override PagedResult<Model.Models.Korisnik> GetList([FromQuery] KorisnikSearchObject searchObject)
        {
            return base.GetList(searchObject);
        }

        [Authorize(Roles = "Administrator,User")]
        public override Model.Models.Korisnik GetById(int id)
        {
            return base.GetById(id);
        }



    }
}
