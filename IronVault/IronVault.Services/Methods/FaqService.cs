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
    public class FaqService : BaseCRUDService<Model.Models.Faq, FaqSearchObject, Database.Faq, FaqUpsertRequest, FaqUpsertRequest>, IFaqService
    {


        public FaqService(GmsDbContext context, IMapper mapper) : base(context, mapper)
        {

        }

        public override IQueryable<Faq> AddFilter(FaqSearchObject search, IQueryable<Faq> query)
        {
            var filteredQuery = base.AddFilter(search, query);

            if (!string.IsNullOrWhiteSpace(search?.PitanjeOdgovor))
            {
                filteredQuery = filteredQuery.Where(x => x.Pitanje.Contains(search.PitanjeOdgovor) || x.Odgovor.Contains(search.PitanjeOdgovor));
            }


            return filteredQuery;
        }


    }
}
