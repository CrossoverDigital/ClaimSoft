using System.Data.Entity;
using System.Web;
using System.Web.Mvc;
using Autofac;
using Autofac.Integration.Mvc;
using CD.ClaimSoft.Application.Administration;
using CD.ClaimSoft.Application.Domain;
using CD.ClaimSoft.Application.File.Import;
using CD.ClaimSoft.Database;
using CD.ClaimSoft.Database.Identity;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;
using CD.ClaimSoft.UI.Dependecies;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin;
using Microsoft.Owin.Security;
using Microsoft.Owin.Security.DataProtection;
using Owin;

[assembly: OwinStartup(typeof(CD.ClaimSoft.UI.Startup))]
namespace CD.ClaimSoft.UI
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {

            var builder = new ContainerBuilder();

            // REGISTER DEPENDENCIES
            //builder.RegisterType<ClaimSoftContext>().As<IClaimSoftContext>().InstancePerRequest();
            builder.RegisterType<ClaimSoftContext>().AsSelf().As<IClaimSoftContext>().InstancePerLifetimeScope();

            // Redis
            builder.Register(c => new RedisCache()).As<IRedisCache>().PropertiesAutowired().SingleInstance();
            
            builder.RegisterType<ApplicationUserStore>().As<IUserStore<ApplicationUser>>().InstancePerRequest();
            builder.RegisterType<ApplicationUserManager>().AsSelf().InstancePerRequest();
            builder.RegisterType<ApplicationSignInManager>().AsSelf().InstancePerRequest();
            builder.Register(c => HttpContext.Current.GetOwinContext().Authentication).InstancePerRequest();
            builder.Register(c => app.GetDataProtectionProvider()).InstancePerRequest();
            
            // REGISTER CONTROLLERS SO DEPENDENCIES ARE CONSTRUCTOR INJECTED
            builder.RegisterControllers(typeof(MvcApplication).Assembly);

            builder.RegisterModelBinders(typeof(MvcApplication).Assembly);

            builder.RegisterModelBinderProvider();

            builder.RegisterModule<AutofacWebTypesModule>();

            builder.RegisterSource(new ViewRegistrationSource());

            builder.RegisterFilterProvider();

            builder.RegisterGeneric(typeof(LogService<>)).As(typeof(ILogService<>));

            builder.Register(c => new DomainListManager(c.Resolve<IClaimSoftContext>(), c.Resolve<IRedisCache>(), c.Resolve<ILogService<DomainListManager>>()))
                .As<IDomainListManager>().PropertiesAutowired().InstancePerLifetimeScope();

            builder.Register(c => new AgencyManager(c.Resolve<IClaimSoftContext>(), c.Resolve<IRedisCache>(), c.Resolve<ILogService<AgencyManager>>()))
                .As<IAgencyManager>().PropertiesAutowired().InstancePerLifetimeScope();

            builder.Register(c => new ImportManager(c.Resolve<IClaimSoftContext>(), c.Resolve<IRedisCache>(), c.Resolve<ILogService<ImportManager>>()))
                .As<IImportManager>().PropertiesAutowired().InstancePerLifetimeScope();

            builder.Register(c => new ViewDependency(c.Resolve<IDomainListManager>())).As<IViewDependency>().PropertiesAutowired().InstancePerLifetimeScope();

            builder.RegisterType<ViewDependency>().As<IViewDependency>();

            // BUILD THE CONTAINER
            var container = builder.Build();

            // REPLACE THE MVC DEPENDENCY RESOLVER WITH AUTOFAC
            DependencyResolver.SetResolver(new AutofacDependencyResolver(container));

            // REGISTER WITH OWIN
            app.UseAutofacMiddleware(container);
            app.UseAutofacMvc();

            ConfigureAuth(app);
        }
    }
}
