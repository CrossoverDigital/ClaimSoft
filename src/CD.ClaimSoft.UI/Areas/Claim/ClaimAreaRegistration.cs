using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.Claim
{
    public class ClaimAreaRegistration : AreaRegistration
    {
        public override string AreaName => "Claim";

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Claim_default",
                "Claim/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}