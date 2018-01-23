using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.Note.Controllers
{
    public class NoteController : Controller
    {
        // GET: Note/Note
        public ActionResult Index() => View();

        // GET: Note/Note/Details/5
        public ActionResult Details(int id) => View();

        // GET: Note/Note/Create
        public ActionResult Create() => View();

        // POST: Note/Note/Create
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

        // GET: Note/Note/Edit/5
        public ActionResult Edit(int id) => View();

        // POST: Note/Note/Edit/5
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

        // GET: Note/Note/Delete/5
        public ActionResult Delete(int id) => View();

        // POST: Note/Note/Delete/5
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
