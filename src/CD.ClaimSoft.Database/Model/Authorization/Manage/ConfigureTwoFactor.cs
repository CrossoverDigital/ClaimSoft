using System.Collections.Generic;
using System.Web.Mvc;

namespace CD.ClaimSoft.Database.Model.Authorization.Manage
{
    public class ConfigureTwoFactor
    {
        public string SelectedProvider { get; set; }
        public ICollection<SelectListItem> Providers { get; set; }
    }
}
