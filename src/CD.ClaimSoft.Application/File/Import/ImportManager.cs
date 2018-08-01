using System;
using System.Data.Entity;
using System.Linq;
using CD.ClaimSoft.Common.EntityFramework;
using CD.ClaimSoft.Database;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;

namespace CD.ClaimSoft.Application.File.Import
{
    public class ImportManager : IImportManager
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
        readonly ILogService<ImportManager> _logService;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="ImportManager" /> class.
        /// </summary>
        /// <param name="db">The database.</param>
        /// <param name="cache">The cache.</param>
        /// <param name="logService">The log service.</param>
        public ImportManager(IClaimSoftContext db, IRedisCache cache, ILogService<ImportManager> logService)
        {
            _dbContext = db;
            _cache = cache;
            _logService = logService;
        }

        #endregion

        /// <summary>
        /// Processes the file.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="streamId">The stream identifier.</param>
        /// <param name="userId">The user identifier.</param>
        /// <param name="agencyId">The agency identifier.</param>
        /// <returns>
        /// The Entity Framework status object. <see cref="EfStatus" />
        /// </returns>
        /// <inheritdoc />
        public EfStatus ProcessFile(string fileName, string streamId, string userId, int agencyId)
        {
            var efStatus = new EfStatus();
            try
            {
                var returnValue = _dbContext.ProcessNemsisFile(fileName, streamId, userId, agencyId);

                if (returnValue == 0)
                {
                }

                return efStatus;
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }
    }
}
