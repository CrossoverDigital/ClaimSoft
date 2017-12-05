using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace CD.ClaimSoft.Application.Models
{
    public class LoginViewModel
    {
        [Required]
        [Display(Name = "User Name")]
        public string UserName { get; set; }

        [Required]
        [DataType(DataType.Password)]
        [Display(Name = "Password")]
        public string Password { get; set; }

        [Display(Name = "Remember me?")]
        [DefaultValue(false)]
        public bool RememberMe { get; set; }
    }
}