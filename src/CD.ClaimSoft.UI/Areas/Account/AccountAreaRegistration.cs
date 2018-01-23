﻿using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.Account
{
    public class AccountAreaRegistration : AreaRegistration
    {
        public override string AreaName => "Account";

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Account_default",
                "Account/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional },
                new { controller = "(Account)" }
            );
        }
    }
}