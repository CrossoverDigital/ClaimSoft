#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System.Web.Mvc;

using Autofac;
using Autofac.Integration.Mvc;

using CD.ClaimSoft.Application.Administration;
using CD.ClaimSoft.Application.Domain;
using CD.ClaimSoft.Database;
using CD.ClaimSoft.Logging;
using CD.ClaimSoft.Redis;
using CD.ClaimSoft.UI.Dependecies;

namespace CD.ClaimSoft.UI
{
    /// <summary>
    /// Defines the methods, properties, and events that are common to all application 
    /// objects in an ASP.NET application.
    /// </summary>
    public static class AutofacBootstrapper
    {
        public static void Run()
        {
            var builder = new ContainerBuilder();

            builder.RegisterControllers(typeof(MvcApplication).Assembly);

            builder.RegisterModelBinders(typeof(MvcApplication).Assembly);
            builder.RegisterModelBinderProvider();

            builder.RegisterModule<AutofacWebTypesModule>();

            builder.RegisterSource(new ViewRegistrationSource());

            builder.RegisterFilterProvider();

            builder.RegisterGeneric(typeof(LogService<>)).As(typeof(ILogService<>));

            builder.Register(c => new ClaimSoftContext()).As<IClaimSoftContext>().PropertiesAutowired().InstancePerLifetimeScope();

            builder.Register(c => new RedisCache()).As<IRedisCache>().PropertiesAutowired().SingleInstance();

            builder.Register(c => new DomainListManager(c.Resolve<IClaimSoftContext>(), c.Resolve<IRedisCache>(), c.Resolve<ILogService<DomainListManager>>()))
                .As<IDomainListManager>().PropertiesAutowired().InstancePerLifetimeScope();

            builder.Register(c => new AgencyManager(c.Resolve<IClaimSoftContext>(), c.Resolve<IRedisCache>(), c.Resolve<ILogService<AgencyManager>>()))
                .As<IAgencyManager>().PropertiesAutowired().InstancePerLifetimeScope();

            builder.RegisterType<ViewDependency>().As<IViewDependency>();

            var container = builder.Build();

            DependencyResolver.SetResolver(new AutofacDependencyResolver(container));
        }
    }
}