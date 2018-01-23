using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.Patient.Controllers
{
    public class PatientController : Controller
    {
        // GET: Patient/Patient
        public ActionResult Index() => View();

        // GET: Patient/Patient/Details/5
        public ActionResult Details(int id) => View();

        // GET: Patient/Patient/Create
        public ActionResult Create() => View();

        // POST: Patient/Patient/Create
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

        // GET: Patient/Patient/Edit/5
        public ActionResult Edit(int id) => View();

        // POST: Patient/Patient/Edit/5
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

        // GET: Patient/Patient/Delete/5
        public ActionResult Delete(int id) => View();

        // POST: Patient/Patient/Delete/5
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
