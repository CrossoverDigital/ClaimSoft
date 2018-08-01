#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Collections.Generic;
using System.Linq;

using AutoMapper.QueryableExtensions;
using CD.ClaimSoft.Database;
using CD.ClaimSoft.Database.Model.Common;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;
using Agency = CD.ClaimSoft.Database.Model.Agency.Agency;

namespace CD.ClaimSoft.Application.Domain
{
    /// <inheritdoc />
    /// <summary>
    /// Manager class for handling all the domain list in the system. Cache backed with long TTL.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.Application.Domain.IDomainListManager" />
    public class DomainListManager : IDomainListManager
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
        readonly ILogService<DomainListManager> _logService;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="DomainListManager"/> class.
        /// </summary>
        /// <param name="db">The database.</param>
        /// <param name="cache">The cache.</param>
        /// <param name="logService">The log service.</param>
        public DomainListManager(IClaimSoftContext db, IRedisCache cache, ILogService<DomainListManager> logService)
        {
            _dbContext = db;
            _cache = cache;
            _logService = logService;
        }

        #endregion

        #region Instance Methods

        /// <inheritdoc />
        /// <summary>
        /// Gets the country list.
        /// </summary>
        /// <returns>The country list.</returns>
        public List<Country> GetCountryList()
        {
            try
            {
                return _cache.Get(CacheConstants.CountryDomainListKey, CacheConstants.DefaultLongTimeToLive, () => _dbContext.Countries.ProjectTo<Country>().ToList());
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the county list.
        /// </summary>
        /// <returns>The county list.</returns>
        public List<County> GetCountyList()
        {
            try
            {
                return _cache.Get(CacheConstants.CountyDomainListKey, CacheConstants.DefaultLongTimeToLive, () => _dbContext.Counties.ProjectTo<County>().ToList());
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the state list.
        /// </summary>
        /// <returns>The state list.</returns>
        public List<State> GetStateList()
        {
            try
            {
                return _cache.Get(CacheConstants.StateDomainListKey, CacheConstants.DefaultLongTimeToLive, () => _dbContext.States.ProjectTo<State>().ToList());
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the time zones.
        /// </summary>
        /// <returns>The time zones.</returns>
        public List<TimeZoneInfo> GetTimeZonesList()
        {
            try
            {
                return _cache.Get(CacheConstants.TimeZonesDomainListKey, CacheConstants.DefaultLongTimeToLive, () => TimeZoneInfo.GetSystemTimeZones().OrderBy(ob => ob.StandardName).ToList());
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the address type list.
        /// </summary>
        /// <returns>
        /// The address type list.
        /// </returns>
        public List<AddressType> GetAddressTypeList()
        {
            try
            {
                return _cache.Get(CacheConstants.AddressTypeDomainListKey, CacheConstants.DefaultLongTimeToLive, () => _dbContext.AddressTypes.ProjectTo<AddressType>().ToList());
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the phone type list.
        /// </summary>
        /// <returns>The phone type list.</returns>
        public List<PhoneType> GetPhoneTypeList()
        {
            try
            {
                return _cache.Get(CacheConstants.PhoneTypeDomainListKey, CacheConstants.DefaultLongTimeToLive, () => _dbContext.PhoneTypes.ProjectTo<PhoneType>().ToList());
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the email type list.
        /// </summary>
        /// <returns>
        /// The email type list.
        /// </returns>
        public List<EmailType> GetEmailTypeList()
        {
            try
            {
                return _cache.Get(CacheConstants.EmailTypeDomainListKey, CacheConstants.DefaultLongTimeToLive, () => _dbContext.EmailTypes.ProjectTo<EmailType>().ToList());
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the unit rounding type list.
        /// </summary>
        /// <returns>
        /// The unit rounding type list.
        /// </returns>
        public List<UnitRoundingType> GetUnitRoundingTypeList()
        {
            try
            {
                return _cache.Get(CacheConstants.UnitRoundingTypeDomainListKey, CacheConstants.DefaultLongTimeToLive, () => _dbContext.UnitRoundingTypes.ProjectTo<UnitRoundingType>().ToList());
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets all the agencies in ClaimSoft.
        /// </summary>
        /// <returns>
        /// The collection of all the agencies in ClaimSoft.
        /// </returns>
        public List<Agency> GetAllAgenciesList()
        {
            try
            {
                return _cache.Get(CacheConstants.AllAgenciesKey, CacheConstants.DefaultLongTimeToLive, () => _dbContext.Agencies.ProjectTo<Agency>().ToList());
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the file type list.
        /// </summary>
        /// <returns>
        /// The file type list.
        /// </returns>
        public List<FileType> GetFileTypeList()
        {
            try
            {
                return _cache.Get(CacheConstants.FileTypeDomainListKey, CacheConstants.DefaultLongTimeToLive, () => _dbContext.FileTypes.ProjectTo<FileType>().ToList());
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