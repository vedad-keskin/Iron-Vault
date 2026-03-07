using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using IronVault.Services.Database;
using IronVault.Services.Interfaces;
using MapsterMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Methods
{
    public class GradService : BaseCRUDService<Model.Models.Grad, GradSearchObject, Database.Grad, GradUpsertRequest, GradUpsertRequest>, IGradService
    {
        public GradService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Grad> AddFilter(GradSearchObject search, IQueryable<Grad> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            if (!string.IsNullOrWhiteSpace(search?.Naziv))
            {
                filteredQuery = filteredQuery.Where(x => x.Naziv.Contains(search.Naziv));
            }

            filteredQuery = filteredQuery.OrderBy(x => x.Naziv);

            return filteredQuery;
        }
    }
}
