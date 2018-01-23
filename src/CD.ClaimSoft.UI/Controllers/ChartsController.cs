using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class ChartsController : Controller
    {
        public ActionResult ChartFlot() => View();

        public ActionResult ChartRadial() => View();

        public ActionResult ChartJS() => View();

        public ActionResult ChartChartist() => View();

        public ActionResult ChartMorris() => View();

        public ActionResult ChartRickshaw() => View();
    }
}