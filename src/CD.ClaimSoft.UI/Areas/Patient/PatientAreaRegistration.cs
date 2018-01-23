using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.Patient
{
    public class PatientAreaRegistration : AreaRegistration
    {
        public override string AreaName => "Patient";

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Patient_default",
                "Patient/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}