using System.Collections.Generic;
using System.Web.Mvc;

namespace CD.ClaimSoft.Application.Models
{
    public class ConfigureTwoFactorViewModel
    {
        public string SelectedProvider { get; set; }
        public ICollection<SelectListItem> Providers { get; set; }
    }
}