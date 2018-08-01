using System;
using System.ComponentModel.DataAnnotations;

namespace CD.ClaimSoft.Database.Model.User
{
    [Serializable]
    public class AspNetUserLogin
    {
        [Key]
        public string LoginProvider { get; set; } // LoginProvider (Primary key) (length: 128)
        public string ProviderKey { get; set; } // ProviderKey (Primary key) (length: 128)
        public string UserId { get; set; } // UserId (Primary key) (length: 128)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        // Foreign keys

        /// <summary>
        /// Parent AspNetUser pointed by [AspNetUserLogins].([UserId]) (FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId)
        /// </summary>
        public AspNetUser AspNetUser { get; set; } // FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId

        public AspNetUserLogin()
        {
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
