using System;
using System.ComponentModel.DataAnnotations;
using CD.ClaimSoft.Database.Model.Role;

namespace CD.ClaimSoft.Database.Model.User
{
    [Serializable]
    public class AspNetUserRole
    {
        [Key]
        public string UserId { get; set; } // UserId (Primary key) (length: 128)
        public string RoleId { get; set; } // RoleId (Primary key) (length: 128)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

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
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
