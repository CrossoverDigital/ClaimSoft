﻿using CD.ClaimSoft.Application.Models.Users;

namespace CD.ClaimSoft.Application.Models.Roles
{
    public class AspNetRole
    {
        public string Id { get; set; } // Id (Primary key) (length: 128)
        public string Name { get; set; } // Name (length: 256)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public System.DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public System.DateTime LastModifyDate { get; set; } // LastModifyDate

        // Reverse navigation

        /// <summary>
        /// Child AspNetUserRoles where [AspNetUserRoles].[RoleId] point to this entity (FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId)
        /// </summary>
        public virtual System.Collections.Generic.ICollection<AspNetUserRole> AspNetUserRoles { get; set; } // AspNetUserRoles.FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId

        public AspNetRole()
        {
            CreateDate = System.DateTime.Now;
            LastModifyDate = System.DateTime.Now;
            AspNetUserRoles = new System.Collections.Generic.List<AspNetUserRole>();
        }
    }
}