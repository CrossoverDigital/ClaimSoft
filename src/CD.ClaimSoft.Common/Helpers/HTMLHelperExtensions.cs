using System.Web.Mvc;

namespace CD.ClaimSoft.Common.Helpers
{
    public static class HTMLHelperExtensions
    {
        public static string IsActive(this HtmlHelper html, string controller = null, string action = null)
        {
            var activeClass = $"active{(string)html.ViewContext.RouteData.Values["controller"]}"; // change here if you another name to activate sidebar items
            // detect current app state
            var actualAction = (string)html.ViewContext.RouteData.Values["action"];
            var actualController = (string)html.ViewContext.RouteData.Values["controller"];

            if (string.IsNullOrEmpty(controller))
                controller = actualController;

            if (string.IsNullOrEmpty(action))
                action = actualAction;

            return (controller == actualController && action == actualAction) ? activeClass : string.Empty;
        }

        public static string IsActiveLocationCss(this HtmlHelper html)
        {
            return $"active{(string)html.ViewContext.RouteData.Values["controller"]}";
        }

        public static string IsActiveLocationIcon(this HtmlHelper html)
        {
            switch ((string)html.ViewContext.RouteData.Values["controller"])
            {
                case "Administration":
                    return "fa fa-cogs";

                case "Claim":
                    return "fa fa-clipboard";

                case "Dashboard":
                    return "fa fa-home";

                case "ImportExport":
                    return "fa fa-exchange";

                case "Note":
                    return "fa fa-comments-o";

                case "Patient":
                    return "fa fa-heartbeat";

                case "Payment":
                    return "fa fa-usd";

                case "Report":
                    return "fa fa-line-chart";

                default:
                    return "fa fa-home";
            }
        }
        public static string IsActiveLocationText(this HtmlHelper html)
        {
            switch ((string)html.ViewContext.RouteData.Values["controller"])
            {
                case "Administration":
                    return "sidebar.nav.ADMINISTRATION";

                case "Claim":
                    return "sidebar.nav.CLAIMS";

                case "Dashboard":
                    return "sidebar.nav.HOME";

                case "ImportExport":
                    return "sidebar.nav.EXPORT";

                case "Note":
                    return "sidebar.nav.NOTES";

                case "Patient":
                    return "sidebar.nav.PATIENTS";

                case "Payment":
                    return "sidebar.nav.payment.PAYMENTS";

                case "Report":
                    return "sidebar.nav.REPORTS";

                default:
                    return "sidebar.nav.HOME";
            }
        }
    }
}
