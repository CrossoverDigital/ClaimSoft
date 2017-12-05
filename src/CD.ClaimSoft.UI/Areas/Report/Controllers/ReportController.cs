using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CD.ClaimSoft.UI.Areas.Report.Controllers
{
    public class ReportController : Controller
    {
        // GET: Report/Report
        public ActionResult Index()
        {
            return View();
        }

        // GET: Report/Report/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Report/Report/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Report/Report/Create
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

        // GET: Report/Report/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Report/Report/Edit/5
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

        // GET: Report/Report/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Report/Report/Delete/5
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
