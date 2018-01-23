#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using Newtonsoft.Json.Serialization;

namespace CD.ClaimSoft.Common.Helpers
{
    /// <summary>
    /// HTML extension methods for enforcing UI standards.
    /// </summary>
    public static class HtmlHelperExtensions
    {
        /// <summary>
        /// DIsplays a "*" for an property that is attributed as required.
        /// </summary>
        /// <typeparam name="TModel">The type of the model.</typeparam>
        /// <typeparam name="TValue">The type of the value.</typeparam>
        /// <param name="html">The HTML.</param>
        /// <param name="expression">The expression.</param>
        /// <param name="labelText">The label text.</param>
        /// <param name="htmlAttributes">The HTML attributes.</param>
        /// <returns><see cref="MvcHtmlString"/> representing the control to be displayed to the end user.</returns>
        [SuppressMessage("Microsoft.Design", "CA1006:DoNotNestGenericTypesInMemberSignatures", Justification = "This is an appropriate nesting of generic types")]
        public static MvcHtmlString LabelForRequired<TModel, TValue>(this HtmlHelper<TModel> html, Expression<Func<TModel, TValue>> expression, string labelText = "", object htmlAttributes = null)
        {
            return LabelHelper(html, ModelMetadata.FromLambdaExpression(expression, html.ViewData), ExpressionHelper.GetExpressionText(expression), labelText, new RouteValueDictionary(htmlAttributes));
        }

        /// <summary>
        /// Label helper method for displaying the label correctly.
        /// </summary>
        /// <param name="html">The HTML.</param>
        /// <param name="metadata">The metadata.</param>
        /// <param name="htmlFieldName">Name of the HTML field.</param>
        /// <param name="labelText">The label text.</param>
        /// <param name="htmlAttributes">The HTML attributes.</param>
        /// <returns><see cref="MvcHtmlString"/> representing the control to be displayed to the end user.</returns>
        private static MvcHtmlString LabelHelper(HtmlHelper html, ModelMetadata metadata, string htmlFieldName, string labelText, IDictionary<string, object> htmlAttributes)
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

            if (metadata != null && metadata.ContainerType != null && metadata.PropertyName != null)
            {
                var propertyInfo = metadata.ContainerType.GetProperty(metadata.PropertyName);

                if (propertyInfo != null)
                    isRequired = propertyInfo.GetCustomAttributes(typeof(RequiredAttribute), false).Length == 1;
            }

            var modelWrapper = CreateContainer("div", new { style = "display: inline-block;" });

            var tag = new TagBuilder("label");

            if (htmlAttributes != null)
            {
                tag.MergeAttributes(htmlAttributes);
            }

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

            modelWrapper.InnerHtml = output;

            return MvcHtmlString.Create(modelWrapper.ToString(TagRenderMode.Normal));
        }

        /// <summary>
        /// Creates the container for the tag.
        /// </summary>
        /// <param name="tagName">Name of the tag.</param>
        /// <param name="htmlAttributes">The HTML attributes.</param>
        /// <returns><see cref="TagBuilder"/> as the control container.</returns>
        private static TagBuilder CreateContainer(string tagName, object htmlAttributes)
        {
            var tag = new TagBuilder(tagName);

            IDictionary<string, object> htmlAttributesDictionary = new RouteValueDictionary(htmlAttributes);

            tag.MergeAttributes(htmlAttributesDictionary);

            return tag;
        }

        /// <summary>
        /// Method for converting the tag to json.
        /// </summary>
        /// <param name="helper">The helper.</param>
        /// <param name="obj">The object.</param>
        /// <returns>The HTML markup without encoding.</returns>
        public static IHtmlString ToJson(this HtmlHelper helper, object obj)
        {
            var settings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver()
            };

            settings.Converters.Add(new JavaScriptDateTimeConverter());

            return helper.Raw(JsonConvert.SerializeObject(obj, settings));
        }

        /// <summary>
        /// Determines whether the specified controller is active.
        /// </summary>
        /// <param name="html">The HTML.</param>
        /// <param name="controller">The controller.</param>
        /// <param name="action">The action.</param>
        /// <returns><code>true</code> returns the active CSS class. Else, empty string.</returns>
        public static string IsActive(this HtmlHelper html, string controller = null, string action = null)
        {
            var activeClass = $"active{(string)html.ViewContext.RouteData.Values["controller"]}";

            var actualAction = (string)html.ViewContext.RouteData.Values["action"];
            var actualController = (string)html.ViewContext.RouteData.Values["controller"];

            if (string.IsNullOrEmpty(controller))
                controller = actualController;

            if (string.IsNullOrEmpty(action))
                action = actualAction;

            return (controller == actualController && action == actualAction) ? activeClass : string.Empty;
        }

        /// <summary>
        /// Determines whether or not this location is active to display proper CSS.
        /// </summary>
        /// <param name="html">The HTML.</param>
        /// <returns><code>true</code> returns active location.</returns>
        public static string IsActiveLocationCss(this HtmlHelper html)
        {
            return $"active{(string)html.ViewContext.RouteData.Values["controller"]}";
        }

        /// <summary>
        /// Determines whether or not this location is active to display proper Icon.
        /// </summary>
        /// <param name="html">The HTML.</param>
        /// <returns><code>true</code> returns active location.</returns>
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

        /// <summary>
        /// Determines whether or not this location is active to display proper text.
        /// </summary>
        /// <param name="html">The HTML.</param>
        /// <returns><code>true</code> returns active location.</returns>
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

        /// <summary>
        /// Creates an image tag based on the passed in data.
        /// </summary>
        /// <typeparam name="TModel">The type of the model.</typeparam>
        /// <typeparam name="TValue">The type of the value.</typeparam>
        /// <param name="helper">The helper.</param>
        /// <param name="expression">The expression.</param>
        /// <param name="name">The name.</param>
        /// <param name="id">The identifier.</param>
        /// <returns>An image tag.</returns>
        public static IHtmlString Images<TModel, TValue>(this HtmlHelper<TModel> helper, System.Linq.Expressions.Expression<Func<TModel, TValue>> expression, string name, string id)
        {
            TagBuilder tb = new TagBuilder("input");

            tb.Attributes.Add("ex", expression.ToString());
            tb.Attributes.Add("name", name);
            tb.Attributes.Add("id", id);
            tb.Attributes.Add("type", "file");
            tb.Attributes.Add("accept", "Image/*");

            return new MvcHtmlString(tb.ToString(TagRenderMode.SelfClosing));
        }
    }
}