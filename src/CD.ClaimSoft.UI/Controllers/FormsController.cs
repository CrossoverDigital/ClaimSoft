using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class FormsController : Controller
    {
        public ActionResult FormExtended()
        {
            return View();
        }

        public ActionResult FormStandard()
        {
            return View();
        }

        public ActionResult FormValidation()
        {
            return View();
        }

        public ActionResult FormUpload()
        {
            return View();
        }

        public ActionResult FormWizard()
        {
            return View();
        }

        public ActionResult FormXEditable()
        {
            return View();
        }
        public ActionResult FormImgCrop()
        {
            return View();
        }
    }
}