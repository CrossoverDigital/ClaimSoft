using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class MultilevelsController : Controller
    {
        public ActionResult Multilevel_1()
        {
            return View();
        }
        public ActionResult Multilevel_3()
        {
            return View();
        }
    }
}