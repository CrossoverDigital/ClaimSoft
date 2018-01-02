using CD.ClaimSoft.Database.Identity.Security;

namespace CD.ClaimSoft.Database.Identity
{
    public class ApplicationDbContext : ClaimSoftIdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DefaultConnection")
        {
        }
    }
}