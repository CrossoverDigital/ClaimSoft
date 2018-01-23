using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.Note
{
    public class NoteAreaRegistration : AreaRegistration
    {
        public override string AreaName => "Note";

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "Note_default",
                "Note/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}