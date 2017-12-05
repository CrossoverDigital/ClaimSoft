using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class EcommerceController : Controller
    {
        public ActionResult EcommerceOrders()
        {
            return View();
        }
        public ActionResult EcommerceOrderView()
        {
            return View();
        }
        public ActionResult EcommerceProducts()
        {
            return View();
        }
        public ActionResult EcommerceProductView()
        {
            return View();
        }
        public ActionResult EcommerceCheckout()
        {
            return View();
        }
    }
}