using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class BlogController : Controller
    {
        public ActionResult Blog()
        {
            return View();
        }
        public ActionResult BlogArticles()
        {
            return View();
        }
        public ActionResult BlogArticleView()
        {
            return View();
        }
        public ActionResult BlogPost()
        {
            return View();
        }
    }
}