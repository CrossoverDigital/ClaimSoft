using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class PagesController : Controller
    {
        public ActionResult Error_404() => View();

        public ActionResult Lock() => View();

        public ActionResult Login() => View();

        public ActionResult Recover() => View();

        public ActionResult Register() => View();

        public ActionResult Template() => View();

        public ActionResult Maintenance() => View();

        public ActionResult Error_500() => View();
    }
}