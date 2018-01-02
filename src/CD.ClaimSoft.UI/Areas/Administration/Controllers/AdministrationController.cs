using System;
using System.Linq;
using System.Web.Mvc;

using CD.ClaimSoft.Application.Administration;
using CD.ClaimSoft.Application.Domain;
using CD.ClaimSoft.Application.Models.Agencies;
using CD.ClaimSoft.UI.Common;

using Microsoft.AspNet.Identity;
using Syncfusion.JavaScript.Models;

namespace CD.ClaimSoft.UI.Areas.Administration.Controllers
{
    public class AdministrationController : BaseController
    {
        #region Agency Methods

        /// <summary>
        /// Called to render the Agency view.
        /// </summary>
        /// <returns>The result of this action method.</returns>
        public ActionResult Agency()
        {
            ViewBag.datasource = new AgencyManager().GetAgencies();

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

            var agency = new AgencyManager().GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            return PartialView("_AgencyEdit", agency);
        }

        /// <summary>
        /// Agencies the detail.
        /// </summary>
        /// <param name="agency">The agency.</param>
        /// <returns>The result of this action method.</returns>
        [HttpPost]
        public ActionResult AgencyDetail(string agencyTenantId)
        {
            //var agencyTenantId = "4886079D-7E30-4713-9015-599BBEFAB640";
            ////"TENANT-ID-NOT-SET";

            //if (Request.QueryString["TenantId"] != null)
            //    agencyTenantId = Request.QueryString["TenantId"];

            var agency = new AgencyManager().GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            ViewBag.AgencyAddressDataSource = agency.AgencyAddresses.ToList();
            ViewBag.AgencyPhoneDataSource = agency.AgencyPhones.ToList();
            ViewBag.AgencyNumberDataSource = agency.AgencyNumbers.ToList();

            var parentAgencyDdlProperties = new DropDownListProperties();
            var parentAgencyDdlFields = new DropDownListFields();

            parentAgencyDdlProperties.DataSource = new AgencyManager().GetAgencies();

            parentAgencyDdlFields.Text = "Name";
            parentAgencyDdlFields.Value = "Id";

            parentAgencyDdlProperties.DropDownListFields = parentAgencyDdlFields;

            ViewData["ParentAgencyDDL"] = parentAgencyDdlProperties;

            var timeZoneDdlProperties = new DropDownListProperties();
            var timeZoneDdlFields = new DropDownListFields();

            timeZoneDdlProperties.DataSource = DomainListManager.GetTimeZones();

            timeZoneDdlFields.Text = "StandardName";
            timeZoneDdlFields.Value = "Id";

            timeZoneDdlProperties.DropDownListFields = timeZoneDdlFields;

            ViewData["TimeZoneDDL"] = timeZoneDdlProperties;

            return PartialView("_AgencyDetail", agency);
        }

        [HttpPost]
        public ActionResult AgencyProvider()
        {
            var agencyTenantId = "4886079D-7E30-4713-9015-599BBEFAB640";
            //"TENANT-ID-NOT-SET";

            if (Request.QueryString["TenantId"] != null)
                agencyTenantId = Request.QueryString["TenantId"];

            var agency = new AgencyManager().GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            ViewBag.AgencyAddressDataSource = agency.AgencyAddresses.ToList();
            ViewBag.AgencyPhoneDataSource = agency.AgencyPhones.ToList();
            ViewBag.AgencyNumberDataSource = agency.AgencyNumbers.ToList();

            var parentAgencyDdlProperties = new DropDownListProperties();
            var parentAgencyDdlFields = new DropDownListFields();

            parentAgencyDdlProperties.DataSource = new AgencyManager().GetAgencies();

            parentAgencyDdlFields.Text = "Name";
            parentAgencyDdlFields.Value = "Id";

            parentAgencyDdlProperties.DropDownListFields = parentAgencyDdlFields;

            ViewData["ParentAgencyDDL"] = parentAgencyDdlProperties;

            var timeZoneDdlProperties = new DropDownListProperties();
            var timeZoneDdlFields = new DropDownListFields();

            timeZoneDdlProperties.DataSource = DomainListManager.GetTimeZones();

            timeZoneDdlFields.Text = "StandardName";
            timeZoneDdlFields.Value = "Id";

            timeZoneDdlProperties.DropDownListFields = timeZoneDdlFields;

            ViewData["TimeZoneDDL"] = timeZoneDdlProperties;

            return PartialView("_AgencyProvider", agency);
        }

