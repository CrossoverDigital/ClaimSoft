using System.Web.Mvc;

using CD.ClaimSoft.UI.Dependecies;

namespace CD.ClaimSoft.UI.Common
{
    /// <inheritdoc />
    /// <summary>
    /// Custom view page base class for view injection.
    /// </summary>
    /// <seealso cref="T:System.Web.Mvc.WebViewPage" />
    public abstract class CustomViewPage<TModel> : WebViewPage<TModel>
    {
        public IViewDependency DdlDataSources { get; set; }
    }
}