using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Controllers
{
    [Authorize]
    public class FormsController : Controller
    {
        public ActionResult FormExtended() => View();

        public ActionResult FormStandard() => View();

        public ActionResult FormValidation() => View();

        public ActionResult FormUpload() => View();

        public ActionResult FormWizard() => View();

        public ActionResult FormXEditable() => View();

        public ActionResult FormImgCrop() => View();
    }
}