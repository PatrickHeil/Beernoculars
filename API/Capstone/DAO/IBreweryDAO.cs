﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Capstone.Models;

namespace Capstone.DAO
{
    public interface IBreweryDAO
    {
        List<Brewery> GetBreweries();

        void AddBrewery(Brewery brewery);

        void UpdateBrewery(Brewery brewery, int breweryId);

        Brewery GetBreweryByBreweryId(int breweryId);
    }
}
