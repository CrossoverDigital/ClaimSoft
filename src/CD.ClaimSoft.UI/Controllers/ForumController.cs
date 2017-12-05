using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class ForumController : Controller
    {
        public ActionResult ForumCategories()
        {
            return View();
        }
        public ActionResult ForumTopics()
        {
            return View();
        }
        public ActionResult ForumDiscussion()
        {
            return View();
        }
    }
}