using CD.ClaimSoft.Application.Models.Roles;

namespace CD.ClaimSoft.Application.Models.Users
{
    public class AspNetUserRole
    {
        public string UserId { get; set; } // UserId (Primary key) (length: 128)
        public string RoleId { get; set; } // RoleId (Primary key) (length: 128)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public System.DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public System.DateTime LastModifyDate { get; set; } // LastModifyDate

        // Foreign keys

        /// <summary>
        /// Parent AspNetRole pointed by [AspNetUserRoles].([RoleId]) (FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId)
        /// </summary>
        public AspNetRole AspNetRole { get; set; } // FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId

        /// <summary>
        /// Parent AspNetUser pointed by [AspNetUserRoles].([UserId]) (FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId)
        /// </summary>
        public AspNetUser AspNetUser { get; set; } // FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId

        public AspNetUserRole()
        {
            CreateDate = System.DateTime.Now;
            LastModifyDate = System.DateTime.Now;
        }
    }
}
