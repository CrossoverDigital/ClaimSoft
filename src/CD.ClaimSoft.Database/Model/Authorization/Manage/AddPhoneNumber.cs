using System.ComponentModel.DataAnnotations;

namespace CD.ClaimSoft.Database.Model.Authorization.Manage
{
    public class AddPhoneNumber
    {
        [Required]
        [Phone]
        [Display(Name = "Phone Number")]
        public string Number { get; set; }
    }
}
