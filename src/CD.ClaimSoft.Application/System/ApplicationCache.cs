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
using CD.ClaimSoft.Database.Model.System;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;

namespace CD.ClaimSoft.Application.System
{
    /// <summary>
    /// Application cache for the system.
    /// </summary>
    public class ApplicationCache
    {
        #region Instance Variables

        /// <summary>
        /// The log service.
        /// </summary>
        private static readonly ILogService<ApplicationCache> LogService = new LogService<ApplicationCache>();

        #endregion

        /// <summary>
        /// Caches the application settings.
        /// </summary>
        public static void CacheApplicationSettings()
        {
            try
            {
                using (var dbContext = new ClaimSoftContext())
                {
                    var cache = new RedisCache();

                    cache.Refresh(CacheConstants.ApplicationSettingsListKey, CacheConstants.DefaultLongTimeToLive,
                        () => dbContext.ApplicationSettings.ProjectTo<ApplicationSetting>().ToDictionary(t => t.SettingKey, t => t.SettingValue));
                }
            }
            catch (Exception ex)
            {
                LogService.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Gets the application settings.
        /// </summary>
        /// <returns>The application settings.</returns>
        public static Dictionary<string, string> ApplicationSettings()
        {
            try
            {
                using (var dbContext = new ClaimSoftContext())
                {
                    var cache = new RedisCache();

                    return cache.Get(CacheConstants.ApplicationSettingsListKey, CacheConstants.DefaultLongTimeToLive,
                        () => dbContext.ApplicationSettings.ProjectTo<ApplicationSetting>().ToDictionary(t => t.SettingKey, t => t.SettingValue));
                }
            }
            catch (Exception ex)
            {
                LogService.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Gets the application setting.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <returns></returns>
        public static string ApplicationSetting(string key)
        {
            var appSettings = ApplicationSettings();

            return appSettings.ContainsKey(key) ? appSettings[key] : null;
        }
    }
}
