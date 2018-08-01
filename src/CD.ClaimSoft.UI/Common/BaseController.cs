#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System.Web;
using System.Web.Mvc;
using CD.ClaimSoft.Database.Identity;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace CD.ClaimSoft.UI.Common
{
    /// <inheritdoc />
    /// <summary>
    /// Base controller for all controllers in the ClaimSoft application.
    /// </summary>
    /// <seealso cref="T:System.Web.Mvc.Controller" />
    public class BaseController : Controller
    {
    }
}