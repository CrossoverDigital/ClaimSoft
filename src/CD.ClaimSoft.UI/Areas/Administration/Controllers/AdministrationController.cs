#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Web;
using System.Web.Mvc;

using CD.ClaimSoft.Application.Administration;
using CD.ClaimSoft.Common.Helpers;
using CD.ClaimSoft.Common.Utlilty;
using CD.ClaimSoft.Database.FileTable;
using CD.ClaimSoft.Database.Model.Agency;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.UI.Common;

using Microsoft.AspNet.Identity;

namespace CD.ClaimSoft.UI.Areas.Administration.Controllers
{
    /// <inheritdoc />
    /// <summary>
    /// Controller that manages the administration area.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.UI.Common.BaseController" />
    public class AdministrationController : BaseController
    {
        #region Instance Variables

        /// <summary>
        /// The log service.
        /// </summary>
        private readonly ILogService<AdministrationController> _logService;

        /// <summary>
        /// The agency manager.
        /// </summary>
        private readonly IAgencyManager _agencyManager;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="AdministrationController" /> class.
        /// </summary>
        /// <param name="logService">The log service.</param>
        /// <param name="agencyManager">The agency manager.</param>
        public AdministrationController(ILogService<AdministrationController> logService, IAgencyManager agencyManager)
        {
            _logService = logService;
            _agencyManager = agencyManager;
        }

        #endregion

        #region Agency Methods
        
        /// <summary>
        /// Called to render the Agency Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyDetail(Agency model)
        {
            return PartialView("_AgencyDetail", model);
        }






        /// <summary>
        /// Called to render the Agency view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        public ActionResult Agency()
        {
            return View();
        }

        [HttpGet]
        public ActionResult AgencyAdd()
        {
            return PartialView("_AgencyEdit", new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            });
        }

        /// <summary>
        /// Called to render the Agency Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyEdit(Agency model)
        {
            return PartialView("_AgencyEdit", model);
        }

        /// <summary>
        /// Performs the agency insert.
        /// </summary>
        /// <param name="value">The new agency from the form submission.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyInsert(Agency value)
        {
            var now = DateTime.Now;

            value.CreateBy = User.Identity.GetUserName();
            value.CreateDate = now;
            value.LastModifyBy = User.Identity.GetUserName();
            value.LastModifyDate = now;

            var result = _agencyManager.CreateAgency(value);

            return Json(result.GetReturnObject<Agency>(), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Performs the agency update.
        /// </summary>
        /// <param name="value">The agency with the changes from the form submission.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyUpdate(Agency value)
        {
            try
            {
                foreach (string file in Request.Files)
                {
                    var fileContent = Request.Files[file];
                    if (fileContent != null && fileContent.ContentLength > 0)
                    {
                        value.LogoFileName = fileContent.FileName;

                        var destinationPath = Path.Combine(value.AgencyNumber, fileContent.FileName);

                        var target = new MemoryStream();

                        fileContent.InputStream.CopyTo(target);

                        var data = target.ToArray();

                        FileTableExtensions.CreateFile("_AgencyLogo", destinationPath, data, out var logoStreamId);

                        value.LogoStreamId = logoStreamId.ToString();
                    }
                }

                value.LastModifyBy = User.Identity.GetUserName();
                value.LastModifyDate = DateTime.Now;

                var result = _agencyManager.UpdateAgency(value);
            }
            catch (Exception)
            {
                Response.StatusCode = (int)HttpStatusCode.BadRequest;
                return Json("Agency update failed!");
            }

            return Json("Agency updated successfully!");
        }

        #endregion

        #region Agency Address Methods

        /// <summary>
        /// Called to render the Agency Address Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyAddressAdd(int agencyId)
        {
            return PartialView("_AgencyAddressEdit", new AgencyAddress
            {
                AgencyId = agencyId
            });
        }

        /// <summary>
        /// Called to render the Agency Address Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyAddressEdit(AgencyAddress agencyAddress)
        {
            return PartialView("_AgencyAddressEdit", agencyAddress);
        }

        /// <summary>
        /// Performs the agency address insert.
        /// </summary>
        /// <param name="value">The agency address to insert.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyAddressInsert(AgencyAddress value)
        {
            var now = DateTime.Now;

            value.CreateBy = User.Identity.GetUserName();
            value.CreateDate = now;
            value.LastModifyBy = User.Identity.GetUserName();
            value.LastModifyDate = now;

            var result = _agencyManager.CreateAgencyAddress(value);

            return Json(result.GetReturnObject<AgencyAddress>(), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Performs the agency address update.
        /// </summary>
        /// <param name="value">The agency address with the changes from the form submission.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyAddressUpdate(AgencyAddress value)
        {
            value.LastModifyBy = User.Identity.GetUserName();
            value.LastModifyDate = DateTime.Now;

            var result = _agencyManager.UpdateAgencyAddress(value);

            return Json(value, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Performs the agency address deletion.
        /// </summary>
        /// <param name="value">The agency address to delete.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyAddressDelete(AgencyAddress value)
        {
            var result = _agencyManager.DeleteAgencyAddress(value);

            return Json(value, JsonRequestBehavior.AllowGet);
        }

        #endregion
        
        #region Agency Notes and Attachments Methods

        /// <summary>
        /// The agency notes and attachments.
        /// </summary>
        /// <param name="agencyId">The agency identifier.</param>
        /// <returns>
        /// The result of this action method.
        /// </returns>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult AgencyNotesAttachments(string agencyId)
        {
            var agency = new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            return PartialView("_AgencyNotesAttachments", agency);
        }

        #endregion

        #region Logo Upload

        /// <summary>
        /// Saves the logo.
        /// </summary>
        /// <param name="UploadLogo">The upload logo.</param>
        /// <param name="UploadLogo_data">The upload logo data.</param>
        /// <returns></returns>
        public ActionResult SaveLogo(IEnumerable<HttpPostedFileBase> UploadLogo, string UploadLogo_data)
        {
            try
            {
                foreach (var file in UploadLogo)
                {
                    var fileName = Path.GetFileName(file.FileName);

                    var destinationPath = Path.Combine(FileUtility.RemoveInvalidCharacters(UploadLogo_data), fileName);

                    var target = new MemoryStream();
                    file.InputStream.CopyTo(target);
                    var data = target.ToArray();

                    FileTableExtensions.CreateFile("_AgencyLogo", destinationPath, data, out var test);

                    //file.SaveAs(destinationPath);
                }

                return Content("Success");
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                return Content(ex.GetFullMessage());
            }
        }

        #endregion

        // GET: Administration/Administration
        public ActionResult Users() => View();
    }
}