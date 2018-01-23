using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.ImportExport
{
    public class ImportExportAreaRegistration : AreaRegistration
    {
        public override string AreaName => "ImportExport";

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "ImportExport_default",
                "ImportExport/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}