using System.Linq;
using System.Web.Mvc;
using CD.ClaimSoft.Application.Administration;
using CD.ClaimSoft.Application.Claims;
using CD.ClaimSoft.Application.Domain;
using CD.ClaimSoft.Application.File.Import;
using CD.ClaimSoft.Database.Model.Agency;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;
using CD.ClaimSoft.UI.Areas.ImportExport.Controllers;

namespace CD.ClaimSoft.UI.Areas.Claim.Controllers
{
    public class ClaimController : Controller
    {
        #region Instance Variables

        /// <summary>
        /// The log service.
        /// </summary>
        private readonly ILogService<ClaimController> _logService;

        /// <summary>
        /// The claim manager.
        /// </summary>
        private readonly IClaimManager _claimManager;

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
        /// Initializes a new instance of the <see cref="ClaimController" /> class.
        /// </summary>
        /// <param name="logService">The log service.</param>
        /// <param name="claimManager">The claim manager.</param>
        /// <param name="domainListManager">The domain list manager.</param>
        /// <param name="importManager">The import manager.</param>
        public ClaimController(ILogService<ClaimController> logService, IClaimManager claimManager, IDomainListManager domainListManager, IImportManager importManager)
        {
            _logService = logService;
            _claimManager = claimManager;
            _domainListManager = domainListManager;
            _importManager = importManager;
        }

        #endregion

        // GET: ImportExport/ImportExport
        public ActionResult Index()
        {
            var currentAgency = (Agency)Session[CacheConstants.CurrentUserAgencyKey];

            ViewBag.DataSource = _claimManager.GetClaims(currentAgency.AgencyId).ToList();

            return View();
        }

        public JsonResult DataSource()
        {
            var currentAgency = (Agency)Session[CacheConstants.CurrentUserAgencyKey];

            return Json(_claimManager.GetClaims(currentAgency.AgencyId).ToList(), JsonRequestBehavior.AllowGet);
        }
    }
}
