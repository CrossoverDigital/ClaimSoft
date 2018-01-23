#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Configuration;
using System.Web.Mvc;

using StackExchange.Redis;

namespace CD.ClaimSoft.UI.Common
{
    /// <inheritdoc />
    /// <summary>
    /// Base controller for all controllers in the ClaimSoft application.
    /// </summary>
    /// <seealso cref="T:System.Web.Mvc.Controller" />
    public class BaseController : Controller
    {
        /// <summary>
        /// Redis Connection string info.
        /// </summary>
        static readonly Lazy<ConnectionMultiplexer> LazyConnection = new Lazy<ConnectionMultiplexer>(() =>
        {
            var cacheConnection = ConfigurationManager.AppSettings["CacheConnection"].ToString();

            return ConnectionMultiplexer.Connect(cacheConnection);
        });

        /// <summary>
        /// Gets the Redis connection.
        /// </summary>
        /// <value>
        /// The Redis connection.
        /// </value>
        public static ConnectionMultiplexer Connection => LazyConnection.Value;
    }
}