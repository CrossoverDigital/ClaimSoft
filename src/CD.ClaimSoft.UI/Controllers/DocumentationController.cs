using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class DocumentationController : Controller
    {
        // GET: Documentation
        public ActionResult Index()
        {
            return View();
        }
    }
}