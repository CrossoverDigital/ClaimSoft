using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;

using CD.ClaimSoft.Database.Model.Agency;

using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace CD.ClaimSoft.Database.Identity
{
    public class ApplicationUser : IdentityUser
    {
        public List<Agency> Agencies { get; set; }

        public List<PasswordHistory> PasswordHistory { get; set; }

        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(ApplicationUserManager applicationUserManager)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userId = await applicationUserManager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            // Add custom user claims here

            Agencies = applicationUserManager.UserAgencies(Id);

            return userId;
        }
    }
}