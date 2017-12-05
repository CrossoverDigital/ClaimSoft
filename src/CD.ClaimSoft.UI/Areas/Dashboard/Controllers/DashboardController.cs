using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.Dashboard.Controllers
{
    [Authorize]
    public class DashboardController : Controller
    {
        // GET: Dashboard
        public ActionResult Index()
        {
            return View();
        }
    }
}