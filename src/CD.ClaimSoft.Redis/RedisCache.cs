#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;

using CD.ClaimSoft.Logging;

using Newtonsoft.Json;

namespace CD.ClaimSoft.Redis
{
    /// <inheritdoc />
    /// <summary>
    /// Redic Cache methods for interacting with the cache.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.Redis.IRedisCache" />
    public class RedisCache : IRedisCache
    {
        #region Instance Variables

        /// <summary>
        /// The cache.
        /// </summary>
        readonly IRedisConnectionManager _cacheConnection;

        /// <summary>
        /// The log service.
        /// </summary>
        readonly ILogService<RedisCache> _logService;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="RedisCache" /> class.
        /// </summary>
        public RedisCache()
        {
            _cacheConnection = new RedisConnectionManager();
            _logService = new LogService<RedisCache>();
        }

        #endregion

        #region Instance Methods

        /// <inheritdoc />
        /// <summary>
        /// Gets the value for the specified key.
        /// </summary>
        /// <typeparam name="T">The type of the object on the cache.</typeparam>
        /// <param name="keyName">Name of the key.</param>
        /// <returns>
        /// The value for the specified key.
        /// </returns>
        public T Get<T>(string keyName)
        {
            try
            {
                string data = null;
                try
                {
                    data = _cacheConnection.RedisServer.StringGet(keyName);
                }
                catch (Exception ex)
                {
                    _logService.Error(ex);
                }

                return data == null ? default(T) : JsonConvert.DeserializeObject<T>(data);
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                return default(T);
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the value for the specified key.
        /// </summary>
        /// <typeparam name="T">The type of the object on the cache.</typeparam>
        /// <param name="keyName">Name of the key.</param>
        /// <param name="queryFunction">The query function.</param>
        /// <returns>
        /// The value for the specified key.
        /// </returns>
        public T Get<T>(string keyName, Func<T> queryFunction)
        {
            return Get(keyName, CacheConstants.DefaultTimeToLive, queryFunction);
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the value for the specified key.
        /// </summary>
        /// <typeparam name="T">The type of the object on the cache.</typeparam>
        /// <param name="keyName">Name of the key.</param>
        /// <param name="expireTimeInMinutes">The expire time in minutes.</param>
        /// <param name="queryFunction">The query function.</param>
        /// <returns>
        /// The value for the specified key.
        /// </returns>
        public T Get<T>(string keyName, int expireTimeInMinutes, Func<T> queryFunction)
        {
            try
            {
                string data = null;

                try
                {
                    data = _cacheConnection.RedisServer.StringGet(keyName);
                }
                catch (Exception ex)
                {
                    _logService.Error(ex);
                }

                if (data == null)
                {
                    var result = queryFunction();

                    if (result != null)
                    {
                        try
                        {
                            _cacheConnection.RedisServer.StringSet(keyName, JsonConvert.SerializeObject(result), new TimeSpan(0, expireTimeInMinutes, 0));
                        }
                        catch (Exception ex)
                        {
                            _logService.Error(ex);
                        }
                    }

                    return result;
                }

                return JsonConvert.DeserializeObject<T>(data);
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                return default(T);
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the value for the specified key.
        /// </summary>
        /// <typeparam name="T">The type of the object on the cache.</typeparam>
        /// <param name="keyName">Name of the key.</param>
        /// <param name="queryFunction">The query function.</param>
        /// <returns>
        /// The value for the specified key.
        /// </returns>
        public T Refresh<T>(string keyName, Func<T> queryFunction)
        {
            return Refresh(keyName, CacheConstants.DefaultTimeToLive, queryFunction);
        }

        /// <inheritdoc />
        /// <summary>
        /// Refreshes the specified key.
        /// </summary>
        /// <typeparam name="T">The type of the object on the cache.</typeparam>
        /// <param name="keyName">Name of the key.</param>
        /// <param name="expireTimeInMinutes">The expire time in minutes.</param>
        /// <param name="queryFunction">The query function.</param>
        /// <returns>
        /// The value for the specified key.
        /// </returns>
        public T Refresh<T>(string keyName, int expireTimeInMinutes, Func<T> queryFunction)
        {
            try
            {
                try
                {
                    _cacheConnection.RedisServer.KeyDelete(keyName);
                }
                catch (Exception ex)
                {
                    _logService.Error(ex);
                }

                var result = queryFunction();

                if (result != null)
                {
                    try
                    {
                        _cacheConnection.RedisServer.StringSet(keyName, JsonConvert.SerializeObject(result), new TimeSpan(0, expireTimeInMinutes, 0));
                    }
                    catch (Exception ex)
                    {
                        _logService.Error(ex);
                    }
                }

                return result;
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                return default(T);
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Expires the specified key name.
        /// </summary>
        /// <param name="keyName">Name of the key.</param>
        public void Expire(string keyName)
        {
            try
            {
                _cacheConnection.RedisServer.KeyDelete(keyName);
            }
            catch (Exception ex)
            {
                _logService.Error(ex);
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the time to live.
        /// </summary>
        /// <param name="keyName">Name of the key.</param>
        /// <returns>
        /// The time to live of the given key.
        /// </returns>
        public double GetTimeToLive(string keyName)
        {
            try
            {
                var result = _cacheConnection.RedisServer.KeyTimeToLive(keyName);
                if (result.HasValue == false)
                {
                    return -1; // key has expired or does not exist
                }

                return result.Value.TotalMinutes;
            }
            catch (Exception ex)
            {
                _logService.Error(ex);

                return -1;
            }
        }

        #endregion
    }
}