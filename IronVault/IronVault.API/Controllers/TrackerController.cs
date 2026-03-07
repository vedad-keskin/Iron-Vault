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
    public class TrackerController 
    {
        protected new ITrackerService _service;

        public TrackerController(ITrackerService service)
        {
           _service = service;
        }

        [HttpGet("/GetAllTracker")]
        [AllowAnonymous]
        public List<Tracker> GetAllTracker([FromQuery] TrackerSearchObject? search)
        {
            return (_service as ITrackerService).GetAllTracker(search);
        }




    }
}
