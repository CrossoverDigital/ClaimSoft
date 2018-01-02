using System;
using Microsoft.AspNet.Identity;

namespace CD.ClaimSoft.Database.Identity.Security
{
    /// <summary>
    /// Interface defining a multi-tenant user.
    /// </summary>
    /// <typeparam name="TKey">The type of <see cref="IUser{TKey}.Id"/> for a user.</typeparam>
    /// <typeparam name="TTenantKey">The type of <see cref="TenantId"/> for a user.</typeparam>
    public interface IClaimSoftUser<out TKey, TTenantKey> : IUser<TKey>
    {
        /// <summary>
        /// Gets or sets the unique identifier of the tenant.
        /// </summary>
        /// <value>
        /// The tenant identifier.
        /// </value>
        //TTenantKey TenantId { get; set; }

        /// <summary>
        /// Gets or sets the create by.
        /// </summary>
        /// <value>
        /// The create by.
        /// </value>
        string CreateBy { get; set; }

        /// <summary>
        /// Gets or sets the create date.
        /// </summary>
        /// <value>
        /// The create date.
        /// </value>
        DateTime CreateDate { get; set; }

        /// <summary>
        /// Gets or sets the last modify by.
        /// </summary>
        /// <value>
        /// The last modify by.
        /// </value>
        string LastModifyBy { get; set; }

        /// <summary>
        /// Gets or sets the last modify date.
        /// </summary>
        /// <value>
        /// The last modify date.
        /// </value>
        DateTime LastModifyDate { get; set; }
    }
}