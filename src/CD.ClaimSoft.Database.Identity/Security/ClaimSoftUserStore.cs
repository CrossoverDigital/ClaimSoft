using System.Data.Entity;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace CD.ClaimSoft.Database.Identity.Security
{
    /// <inheritdoc />
    /// <summary>
    /// The store for a multi tenant user.
    /// </summary>
    /// <typeparam name="TUser">The type of user.</typeparam>
    public class ClaimSoftUserStore<TUser>
        : ClaimSoftUserStore<TUser, IdentityRole, string, string, ClaimSoftIdentityUserLogin, IdentityUserRole, IdentityUserClaim>, IUserStore<TUser>
        where TUser : ClaimSoftIdentityUser
    {
        /// <inheritdoc />
        /// <summary>
        /// Initializes a new instance of the <see cref="T:CD.ClaimSoft.Application.Security.MultitenantUserStore`1" /> class.
        /// </summary>
        /// <param name="context">The <see cref="T:System.Data.Entity.DbContext" />.</param>
        public ClaimSoftUserStore(DbContext context)
            : base(context)
        {
        }
    }
}
