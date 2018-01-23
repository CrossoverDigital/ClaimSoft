using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class BlogController : Controller
    {
        public ActionResult Blog() => View();

        public ActionResult BlogArticles() => View();

        public ActionResult BlogArticleView() => View();

        public ActionResult BlogPost() => View();
    }
}