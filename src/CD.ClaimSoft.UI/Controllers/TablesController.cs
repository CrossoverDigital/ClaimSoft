using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class TablesController : Controller
    {
        public ActionResult TableJQGrid()
        {
            return View();
        }
        public ActionResult TableDatatable()
        {
            return View();
        }
        public ActionResult TableExtended()
        {
            return View();
        }
        public ActionResult TableStandard()
        {
            return View();
        }

    }
}