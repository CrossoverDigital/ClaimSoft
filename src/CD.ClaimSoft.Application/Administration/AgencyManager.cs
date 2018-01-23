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
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;

using Model = CD.ClaimSoft.Application.Models;

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
        /// Gets the agencies.
        /// </summary>
        /// <returns>
        /// The colection of agencies in the application.
        /// </returns>
        public List<Model.Agencies.Agency> GetAgencies()
        {
            try
            {
                return _cache.Get(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Creates a new agency.
        /// </summary>
        /// <param name="agency">The new agency.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus CreateAgency(Model.Agencies.Agency agency)
        {
            try
            {
                var agencyTenantId = Guid.NewGuid().ToString().ToUpperInvariant();

                agency.AgencyTenantId = agencyTenantId;

                var entity = Mapper.Map<Agency>(agency);

                _dbContext.Agencies.Attach(entity);

                _dbContext.Entry(entity).State = EntityState.Added;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    var agencyList = _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());

                    var newAgency = agencyList.First(a => a.AgencyTenantId == agencyTenantId);

                    returnValue.SetReturnObject(newAgency);
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
        /// Updates the agency.
        /// </summary>
        /// <param name="agency">The agency to update.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus UpdateAgency(Model.Agencies.Agency agency)
        {
            try
            {
                var agencyTenantId = agency.AgencyTenantId;

                var entity = Mapper.Map<Agency>(agency);

                _dbContext.Agencies.Attach(entity);

                _dbContext.Entry(entity).State = EntityState.Modified;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    var agencyList = _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());

                    var updatedAgency = agencyList.First(a => a.AgencyTenantId == agencyTenantId);

                    returnValue.SetReturnObject(updatedAgency);
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

        #region Agency Address Methods

        /// <inheritdoc />
        /// <summary>
        /// Gets the agency address.
        /// </summary>
        /// <param name="agencyAddressId">The agency address identifier.</param>
        /// <returns>The specified agency address.</returns>
        public Model.Agencies.AgencyAddress GetAgencyAddress(int agencyAddressId)
        {
            try
            {
                if (agencyAddressId == 0)
                {
                    return new Model.Agencies.AgencyAddress();
                }

                var agencyAddress = _dbContext.AgencyAddresses.First(a => a.Id == agencyAddressId);

                return Mapper.Map<AgencyAddress, Model.Agencies.AgencyAddress>(agencyAddress);
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
        public EfStatus CreateAgencyAddress(Model.Agencies.AgencyAddress agencyAddress)
        {
            try
            {
                var agencyAddressEntity = Mapper.Map<AgencyAddress>(agencyAddress);

                _dbContext.AgencyAddresses.Attach(agencyAddressEntity);

                _dbContext.Entry(agencyAddressEntity).State = EntityState.Added;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());
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
        public EfStatus UpdateAgencyAddress(Model.Agencies.AgencyAddress agencyAddress)
        {
            try
            {
                var agencyAddressEntity = Mapper.Map<AgencyAddress>(agencyAddress);

                _dbContext.AgencyAddresses.Attach(agencyAddressEntity);

                _dbContext.Entry(agencyAddressEntity).State = EntityState.Modified;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());
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
        public EfStatus DeleteAgencyAddress(Model.Agencies.AgencyAddress agencyAddress)
        {
            try
            {
                var agencyAddressEntity = Mapper.Map<AgencyAddress>(agencyAddress);

                _dbContext.AgencyAddresses.Attach(agencyAddressEntity);

                _dbContext.Entry(agencyAddressEntity).State = EntityState.Deleted;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());
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

        #region Agency Number Methods

        /// <inheritdoc />
        /// <summary>
        /// Gets the agency number.
        /// </summary>
        /// <param name="numberId">The number identifier.</param>
        /// <returns>The agency number for the specified numberId.</returns>
        public Model.Agencies.AgencyNumber GetAgencyNumber(int numberId)
        {
            try
            {
                var agencyNumber = _dbContext.AgencyNumbers.FirstOrDefault(an => an.Id == numberId);

                return Mapper.Map<AgencyNumber, Model.Agencies.AgencyNumber>(agencyNumber);
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Creates a new agency number.
        /// </summary>
        /// <param name="agencyNumber">The agency number.</param>
        /// <returns>
        /// The Entity Framework status object.
        /// </returns>
        public EfStatus CreateAgencyNumber(Model.Agencies.AgencyNumber agencyNumber)
        {
            try
            {
                var entity = Mapper.Map<AgencyNumber>(agencyNumber);

                _dbContext.AgencyNumbers.Attach(entity);

                _dbContext.Entry(entity).State = EntityState.Added;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());
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
        /// Updates the agency number.
        /// </summary>
        /// <param name="agencyNumber">The agency number.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus UpdateAgencyNumber(Model.Agencies.AgencyNumber agencyNumber)
        {
            try
            {
                var agencyNumberEntity = Mapper.Map<AgencyNumber>(agencyNumber);

                _dbContext.AgencyNumbers.Attach(agencyNumberEntity);

                _dbContext.Entry(agencyNumberEntity).State = EntityState.Modified;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());
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
        /// Deletes the agency number.
        /// </summary>
        /// <param name="agencyNumber">The agency number.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus DeleteAgencyNumber(Model.Agencies.AgencyNumber agencyNumber)
        {
            try
            {
                var agencyNumberEntity = Mapper.Map<AgencyNumber>(agencyNumber);

                _dbContext.AgencyNumbers.Attach(agencyNumberEntity);

                _dbContext.Entry(agencyNumberEntity).State = EntityState.Deleted;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());
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

        #region Agency Phone Methods

        /// <inheritdoc />
        /// <summary>
        /// Gets the agency phone.
        /// </summary>
        /// <param name="phoneId">The phone identifier.</param>
        /// <returns>The agency phone for the specified identifier.</returns>
        public Model.Agencies.AgencyPhone GetAgencyPhone(int phoneId)
        {
            try
            {
                var agencyPhone = _dbContext.AgencyPhones.FirstOrDefault(an => an.Id == phoneId);

                return Mapper.Map<AgencyPhone, Model.Agencies.AgencyPhone>(agencyPhone);
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Creates a new agency phone.
        /// </summary>
        /// <param name="agencyPhone">The agency phone.</param>
        /// <returns>
        /// The Entity Framework status object.
        /// </returns>
        public EfStatus CreateAgencyPhone(Model.Agencies.AgencyPhone agencyPhone)
        {
            try
            {
                var entity = Mapper.Map<AgencyPhone>(agencyPhone);

                _dbContext.AgencyPhones.Attach(entity);

                _dbContext.Entry(entity).State = EntityState.Added;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());
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
        /// Updates the agency phone.
        /// </summary>
        /// <param name="agencyPhone">The agency phone.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus UpdateAgencyPhone(Model.Agencies.AgencyPhone agencyPhone)
        {
            try
            {
                var agencyPhoneEntity = Mapper.Map<AgencyPhone>(agencyPhone);

                _dbContext.AgencyPhones.Attach(agencyPhoneEntity);

                _dbContext.Entry(agencyPhoneEntity).State = EntityState.Modified;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());
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
        /// Deletes the agency phone.
        /// </summary>
        /// <param name="agencyPhone">The agency phone.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus DeleteAgencyPhone(Model.Agencies.AgencyPhone agencyPhone)
        {
            try
            {
                var agencyPhoneEntity = Mapper.Map<AgencyPhone>(agencyPhone);

                _dbContext.AgencyPhones.Attach(agencyPhoneEntity);

                _dbContext.Entry(agencyPhoneEntity).State = EntityState.Deleted;

                var returnValue = _dbContext.SaveChangesWithValidation();

                if (returnValue.IsValid)
                {
                    _cache.Refresh(CacheConstants.AllAgenciesKey, CacheConstants.DefaultTimeToLive, () => _dbContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList());
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
    }
}