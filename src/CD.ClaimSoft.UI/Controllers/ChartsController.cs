using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class ChartsController : Controller
    {
        public ActionResult ChartFlot()
        {
            return View();
        }
        public ActionResult ChartRadial()
        {
            return View();
        }
        public ActionResult ChartJS()
        {
            return View();
        }
        public ActionResult ChartChartist()
        {
            return View();
        }
        public ActionResult ChartMorris()
        {
            return View();
        }
        public ActionResult ChartRickshaw()
        {
            return View();
        }
    }
}