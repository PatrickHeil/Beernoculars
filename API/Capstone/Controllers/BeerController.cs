﻿using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Capstone.Controllers
{
    public class BeerController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
