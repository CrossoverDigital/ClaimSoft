#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;

using AutoMapper;
using AutoMapper.QueryableExtensions;

using CD.ClaimSoft.Common.EntityFramework;
using CD.ClaimSoft.Database;
using CD.ClaimSoft.Database.Model.Agency;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;

namespace CD.ClaimSoft.Application.Administration
{
    /// <inheritdoc />
    /// <summary>
    /// Agency management class that handles all the processing needed to maintain Agencies within the ClaimSoft application.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.Application.Administration.IAgencyManager" />
    public class AgencyManager : IAgencyManager
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
        readonly ILogService<AgencyManager> _logService;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="AgencyManager" /> class.
        /// </summary>
        /// <param name="db">The database.</param>
        /// <param name="cache">The cache.</param>
        /// <param name="logService">The log service.</param>
        public AgencyManager(IClaimSoftContext db, IRedisCache cache, ILogService<AgencyManager> logService)
        {
            _dbContext = db;
            _cache = cache;
            _logService = logService;
        }

        #endregion

        #region Agency Methods

        /// <inheritdoc />
        /// <summary>
        /// Creates a new agency.
        /// </summary>
        /// <param name="agency">The new agency.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus CreateAgency(Agency agency)
        {
            try
            {
                var agencyEntity = Mapper.Map<AgencyEntity>(agency);

                _dbContext.Agencies.Attach(agencyEntity);

                _dbContext.Entry(agencyEntity).State = EntityState.Added;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (!returnValue.IsValid)
                    return returnValue;

                _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Agency>().ToList());

                returnValue.SetReturnObject(agencyEntity);

                return returnValue;
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Updates the agency.
        /// </summary>
        /// <param name="agency">The agency to update.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus UpdateAgency(Agency agency)
        {
            try
            {
                var agencyEntity = Mapper.Map<AgencyEntity>(agency);

                _dbContext.Agencies.Attach(agencyEntity);

                _dbContext.Entry(agencyEntity).State = EntityState.Modified;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (!returnValue.IsValid)
                    return returnValue;

                _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Agency>().ToList());

                returnValue.SetReturnObject(agencyEntity);

                return returnValue;
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        #endregion

        #region Agency Address Methods

        /// <inheritdoc />
        /// <summary>
        /// Gets the agency address.
        /// </summary>
        /// <param name="agencyAddressId">The agency address identifier.</param>
        /// <returns>The specified agency address.</returns>
        public AgencyAddress GetAgencyAddress(int agencyAddressId)
        {
            try
            {
                if (agencyAddressId == 0)
                {
                    return new AgencyAddress();
                }

                var agencyAddress = _dbContext.AgencyAddresses.First(a => a.Id == agencyAddressId);

                return Mapper.Map<AgencyAddressEntity, AgencyAddress>(agencyAddress);
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Creates the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address to create.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus CreateAgencyAddress(AgencyAddress agencyAddress)
        {
            try
            {
                var agencyAddressEntity = Mapper.Map<AgencyAddressEntity>(agencyAddress);

                _dbContext.AgencyAddresses.Attach(agencyAddressEntity);

                _dbContext.Entry(agencyAddressEntity).State = EntityState.Added;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Agency>().ToList());
                }

                return returnValue;
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Updates the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus UpdateAgencyAddress(AgencyAddress agencyAddress)
        {
            try
            {
                var agencyAddressEntity = Mapper.Map<AgencyAddressEntity>(agencyAddress);

                _dbContext.AgencyAddresses.Attach(agencyAddressEntity);

                _dbContext.Entry(agencyAddressEntity).State = EntityState.Modified;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Agency>().ToList());
                }

                return returnValue;
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Deletes the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address to remove.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus DeleteAgencyAddress(AgencyAddress agencyAddress)
        {
            try
            {
                var agencyAddressEntity = Mapper.Map<AgencyAddressEntity>(agencyAddress);

                _dbContext.AgencyAddresses.Attach(agencyAddressEntity);

                _dbContext.Entry(agencyAddressEntity).State = EntityState.Deleted;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Agency>().ToList());
                }

                return returnValue;
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        #endregion

        #region Agency File Methods

        /// <inheritdoc />
        /// <summary>
        /// Gets the agency files.
        /// </summary>
        /// <param name="agencyId">The agency identifier.</param>
        /// <returns>
        /// Collection of agency files. <see cref="T:CD.ClaimSoft.Application.Model.Agency.AgencyFile" />
        /// </returns>
        public IEnumerable<AgencyFile> GetAgencyFiles(int agencyId)
        {
            try
            {
                return _dbContext.AgencyFiles.Where(af => af.Agency.Id == agencyId).Select(af => new AgencyFile
                {
                    Id = af.Id,
                    AgencyId = af.AgencyId,
                    StreamId = af.StreamId,
                    Name = af.Name,
                    FileTypeId = af.FileTypeId,
                    FileType = af.FileType.Name,
                    ProcessedDate = af.ProcessedDate,
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

        /// <summary>
        /// Inserts the agency file.
        /// </summary>
        /// <param name="agencyFile">The agency file. <see cref="AgencyFile" /></param>
        /// <returns>
        /// The Entity Framework status object. <see cref="EfStatus" />
        /// </returns>
        public EfStatus InsertAgencyFile(AgencyFile agencyFile)
        {
            try
            {
                var agencyFileEntity = Mapper.Map<AgencyFileEntity>(agencyFile);

                _dbContext.AgencyFiles.Attach(agencyFileEntity);

                _dbContext.Entry(agencyFileEntity).State = EntityState.Added;

                var returnValue = _dbContext.SaveChangesWithValidation();

                return returnValue;
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        #endregion
    }
}