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
    public class BiznisReportController 
    {
        protected new IBiznisReportService _service;

        public BiznisReportController(IBiznisReportService service)
        {
           _service = service;
        }

        [HttpGet]
        [AllowAnonymous]
        public BiznisReport GetUkupnoKorisnici()
        {
            return (_service as IBiznisReportService).GetUkupnoKorisnici();
        }




    }
}
