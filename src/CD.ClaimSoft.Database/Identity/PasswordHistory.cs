using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace CD.ClaimSoft.Database.Identity
{
    public class PasswordHistory
    {
        public PasswordHistory()
        {
            CreatedDate = DateTime.Now;
        }

        public DateTime CreatedDate { get; set; }

        [Key, Column(Order = 1)]
        public string PasswordHash { get; set; }

        [Key, Column(Order = 0)]
        public string UserId { get; set; }

        public virtual ApplicationUser User { get; set; }

    }
}
