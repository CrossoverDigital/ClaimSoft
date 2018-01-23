using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class TablesController : Controller
    {
        public ActionResult TableJQGrid() => View();

        public ActionResult TableDatatable() => View();

        public ActionResult TableExtended() => View();

        public ActionResult TableStandard() => View();
    }
}