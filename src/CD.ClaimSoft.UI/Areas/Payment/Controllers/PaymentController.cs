using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.Payment.Controllers
{
    public class PaymentController : Controller
    {
        // GET: Payment/PaymentsIndex
        public ActionResult PaymentsIndex()
        {
            return View();
        }

        // GET: Payment/BatchesIndex
        public ActionResult BatchesIndex()
        {
            return View();
        }

        // GET: Payment/Payment/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Payment/Payment/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Payment/Payment/Create
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

        // GET: Payment/Payment/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Payment/Payment/Edit/5
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

        // GET: Payment/Payment/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Payment/Payment/Delete/5
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
