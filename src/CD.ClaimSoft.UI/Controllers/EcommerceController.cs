using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class EcommerceController : Controller
    {
        public ActionResult EcommerceOrders() => View();

        public ActionResult EcommerceOrderView() => View();

        public ActionResult EcommerceProducts() => View();

        public ActionResult EcommerceProductView() => View();

        public ActionResult EcommerceCheckout() => View();
    }
}