using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using MapsterMapper;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Methods
{
    public class TeretanaService : BaseCRUDService<Model.Models.Teretana, TeretanaSearchObject, Database.Teretana, TeretanaUpsertRequest, TeretanaUpsertRequest>, ITeretanaService
    {
        public TeretanaService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Teretana> AddFilter(TeretanaSearchObject search, IQueryable<Teretana> query)
        {
            query = base.AddFilter(search, query);

            if (search?.GradId != null)
            {
                query = query.Where(x => x.GradId == search.GradId);
            }

            query = query.Include(x => x.Grad);

            return base.AddFilter(search, query);
        }
    }
}
