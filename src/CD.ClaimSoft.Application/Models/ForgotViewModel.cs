using System.ComponentModel.DataAnnotations;

namespace CD.ClaimSoft.Application.Models
{
    public class ForgotViewModel
    {
        [Required]
        [Display(Name = "Email")]
        public string Email { get; set; }
    }
}