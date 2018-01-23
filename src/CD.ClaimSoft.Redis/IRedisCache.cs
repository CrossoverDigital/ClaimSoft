#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;

namespace CD.ClaimSoft.Redis
{
    /// <summary>
    /// Redic Cache methods for interacting with the cache.
    /// </summary>
    public interface IRedisCache
    {
        /// <summary>
        /// Gets the value for the specified key.
        /// </summary>
        /// <typeparam name="T">The type of the object on the cache.</typeparam>
        /// <param name="keyName">Name of the key.</param>
        /// <returns>
        /// The value for the specified key.
        /// </returns>
        T Get<T>(string keyName);

        /// <summary>
        /// Gets the value for the specified key.
        /// </summary>
        /// <typeparam name="T">The type of the object on the cache.</typeparam>
        /// <param name="keyName">Name of the key.</param>
        /// <param name="queryFunction">The query function.</param>
        /// <returns>
        /// The value for the specified key.
        /// </returns>
        T Get<T>(string keyName, Func<T> queryFunction);

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
        T Get<T>(string keyName, int expireTimeInMinutes, Func<T> queryFunction);

        /// <summary>
        /// Gets the value for the specified key.
        /// </summary>
        /// <typeparam name="T">The type of the object on the cache.</typeparam>
        /// <param name="keyName">Name of the key.</param>
        /// <param name="queryFunction">The query function.</param>
        /// <returns>
        /// The value for the specified key.
        /// </returns>
        T Refresh<T>(string keyName, Func<T> queryFunction);

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
        T Refresh<T>(string keyName, int expireTimeInMinutes, Func<T> queryFunction);

        /// <summary>
        /// Expires the specified key name.
        /// </summary>
        /// <param name="keyName">Name of the key.</param>
        void Expire(string keyName);

        /// <summary>
        /// Gets the time to live.
        /// </summary>
        /// <param name="keyName">Name of the key.</param>
        /// <returns>
        /// The time to live of the given key.
        /// </returns>
        double GetTimeToLive(string keyName);
    }
}