        [HttpPost]
        public ActionResult AgencyAddress()
        {
            var agencyTenantId = "4886079D-7E30-4713-9015-599BBEFAB640";
            //"TENANT-ID-NOT-SET";

            if (Request.QueryString["TenantId"] != null)
                agencyTenantId = Request.QueryString["TenantId"];

            var agency = new AgencyManager().GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            ViewBag.AgencyAddressDataSource = agency.AgencyAddresses.ToList();
            ViewBag.AgencyPhoneDataSource = agency.AgencyPhones.ToList();
            ViewBag.AgencyNumberDataSource = agency.AgencyNumbers.ToList();

            var parentAgencyDdlProperties = new DropDownListProperties();
            var parentAgencyDdlFields = new DropDownListFields();

            parentAgencyDdlProperties.DataSource = new AgencyManager().GetAgencies();

            parentAgencyDdlFields.Text = "Name";
            parentAgencyDdlFields.Value = "Id";

            parentAgencyDdlProperties.DropDownListFields = parentAgencyDdlFields;

            ViewData["ParentAgencyDDL"] = parentAgencyDdlProperties;

            var timeZoneDdlProperties = new DropDownListProperties();
            var timeZoneDdlFields = new DropDownListFields();

            timeZoneDdlProperties.DataSource = DomainListManager.GetTimeZones();

            timeZoneDdlFields.Text = "StandardName";
            timeZoneDdlFields.Value = "Id";

            timeZoneDdlProperties.DropDownListFields = timeZoneDdlFields;

            ViewData["TimeZoneDDL"] = timeZoneDdlProperties;

            return PartialView("_AgencyAddress", agency);
        }

        [HttpPost]
        public ActionResult AgencyPhone()
        {
            var agencyTenantId = "4886079D-7E30-4713-9015-599BBEFAB640";
            //"TENANT-ID-NOT-SET";

            if (Request.QueryString["TenantId"] != null)
                agencyTenantId = Request.QueryString["TenantId"];

            var agency = new AgencyManager().GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            ViewBag.AgencyAddressDataSource = agency.AgencyAddresses.ToList();
            ViewBag.AgencyPhoneDataSource = agency.AgencyPhones.ToList();
            ViewBag.AgencyNumberDataSource = agency.AgencyNumbers.ToList();

            var parentAgencyDdlProperties = new DropDownListProperties();
            var parentAgencyDdlFields = new DropDownListFields();

            parentAgencyDdlProperties.DataSource = new AgencyManager().GetAgencies();

            parentAgencyDdlFields.Text = "Name";
            parentAgencyDdlFields.Value = "Id";

            parentAgencyDdlProperties.DropDownListFields = parentAgencyDdlFields;

            ViewData["ParentAgencyDDL"] = parentAgencyDdlProperties;

            var timeZoneDdlProperties = new DropDownListProperties();
            var timeZoneDdlFields = new DropDownListFields();

            timeZoneDdlProperties.DataSource = DomainListManager.GetTimeZones();

            timeZoneDdlFields.Text = "StandardName";
            timeZoneDdlFields.Value = "Id";

            timeZoneDdlProperties.DropDownListFields = timeZoneDdlFields;

            ViewData["TimeZoneDDL"] = timeZoneDdlProperties;

            return PartialView("_AgencyPhone", agency);
        }

