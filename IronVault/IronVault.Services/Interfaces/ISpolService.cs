﻿using IronVault.Model.Requests;
using IronVault.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace IronVault.Services.Interfaces
{
    public interface ISpolService : ICRUDService<Model.Models.Spol,SpolSearchObject,SpolUpsertRequest, SpolUpsertRequest>
    {
    }
}
