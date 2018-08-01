using System.ComponentModel.DataAnnotations;

namespace CD.ClaimSoft.Database.Model.Authorization.Account
{ 
    public class ExternalLoginConfirmation
    {
        [Required]
        [Display(Name = "Email")]
        public string Email { get; set; }
    }

}
