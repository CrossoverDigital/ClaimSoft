using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using CD.ClaimSoft.Application.Administration;
using CD.ClaimSoft.Database;
using CD.ClaimSoft.Database.Model.Agency;
using CD.ClaimSoft.Database.Model.Claim;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;

namespace CD.ClaimSoft.Application.Claims
{
    public class ClaimManager : IClaimManager
    {
        #region Instance Variables

        /// <summary>
        /// The database context.
        /// </summary>
        readonly IClaimSoftContext _dbContext;

        /// <summary>
        /// The cache.
        /// </summary>
        readonly IRedisCache _cache;

        /// <summary>
        /// The log service.
        /// </summary>
        readonly ILogService<ClaimManager> _logService;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="ClaimManager" /> class.
        /// </summary>
        /// <param name="db">The database.</param>
        /// <param name="cache">The cache.</param>
        /// <param name="logService">The log service.</param>
        public ClaimManager(IClaimSoftContext db, IRedisCache cache, ILogService<ClaimManager> logService)
        {
            _dbContext = db;
            _cache = cache;
            _logService = logService;
        }

        #endregion

        /// <summary>
        /// Gets the claims for the given agency.
        /// </summary>
        /// <param name="agencyId">The agency identifier.</param>
        /// <returns>The list of claims for the agency.</returns>
        public IEnumerable<PatientCareReport> GetClaims(int agencyId)
        {
            try
            {
                return _dbContext.PatientCareReports.Where(af => af.Agency.Id == agencyId).Select(af => new PatientCareReport
                {
                    Id = af.Id,
                    AgencyId = af.AgencyId,
                    //StreamId = af.StreamId,
                    //Name = af.Name,
                    //FileTypeId = af.FileTypeId,
                    //FileType = af.FileType.Name,
                    //ProcessedDate = af.ProcessedDate,
                    CreateBy = af.CreateBy,
                    CreateDate = af.CreateDate,
                    LastModifyBy = af.LastModifyBy,
                    LastModifyDate = af.LastModifyDate
                }).ToList();
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }
    }
}
