using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Methods
{
    public class GradService : BaseCRUDService<Model.Models.Grad, GradSearchObject, Database.Grad, GradUpsertRequest, GradUpsertRequest>, IGradService
    {
        public GradService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
