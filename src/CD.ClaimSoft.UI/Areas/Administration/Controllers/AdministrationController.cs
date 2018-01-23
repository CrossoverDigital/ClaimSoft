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
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;

using CD.ClaimSoft.Application.Administration;
using CD.ClaimSoft.Application.Models.Agencies;
using CD.ClaimSoft.Common.Helpers;
using CD.ClaimSoft.Common.Utlilty;
using CD.ClaimSoft.Database.FileTable;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.UI.Common;

using Microsoft.AspNet.Identity;

using Syncfusion.JavaScript.Models;

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
        /// Called to render the Agency view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        public ActionResult Agency()
        {
            ViewBag.datasource = _agencyManager.GetAgencies();

            return View();
        }

        /// <summary>
        /// Called to render the Agency Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpGet]
        public ActionResult AgencyEdit()
        {
            var agencyTenantId = "TENANT-ID-NOT-SET";

            if (Request.QueryString["TenantId"] != null)
                agencyTenantId = Request.QueryString["TenantId"];

            var agency = _agencyManager.GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            return PartialView("_AgencyEdit", agency);
        }

        /// <summary>
        /// The agency details.
        /// </summary>
        /// <param name="agencyTenantId">The agency tenant identifier.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyDetail(string agencyTenantId)
        {
            var agency = _agencyManager.GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            ViewBag.AgencyNumberDataSource = agency.AgencyNumbers.ToList();

            InitDropDowns();

            return PartialView("_AgencyDetail", agency);
        }

        private void InitDropDowns()
        {
            var parentAgencyDdlProperties = new DropDownListProperties();
            var parentAgencyDdlFields = new DropDownListFields();

            parentAgencyDdlProperties.DataSource = _agencyManager.GetAgencies();

            parentAgencyDdlFields.Text = "Name";
            parentAgencyDdlFields.Value = "Id";

            parentAgencyDdlProperties.DropDownListFields = parentAgencyDdlFields;

            ViewData["ParentAgencyDDL"] = parentAgencyDdlProperties;
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

                        var destinationPath = Path.Combine(value.AgencyTenantId, fileContent.FileName);

                        var target = new MemoryStream();

                        fileContent.InputStream.CopyTo(target);

                        var data = target.ToArray();

                        FileTableExtensions.CreateFile("_AgencyLogo", destinationPath, data, out var logoStreamId);

                        value.LogoStreamId = logoStreamId;
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
        /// The agency addresses.
        /// </summary>
        /// <param name="agencyTenantId">The agency tenant identifier.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyAddress(string agencyTenantId)
        {
            var agency = _agencyManager.GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            ViewBag.AgencyAddressDataSource = agency.AgencyAddresses.ToList();

            InitDropDowns();

            return PartialView("_AgencyAddress", agency);
        }

        /// <summary>
        /// Called to render the Agency Address Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpGet]
        public ActionResult AgencyAddressAdd()
        {
            var agencyId = 0;

            if (Request.QueryString["Id"] != null)
                agencyId = int.Parse(Request.QueryString["Id"]);

            var agencyAddress = new AgencyAddress
            {
                AgencyId = agencyId
            };

            return PartialView("_AgencyAddressEdit", agencyAddress);
        }

        /// <summary>
        /// Called to render the Agency Address Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpGet]
        public ActionResult AgencyAddressEdit()
        {
            var agencyAddressId = 0;

            if (Request.QueryString["Id"] != null)
                agencyAddressId = int.Parse(Request.QueryString["Id"]);

            var agencyAddress = _agencyManager.GetAgencyAddress(agencyAddressId);

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

        #region Agency Number Methods

        /// <summary>
        /// Called to render the Agency Number Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpGet]
        public ActionResult AgencyNumberAdd()
        {
            var agencyId = 0;

            if (Request.QueryString["Id"] != null)
                agencyId = int.Parse(Request.QueryString["Id"]);

            return PartialView("_AgencyNumberEdit", new AgencyNumber
            {
                AgencyId = agencyId
            });
        }

        /// <summary>
        /// Called to render the Agency Number Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpGet]
        public ActionResult AgencyNumberEdit()
        {
            var numberId = 0;

            if (Request.QueryString["Id"] != null)
                numberId = int.Parse(Request.QueryString["Id"]);

            var agencyNumber = _agencyManager.GetAgencyNumber(numberId);

            return PartialView("_AgencyNumberEdit", agencyNumber);
        }

        /// <summary>
        /// Performs the agency number insert.
        /// </summary>
        /// <param name="value">The agency number to insert.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyNumberInsert(AgencyNumber value)
        {
            var now = DateTime.Now;

            value.CreateBy = User.Identity.GetUserName();
            value.CreateDate = now;
            value.LastModifyBy = User.Identity.GetUserName();
            value.LastModifyDate = now;

            var result = _agencyManager.CreateAgencyNumber(value);

            return Json(result.GetReturnObject<AgencyNumber>(), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Performs the agency number update.
        /// </summary>
        /// <param name="value">The agency number with the changes from the form submission.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyNumberUpdate(AgencyNumber value)
        {
            value.LastModifyBy = User.Identity.GetUserName();
            value.LastModifyDate = DateTime.Now;

            var result = _agencyManager.UpdateAgencyNumber(value);

            return Json(value, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Performs the agency number deletion.
        /// </summary>
        /// <param name="value">The agency number to delete.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyNumberDelete(AgencyNumber value)
        {
            var result = _agencyManager.DeleteAgencyNumber(value);

            return Json(value, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Agency Phone/Email Methods

        /// <summary>
        /// The agency phone numbers and email addresses.
        /// </summary>
        /// <param name="agencyTenantId">The agency tenant identifier.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyPhoneEmail(string agencyTenantId)
        {
            var agency = _agencyManager.GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            ViewBag.AgencyPhoneDataSource = agency.AgencyPhones.ToList();
            ViewBag.AgencyEmailDataSource = agency.AgencyEmails.ToList();

            return PartialView("_AgencyPhoneEmail", agency);
        }

        /// <summary>
        /// Called to render the Agency Phone Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpGet]
        public ActionResult AgencyPhoneAdd()
        {
            var agencyId = 0;

            if (Request.QueryString["Id"] != null)
                agencyId = int.Parse(Request.QueryString["Id"]);

            var agencyPhone = new AgencyPhone
            {
                AgencyId = agencyId
            };

            return PartialView("_AgencyPhoneEdit", agencyPhone);
        }

        /// <summary>
        /// Called to render the Agency Phone Edit partial view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        [HttpGet]
        public ActionResult AgencyPhoneEdit()
        {
            var agencyPhoneId = 0;

            if (Request.QueryString["Id"] != null)
                agencyPhoneId = int.Parse(Request.QueryString["Id"]);

            var agencyPhone = _agencyManager.GetAgencyPhone(agencyPhoneId);

            return PartialView("_AgencyPhoneEdit", agencyPhone);
        }

        /// <summary>
        /// Performs the agency phone insert.
        /// </summary>
        /// <param name="value">The agency phone to insert.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyPhoneInsert(AgencyPhone value)
        {
            var now = DateTime.Now;

            value.CreateBy = User.Identity.GetUserName();
            value.CreateDate = now;
            value.LastModifyBy = User.Identity.GetUserName();
            value.LastModifyDate = now;

            var result = _agencyManager.CreateAgencyPhone(value);

            return Json(result.GetReturnObject<AgencyPhone>(), JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Performs the agency phone update.
        /// </summary>
        /// <param name="value">The agency phone with the changes from the form submission.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyPhoneUpdate(AgencyPhone value)
        {
            value.LastModifyBy = User.Identity.GetUserName();
            value.LastModifyDate = DateTime.Now;

            var result = _agencyManager.UpdateAgencyPhone(value);

            return Json(value, JsonRequestBehavior.AllowGet);
        }

        /// <summary>
        /// Performs the agency phone deletion.
        /// </summary>
        /// <param name="value">The agency phone to delete.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyPhoneDelete(AgencyPhone value)
        {
            var result = _agencyManager.DeleteAgencyPhone(value);

            return Json(value, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Agency Phone/Email Methods

        /// <summary>
        /// The agencynotes and attachments.
        /// </summary>
        /// <param name="agencyTenantId">The agency tenant identifier.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyNotesAttachments(string agencyTenantId)
        {
            var agency = _agencyManager.GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            return PartialView("_AgencyNotesAttachments", agency);
        }

        #endregion

        #region Log Upload

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