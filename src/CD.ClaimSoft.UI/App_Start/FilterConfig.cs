using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace CD.ClaimSoft.UI
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
            filters.Add(new AuthorizeAttribute());
           // filters.Add(new SessionExpire());
        }


        [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
        public class SessionExpire : ActionFilterAttribute
        {
            public override void OnActionExecuting(ActionExecutingContext filterContext)
            {
                var controllerName = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName.ToLower().Trim();
                var actionName = filterContext.ActionDescriptor.ActionName.ToLower().Trim();

                if (!actionName.StartsWith("login") && !actionName.StartsWith("logoff"))
                {
                    var session = HttpContext.Current.Session["SelectedSiteName"];
                    var ctx = HttpContext.Current;
                    
                    if (session != null) return;

                    base.OnActionExecuting(filterContext);

                    //Redirects user to login screen if session has timed out
                    filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new
                    {
                        controller = "Account",
                        action = "LogOff",
                        area = "Account"
                    }));
                }

            }

        }

    }
}
