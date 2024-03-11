﻿using IronVault.Model;
using IronVault.Services;
using IronVault.Services.Database;
using Microsoft.AspNetCore.Mvc;


namespace IronVault.API.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class SuplementiController : ControllerBase
    {
        protected ISuplementiService _service;

        public SuplementiController(ISuplementiService service)
        {
            _service = service;
        }

        [HttpGet]
        public List<Model.Suplement> GetList()
        {
            return _service.GetList(); 
        }

    }
}
