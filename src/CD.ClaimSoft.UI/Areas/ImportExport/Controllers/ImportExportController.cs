using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using CD.ClaimSoft.Application.Administration;
using CD.ClaimSoft.Application.Domain;
using CD.ClaimSoft.Application.File.Import;
using CD.ClaimSoft.Application.User;
using CD.ClaimSoft.Common.Helpers;
using CD.ClaimSoft.Database.FileTable;
using CD.ClaimSoft.Database.Model.Agency;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;
using CD.ClaimSoft.UI.Common;

using Microsoft.AspNet.Identity;

namespace CD.ClaimSoft.UI.Areas.ImportExport.Controllers
{
    /// <inheritdoc />
    /// <summary>
    /// Controller that manages the Import/Export area.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.UI.Common.BaseController" />
    public class ImportExportController : BaseController
    {
        #region Instance Variables

        /// <summary>
        /// The log service.
        /// </summary>
        private readonly ILogService<ImportExportController> _logService;

        /// <summary>
        /// The agency manager.
        /// </summary>
        private readonly IAgencyManager _agencyManager;

        /// <summary>
        /// The import manager
        /// </summary>
        private readonly IImportManager _importManager;
        
        /// <summary>
        /// The domain list manager.
        /// </summary>
        private readonly IDomainListManager _domainListManager;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="ImportExportController" /> class.
        /// </summary>
        /// <param name="logService">The log service.</param>
        /// <param name="agencyManager">The agency manager.</param>
        /// <param name="domainListManager">The domain list manager.</param>
        /// <param name="importManager">The import manager.</param>
        public ImportExportController(ILogService<ImportExportController> logService, IAgencyManager agencyManager, IDomainListManager domainListManager, IImportManager importManager)
        {
            _logService = logService;
            _agencyManager = agencyManager;
            _domainListManager = domainListManager;
            _importManager = importManager;
        }

        #endregion

        // GET: ImportExport/ImportExport
        public ActionResult Index()
        {
            var agency = (Agency)Session[CacheConstants.CurrentUserAgencyKey];

            ViewBag.DataSource = _agencyManager.GetAgencyFiles(agency.AgencyId).ToList();

            return View();
        }

        public JsonResult DataSource()
        {
            var agency = (Agency)Session[CacheConstants.CurrentUserAgencyKey];

            return Json(_agencyManager.GetAgencyFiles(agency.AgencyId).ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult UploadFiles(IEnumerable<HttpPostedFileBase> DragAndDrop)
        {
            try
            {
                var agency = (Agency)Session[CacheConstants.CurrentUserAgencyKey];

                foreach (var file in DragAndDrop)
                {
                    var fileName = Path.GetFileName(file.FileName);

                    var destinationPath = Path.Combine(agency.AgencyId.ToString(), fileName);

                    var target = new MemoryStream();

                    file.InputStream.CopyTo(target);

                    FileTableExtensions.CreateFile("_AgencyImport", destinationPath, target.ToArray(), out var fileStreamId);

                    var fileTypeId = _domainListManager.GetFileTypeList().First(ft => ft.Name == "Nemsis").Id;

                    var now = DateTime.UtcNow;
                    _agencyManager.InsertAgencyFile(new AgencyFile
                    {
                        AgencyId = agency.AgencyId,
                        StreamId = fileStreamId.ToString(),
                        Name = fileName,
                        FileTypeId = fileTypeId,
                        CreateBy = User.Identity.GetUserName(),
                        CreateDate = now,
                        LastModifyBy = User.Identity.GetUserName(),
                        LastModifyDate = now
                    });
                }

                return Content("Success");
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                return Content(ex.GetFullMessage());
            }
        }
        public ActionResult DeleteFiles(string[] fileNames)
        {
            foreach (var fullName in fileNames)
            {
                var fileName = Path.GetFileName(fullName);
                var physicalPath = Path.Combine(Server.MapPath("~/App_Data"), fileName);
                if (System.IO.File.Exists(physicalPath))
                {
                    System.IO.File.Delete(physicalPath);
                }
            }
            return Content("");
        }


        /// <summary>
        /// Processes the file.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="streamId">The stream identifier.</param>
        /// <returns></returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ProcessFile(string fileName, string streamId)
        {
            var agency = (Agency)Session[CacheConstants.CurrentUserAgencyKey];

            var result = _importManager.ProcessFile(fileName, streamId, User.Identity.GetUserId(), agency.AgencyId);

            return Json(result, JsonRequestBehavior.AllowGet);
        }
    }
}
