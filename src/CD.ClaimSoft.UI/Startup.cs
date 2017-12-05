using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CD.ClaimSoft.UI.Startup))]
namespace CD.ClaimSoft.UI
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
