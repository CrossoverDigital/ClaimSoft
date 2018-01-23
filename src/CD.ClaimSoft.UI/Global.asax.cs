#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Runtime.ExceptionServices;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

using CD.ClaimSoft.Application.AutoMap;
using CD.ClaimSoft.Application.System;
using CD.ClaimSoft.Logging;

namespace CD.ClaimSoft.UI
{
    /// <inheritdoc />
    /// <summary>
    /// 
    /// </summary>
    /// <seealso cref="System.Web.HttpApplication" />
    public class MvcApplication : HttpApplication
    {
        #region Instance Variables

        /// <summary>
        /// The log.
        /// </summary>
        static readonly ILogService<MvcApplication> LogService = new LogService<MvcApplication>();

        #endregion

        protected void Application_Start()
        {
            LogConfig.RegisterConfigFile(Server.MapPath(@"~/Config/log4net.config"));

            LogService.Info("Logging configuration registered.");

            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);

            AutoMapperConfig.Configure();

            AutofacBootstrapper.Run();

            // Cache the application settings
            ApplicationCache.CacheApplicationSettings();

            if (LogService.IsDebugEnabled())
            {
                AppDomain.CurrentDomain.FirstChanceException += CurrentDomainOnFirstChanceException;
            }
        }

        static void CurrentDomainOnFirstChanceException(object sender, FirstChanceExceptionEventArgs firstChanceExceptionEventArgs)
        {
            if (LogService.IsDebugEnabled())
            {
                if (firstChanceExceptionEventArgs.Exception.Message.Contains("Source array"))
                {
                    LogService.Debug(firstChanceExceptionEventArgs.Exception.Message, firstChanceExceptionEventArgs.Exception);
                }
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {
            var ex = Server.GetLastError();

            LogService.Error("Message: An unhanged exception has occured, logged from the Application_Error() handler", ex);

            Response.Clear();
        }
    }
}