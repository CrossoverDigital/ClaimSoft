using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.ImportExport.Controllers
{
    public class ImportExportController : Controller
    {
        // GET: ImportExport/ImportExport
        public ActionResult Index() => View();

        // GET: ImportExport/ImportExport/Details/5
        public ActionResult Details(int id) => View();

        // GET: ImportExport/ImportExport/Create
        public ActionResult Create() => View();

        // POST: ImportExport/ImportExport/Create
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

        // GET: ImportExport/ImportExport/Edit/5
        public ActionResult Edit(int id) => View();

        // POST: ImportExport/ImportExport/Edit/5
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

        // GET: ImportExport/ImportExport/Delete/5
        public ActionResult Delete(int id) => View();

        // POST: ImportExport/ImportExport/Delete/5
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
