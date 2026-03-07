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
    public class SeminarService : BaseCRUDService<Model.Models.Seminar, SeminarSearchObject, Database.Seminar, SeminarUpsertRequest, SeminarUpsertRequest>, ISeminarService
    {


        public SeminarService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<Seminar> AddFilter(SeminarSearchObject search, IQueryable<Seminar> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            if (!string.IsNullOrWhiteSpace(search?.Tema))
            {
                filteredQuery = filteredQuery.Where(x => x.Tema.Contains(search.Tema));
            }
            if (!string.IsNullOrWhiteSpace(search?.Predavac))
            {
                filteredQuery = filteredQuery.Where(x => x.Predavac.Contains(search.Predavac));
            }



            return filteredQuery;
        }


    }
}
