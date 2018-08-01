#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

using AutoMapper.QueryableExtensions;
using CD.ClaimSoft.Database;
using CD.ClaimSoft.Database.Model.Agency;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;

namespace CD.ClaimSoft.Application.User
{
    /// <inheritdoc />
    /// <summary>
    /// User management class that handles all the processing needed to maintain Agencies within the ClaimSoft application.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.Application.User.IUserManager" />
    public class UserProfileHelper : IUserProfileHelper
    {
        #region Instance Variables
        
        /// <summary>
        /// The cache.
        /// </summary>
        readonly RedisCache _cache;

        /// <summary>
        /// The log service.
        /// </summary>
        readonly LogService<UserProfileHelper> _logService;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="UserProfileHelper" /> class.
        /// </summary>
        /// <param name="db">The database.</param>
        /// <param name="cache">The cache.</param>
        /// <param name="logService">The log service.</param>
        public UserProfileHelper()
        {
            _logService = new LogService<UserProfileHelper>();
            _cache = new RedisCache();
        }

        #endregion

        #region Agency Methods

        /// <summary>
        /// Gets the user's agencies.
        /// </summary>
        /// <param name="userId">The user identifier.</param>
        /// <returns>
        /// The list of agencies the user has.
        /// </returns>
        public List<Agency> UserAgencies(string userId)
        {
            try
            {
                using (var dbContext = new ClaimSoftContext())
                {
                    if (!(dbContext.Database.Connection is SqlConnection connection))
                        return null;

                    connection.Open();
                    
                    return dbContext.AgencyUsers.Where(au => au.AspNetUserId == userId).ToList().Select(au => new Agency()
                    {
                        AgencyId = au.Agency.Id,
                        AgencyName = au.Agency.AgencyName,
                        AgencyNumber = au.Agency.AgencyNumber
                    }).ToList();
                }
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