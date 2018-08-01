using System;

namespace CD.ClaimSoft.Database.Model.User
{
    [Serializable]
    public class AspNetUserClaim
    {
        public int Id { get; set; } // Id (Primary key)
        public string UserId { get; set; } // UserId (length: 128)
        public string ClaimType { get; set; } // ClaimType
        public string ClaimValue { get; set; } // ClaimValue
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        // Foreign keys

        /// <summary>
        /// Parent AspNetUser pointed by [AspNetUserClaims].([UserId]) (FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId)
        /// </summary>
        public virtual AspNetUser AspNetUser { get; set; } // FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId

        public AspNetUserClaim()
        {
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
