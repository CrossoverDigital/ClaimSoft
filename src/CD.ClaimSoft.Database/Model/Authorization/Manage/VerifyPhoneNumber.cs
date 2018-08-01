using System.ComponentModel.DataAnnotations;

namespace CD.ClaimSoft.Database.Model.Authorization.Manage
{
    public class VerifyPhoneNumber
    {
        [Required]
        [Display(Name = "Code")]
        public string Code { get; set; }

        [Required]
        [Phone]
        [Display(Name = "Phone Number")]
        public string PhoneNumber { get; set; }
    }
}
