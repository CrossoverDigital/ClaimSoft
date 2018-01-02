using System;
using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Serialization;

namespace CD.ClaimSoft.Common.Helpers
{
    public static class HtmlHelperExtensions
    {
        [SuppressMessage("Microsoft.Design", "CA1006:DoNotNestGenericTypesInMemberSignatures", Justification = "This is an appropriate nesting of generic types")]

        public static MvcHtmlString LabelForRequired<TModel, TValue>(this HtmlHelper<TModel> html, Expression<Func<TModel, TValue>> expression, string labelText = "")

        {

            return LabelHelper(html,

                ModelMetadata.FromLambdaExpression(expression, html.ViewData),

                ExpressionHelper.GetExpressionText(expression), labelText);

        }

        private static MvcHtmlString LabelHelper(HtmlHelper html, ModelMetadata metadata, string htmlFieldName, string labelText)
        {
            if (string.IsNullOrEmpty(labelText))
            {
                labelText = metadata.DisplayName ?? metadata.PropertyName ?? htmlFieldName.Split('.').Last();
            }

            if (string.IsNullOrEmpty(labelText))
            {
                return MvcHtmlString.Empty;
            }

            var isRequired = false;

            if (metadata.ContainerType != null)
            {
                if (metadata.PropertyName != null)
                {
                    isRequired = metadata.ContainerType.GetProperty(metadata.PropertyName)
                                     .GetCustomAttributes(typeof(RequiredAttribute), false)
                                     .Length == 1;
                }
            }

            TagBuilder tag = new TagBuilder("label");

            tag.Attributes.Add("for", TagBuilder.CreateSanitizedId(html.ViewContext.ViewData.TemplateInfo.GetFullHtmlFieldName(htmlFieldName)));

            tag.Attributes.Add("class", "labelField");

            tag.SetInnerText(labelText);

            var output = tag.ToString(TagRenderMode.Normal);

            if (isRequired)
            {
                var asteriskTag = new TagBuilder("span");

                asteriskTag.Attributes.Add("class", "requiredField");

                asteriskTag.SetInnerText("*");

                output += asteriskTag.ToString(TagRenderMode.Normal);
            }

            return MvcHtmlString.Create(output);
        }

        public static IHtmlString ToJson(this HtmlHelper helper, object obj)
        {
            var settings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };

            settings.Converters.Add(new JavaScriptDateTimeConverter());

            return helper.Raw(JsonConvert.SerializeObject(obj, settings));
        }

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
