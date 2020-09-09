﻿// SPDX-License-Identifier: Apache-2.0
// Licensed to the Ed-Fi Alliance under one or more agreements.
// The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
// See the LICENSE and NOTICES files in the project root for more information.

#if NETFRAMEWORK
using System.Web.Mvc;

namespace EdFi.Ods.Admin.Controllers
{
    [Authorize]
    public class ClientController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}
#endif