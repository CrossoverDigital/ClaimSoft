using System;
using CD.ClaimSoft.Application.Model.User;
using Microsoft.AspNet.Identity.EntityFramework;

namespace CD.ClaimSoft.Database.Identity.Security
{
    /// <inheritdoc />
    /// <summary>
    /// Minimal class for a <see cref="T:CD.ClaimSoft.Application.Security.MultiTenantIdentityUser`5" /> with a
    /// <see cref="T:System.String" /> user <see cref="!:IUser.Id" /> and
    /// <see cref="P:CD.ClaimSoft.Application.Security.MultitenantIdentityUserLogin`2.TenantId" />.
    /// </summary>
    public class ClaimSoftIdentityUser :
        ClaimSoftIdentityUser<string, string, ClaimSoftIdentityUserLogin, IdentityUserRole, IdentityUserClaim>
    {
        /// <summary>
        /// Initializes a new instance of the <see cref="ClaimSoftIdentityUser"/> class.
        /// </summary>
        public ClaimSoftIdentityUser()
        {
            Id = Guid.NewGuid().ToString();
        }
        
        /// <inheritdoc />
        /// <summary>
        /// Initializes a new instance of the <see cref="T:CD.ClaimSoft.Application.Security.MultiTenantIdentityUser" /> class.
        /// </summary>
        /// <param name="userName">The <see cref="P:Microsoft.AspNet.Identity.EntityFramework.IdentityUser`4.UserName" /> of the user.</param>
        public ClaimSoftIdentityUser(string userName)
            : this()
        {
            if (string.IsNullOrWhiteSpace(userName))
                throw new ArgumentNullException(nameof(userName));

            UserName = userName;
        }
    }
}
