using CD.ClaimSoft.Application.Security;

namespace CD.ClaimSoft.Database
{
    public class ApplicationDbContext : ClaimSoftIdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DefaultConnection")
        {
        }
    }
}