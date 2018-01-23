using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class ForumController : Controller
    {
        public ActionResult ForumCategories() => View();

        public ActionResult ForumTopics() => View();

        public ActionResult ForumDiscussion() => View();
    }
}