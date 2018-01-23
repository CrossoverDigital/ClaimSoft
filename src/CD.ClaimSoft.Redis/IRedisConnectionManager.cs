#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using StackExchange.Redis;

namespace CD.ClaimSoft.Redis
{
    /// <summary>
    /// The Redis server connection manager.
    /// </summary>
    public interface IRedisConnectionManager
    {
        /// <summary>
        /// Gets the redis server.
        /// </summary>
        /// <value>
        /// The redis server.
        /// </value>
        IDatabase RedisServer { get; }
    }
}
