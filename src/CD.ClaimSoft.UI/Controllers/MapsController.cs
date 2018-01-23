using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class MapsController : Controller
    {
        public ActionResult MapsGoogle() => View();

        public ActionResult MapsVector() => View();
    }
}