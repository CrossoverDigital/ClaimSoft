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

using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Settings;

using StackExchange.Redis;

namespace CD.ClaimSoft.Redis
{
    /// <inheritdoc />
    /// <summary>
    /// The Redis server connection manager.
    /// </summary>
    public class RedisConnectionManager : IRedisConnectionManager
    {
        #region Instance Variables

        /// <summary>
        /// The log service.
        /// </summary>
        private static ILogService<RedisConnectionManager> _logService;

        /// <summary>
        /// The settings dictionary.
        /// </summary>
        private static Dictionary<string, string> _settingsDictionary;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="RedisConnectionManager" /> class.
        /// </summary>
        public RedisConnectionManager()
        {
            _logService = new LogService<RedisConnectionManager>();

            try
            {
                using (var dbContext = new SettingsContext())
                {
                    _settingsDictionary = dbContext.ApplicationSettings.Where(a => a.SettingTypeId == 1).Select(p => new { p.SettingKey, p.SettingValue })
                        .AsEnumerable().ToDictionary(kvp => kvp.SettingKey, kvp => kvp.SettingValue);
                }
            }
            catch (Exception ex)
            {
                _logService.Error(ex);
            }
        }

        #endregion

        #region Instance Methods

        /// <summary>
        /// The Redis configuration options.
        /// </summary>
        private static readonly Lazy<ConfigurationOptions> ConfigOptions = new Lazy<ConfigurationOptions>(() =>
        {
            try
            {
                var configOptions = new ConfigurationOptions();

                var serverAddress = _settingsDictionary["ServerAddress"];
                var clientName = _settingsDictionary["ClientName"];
                var connectTimeout = int.Parse(_settingsDictionary["ConnectTimeout"]);
                var syncTimeout = int.Parse(_settingsDictionary["SyncTimeout"]);
                var abortOnConnectFail = Convert.ToBoolean(_settingsDictionary["AbortOnConnectFail"]);

                configOptions.EndPoints.Add(serverAddress);
                configOptions.ClientName = clientName;
                configOptions.ConnectTimeout = connectTimeout;
                configOptions.SyncTimeout = syncTimeout;
                configOptions.AbortOnConnectFail = abortOnConnectFail;

                return configOptions;
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                throw;
            }
        });

        /// <summary>
        /// The Redis connection.
        /// </summary>
        private static readonly Lazy<ConnectionMultiplexer> Conn = new Lazy<ConnectionMultiplexer>(
            () => ConnectionMultiplexer.Connect(ConfigOptions.Value));

        /// <inheritdoc />
        /// <summary>
        /// Gets the redis server.
        /// </summary>
        /// <value>
        /// The redis server.
        /// </value>
        public IDatabase RedisServer => Conn.Value.GetDatabase(0);

        #endregion
    }
}
