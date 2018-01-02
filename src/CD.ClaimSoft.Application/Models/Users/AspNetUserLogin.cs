namespace CD.ClaimSoft.Application.Models.Users
{
    public class AspNetUserLogin
    {
        public string LoginProvider { get; set; } // LoginProvider (Primary key) (length: 128)
        public string ProviderKey { get; set; } // ProviderKey (Primary key) (length: 128)
        public string UserId { get; set; } // UserId (Primary key) (length: 128)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public System.DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public System.DateTime LastModifyDate { get; set; } // LastModifyDate

        // Foreign keys

        /// <summary>
        /// Parent AspNetUser pointed by [AspNetUserLogins].([UserId]) (FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId)
        /// </summary>
        public virtual AspNetUser AspNetUser { get; set; } // FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId

        public AspNetUserLogin()
        {
            CreateDate = System.DateTime.Now;
            LastModifyDate = System.DateTime.Now;
        }
    }
}
