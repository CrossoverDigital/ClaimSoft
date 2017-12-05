using System;

using Microsoft.AspNet.Identity.EntityFramework;

namespace CD.ClaimSoft.Application.Security
{
    /// <summary>
    /// Class defining a multi-tenant user.
    /// </summary>
    /// <typeparam name="TKey">The type of <see cref="P:Microsoft.AspNet.Identity.IUser`1.Id" /> for a user.</typeparam>
    /// <typeparam name="TTenantKey">The type of <see cref="P:CD.ClaimSoft.Application.Security.IMultitenantUser`2.TenantId" /> for a user.</typeparam>
    /// <typeparam name="TLogin">The type of user login.</typeparam>
    /// <typeparam name="TRole">The type of user role.</typeparam>
    /// <typeparam name="TClaim">The type of user claim.</typeparam>
    public class ClaimSoftIdentityUser<TKey, TTenantKey, TLogin, TRole, TClaim>
        : IdentityUser<TKey, TLogin, TRole, TClaim>, IClaimSoftUser<TKey, TTenantKey>
        where TLogin : ClaimSoftIdentityUserLogin<TKey, TTenantKey>
        where TRole : IdentityUserRole<TKey>
        where TClaim : IdentityUserClaim<TKey>
    {
        /// <summary>
        /// Gets or sets the unique identifier of the tenant.
        /// </summary>
        /// <value>
        /// The tenant identifier.
        /// </value>
        /// <inheritdoc />
        //public TTenantKey TenantId { get; set; }

        /// <summary>
        /// Gets or sets the create by.
        /// </summary>
        /// <value>
        /// The create by.
        /// </value>
        /// <inheritdoc />
        public string CreateBy { get; set; }

        /// <summary>
        /// Gets or sets the create date.
        /// </summary>
        /// <value>
        /// The create date.
        /// </value>
        /// <inheritdoc />
        public DateTime CreateDate { get; set; }

        /// <summary>
        /// Gets or sets the last modify by.
        /// </summary>
        /// <value>
        /// The last modify by.
        /// </value>
        /// <inheritdoc />
        public string LastModifyBy { get; set; }

        /// <summary>
        /// Gets or sets the last modify date.
        /// </summary>
        /// <value>
        /// The last modify date.
        /// </value>
        /// <inheritdoc />
        public DateTime LastModifyDate { get; set; }
    }
}
