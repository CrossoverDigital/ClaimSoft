using System.ComponentModel.DataAnnotations;

namespace CD.ClaimSoft.Application.Models
{
    public class ExternalLoginConfirmationViewModel
    {
        [Required]
        [Display(Name = "User Name")]
        public string UserName { get; set; }
    }
}
