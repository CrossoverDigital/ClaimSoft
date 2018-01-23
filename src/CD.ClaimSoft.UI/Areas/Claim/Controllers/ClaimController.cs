using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.Claim.Controllers
{
    public class ClaimController : Controller
    {
        // GET: Claim/Claim
        public ActionResult Index() => View();

        // GET: Claim/Claim/Details/5
        public ActionResult Details(int id) => View();

        // GET: Claim/Claim/Create
        public ActionResult Create() => View();

        // POST: Claim/Claim/Create
        [HttpPost]
        public ActionResult Create(FormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Claim/Claim/Edit/5
        public ActionResult Edit(int id) => View();

        // POST: Claim/Claim/Edit/5
        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        // GET: Claim/Claim/Delete/5
        public ActionResult Delete(int id) => View();

        // POST: Claim/Claim/Delete/5
        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
