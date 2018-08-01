using System.Data.Entity;
using System.Linq;

using Microsoft.AspNet.Identity.EntityFramework;

namespace CD.ClaimSoft.Database.Identity
{
    public class ApplicationUserStore : UserStore<ApplicationUser>
    {
        public ApplicationUserStore(ClaimSoftContext context)
            : base(context)
        {
        }
    }
}
