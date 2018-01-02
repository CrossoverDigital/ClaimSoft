using Microsoft.AspNet.Identity.EntityFramework;

namespace CD.ClaimSoft.Database.Identity.Security
{
    /// <inheritdoc />
    /// <summary>
    /// Class defining a multi-tenant user login.
    /// </summary>
    /// <typeparam name="TKey">The type of <see cref="P:Microsoft.AspNet.Identity.EntityFramework.IdentityUserLogin`1.UserId" /> for a user.</typeparam>
    /// <typeparam name="TTenantKey">The type of <see cref="P:CD.ClaimSoft.Application.Security.MultitenantIdentityUserLogin`2.TenantId" /> for a user.</typeparam>
    public class ClaimSoftIdentityUserLogin<TKey, TTenantKey> : IdentityUserLogin<TKey>
    {
        ///// <summary>
        ///// Gets or sets the unique identifier of the tenant.
        ///// </summary>
        //public virtual TTenantKey TenantId { get; set; }
    }
}