        [HttpPost]
        public ActionResult AgencyEmail()
        {
            var agencyTenantId = "4886079D-7E30-4713-9015-599BBEFAB640";
            //"TENANT-ID-NOT-SET";

            if (Request.QueryString["TenantId"] != null)
                agencyTenantId = Request.QueryString["TenantId"];

            var agency = new AgencyManager().GetAgencies().SingleOrDefault(a => a.AgencyTenantId == agencyTenantId) ?? new Agency
            {
                CreateBy = User.Identity.GetUserName(),
                LastModifyBy = User.Identity.GetUserName()
            };

            ViewBag.AgencyAddressDataSource = agency.AgencyAddresses.ToList();
            ViewBag.AgencyPhoneDataSource = agency.AgencyPhones.ToList();
            ViewBag.AgencyNumberDataSource = agency.AgencyNumbers.ToList();

            var parentAgencyDdlProperties = new DropDownListProperties();
            var parentAgencyDdlFields = new DropDownListFields();

            parentAgencyDdlProperties.DataSource = new AgencyManager().GetAgencies();

            parentAgencyDdlFields.Text = "Name";
            parentAgencyDdlFields.Value = "Id";

            parentAgencyDdlProperties.DropDownListFields = parentAgencyDdlFields;

            ViewData["ParentAgencyDDL"] = parentAgencyDdlProperties;

            var timeZoneDdlProperties = new DropDownListProperties();
            var timeZoneDdlFields = new DropDownListFields();

            timeZoneDdlProperties.DataSource = DomainListManager.GetTimeZones();

            timeZoneDdlFields.Text = "StandardName";
            timeZoneDdlFields.Value = "Id";

            timeZoneDdlProperties.DropDownListFields = timeZoneDdlFields;

            ViewData["TimeZoneDDL"] = timeZoneDdlProperties;

            return PartialView("_AgencyEmail", agency);
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

            var result = new AgencyManager().CreateAgency(value);

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
            value.LastModifyBy = User.Identity.GetUserName();
            value.LastModifyDate = DateTime.Now;

            var result = new AgencyManager().UpdateAgency(value);

            return Json(value, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Agency Address Methods

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

            var countyDdlProperties = new DropDownListProperties();
            var countyDdlFields = new DropDownListFields();

            countyDdlProperties.DataSource = DomainListManager.GetCountyList();

            countyDdlFields.Text = "Name";
            countyDdlFields.Value = "Id";

            countyDdlProperties.DropDownListFields = countyDdlFields;

            ViewData["CountyDDL"] = countyDdlProperties;

            var stateDdlProperties = new DropDownListProperties();
            var stateDdlFields = new DropDownListFields();

            stateDdlProperties.DataSource = DomainListManager.GetStateList();

            stateDdlFields.Text = "Name";
            stateDdlFields.Value = "Id";

            stateDdlProperties.DropDownListFields = stateDdlFields;

            ViewData["StateDDL"] = stateDdlProperties;

            return PartialView("AgencyAddressEdit", agencyAddress);
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

            var agencyAddress = new AgencyManager().GetAgencyAddress(agencyAddressId);

            var countyDdlProperties = new DropDownListProperties();
            var countyDdlFields = new DropDownListFields();

            countyDdlProperties.DataSource = DomainListManager.GetCountyList();

            countyDdlFields.Text = "Name";
            countyDdlFields.Value = "Id";

            countyDdlProperties.DropDownListFields = countyDdlFields;

            ViewData["CountyDDL"] = countyDdlProperties;

            var stateDdlProperties = new DropDownListProperties();
            var stateDdlFields = new DropDownListFields();

            stateDdlProperties.DataSource = DomainListManager.GetStateList();

            stateDdlFields.Text = "Name";
            stateDdlFields.Value = "Id";

            stateDdlProperties.DropDownListFields = stateDdlFields;

            ViewData["StateDDL"] = stateDdlProperties;

            return PartialView("AgencyAddressEdit", agencyAddress);
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

            var result = new AgencyManager().CreateAgencyAddress(value);

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

            var result = new AgencyManager().UpdateAgencyAddress(value);

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
            var result = new AgencyManager().DeleteAgencyAddress(value);

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

            return PartialView("AgencyNumberEdit", new AgencyNumber
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

            var agencyNumber = new AgencyManager().GetAgencyNumber(numberId);

            return PartialView("AgencyNumberEdit", agencyNumber);
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

            var result = new AgencyManager().CreateAgencyNumber(value);

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

            var result = new AgencyManager().UpdateAgencyNumber(value);

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
            var result = new AgencyManager().DeleteAgencyNumber(value);

            return Json(value, JsonRequestBehavior.AllowGet);
        }

        #endregion

        #region Agency Phone Number Methods

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

            var countyDdlProperties = new DropDownListProperties();
            var countyDdlFields = new DropDownListFields();

            countyDdlProperties.DataSource = DomainListManager.GetCountyList();

            countyDdlFields.Text = "Name";
            countyDdlFields.Value = "Id";

            countyDdlProperties.DropDownListFields = countyDdlFields;

            ViewData["CountyDDL"] = countyDdlProperties;

            var stateDdlProperties = new DropDownListProperties();
            var stateDdlFields = new DropDownListFields();

            stateDdlProperties.DataSource = DomainListManager.GetStateList();

            stateDdlFields.Text = "Name";
            stateDdlFields.Value = "Id";

            stateDdlProperties.DropDownListFields = stateDdlFields;

            ViewData["StateDDL"] = stateDdlProperties;

            return PartialView("AgencyPhoneEdit", agencyPhone);
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

            var agencyPhone = new AgencyManager().GetAgencyPhone(agencyPhoneId);

            var phoneTypeDdlProperties = new DropDownListProperties();
            var phoneTypeDdlFields = new DropDownListFields();

            phoneTypeDdlProperties.DataSource = DomainListManager.GetPhoneTypeList();

            phoneTypeDdlFields.Text = "Name";
            phoneTypeDdlFields.Value = "Id";

            phoneTypeDdlProperties.DropDownListFields = phoneTypeDdlFields;

            return PartialView("AgencyPhoneEdit", agencyPhone);
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

            var result = new AgencyManager().CreateAgencyPhone(value);

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

            var result = new AgencyManager().UpdateAgencyPhone(value);

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
            var result = new AgencyManager().DeleteAgencyPhone(value);

            return Json(value, JsonRequestBehavior.AllowGet);
        }

        #endregion

        // GET: Administration/Administration
        public ActionResult Users()
        {
            return View();
        }

    }
}
