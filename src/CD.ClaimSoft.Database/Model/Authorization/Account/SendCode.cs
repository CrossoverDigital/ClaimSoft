using System.Collections.Generic;
using System.Web.Mvc;

namespace CD.ClaimSoft.Database.Model.Authorization.Account
{
    public class SendCode
    {
        public string SelectedProvider { get; set; }
        public ICollection<SelectListItem> Providers { get; set; }
        public string ReturnUrl { get; set; }
        public bool RememberMe { get; set; }
    }
}
