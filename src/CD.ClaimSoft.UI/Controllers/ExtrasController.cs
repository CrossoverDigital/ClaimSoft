using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class ExtrasController : Controller
    {
        public ActionResult Calendar() => View();

        public ActionResult Invoice() => View();

        public ActionResult Mailbox() => View();

        public ActionResult UserProfile() => View();

        public ActionResult Search() => View();

        public ActionResult Timeline() => View();

        public ActionResult Todo() => View();

        public ActionResult Contacts() => View();

        public ActionResult ContactDetails() => View();

        public ActionResult Projects() => View();

        public ActionResult ProjectDetails() => View();

        public ActionResult TeamViewer() => View();

        public ActionResult SocialBoard() => View();

        public ActionResult VoteLinks() => View();

        public ActionResult BugTracker() => View();

        public ActionResult Faq() => View();

        public ActionResult HelpCenter() => View();

        public ActionResult Followers() => View();

        public ActionResult Settings() => View();

        public ActionResult Plans() => View();

        public ActionResult FileManager() => View();
    }
}