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
    public class TrenerSeminarService : BaseCRUDService<Model.Models.TrenerSeminar, TrenerSeminarSearchObject, Database.TrenerSeminar, TrenerSeminarUpsertRequest, TrenerSeminarUpsertRequest>, ITrenerSeminarService
    {


        public TrenerSeminarService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<TrenerSeminar> AddFilter(TrenerSeminarSearchObject search, IQueryable<TrenerSeminar> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            filteredQuery = filteredQuery.Include(x => x.Seminar);


            if (!string.IsNullOrWhiteSpace(search?.TrenerId))
            {
                filteredQuery = filteredQuery.Where(x => x.TrenerId.ToString() == search.TrenerId);
            }
         



            return filteredQuery;
        }


    }
}
