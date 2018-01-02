using CD.ClaimSoft.Application.Models.Agencies;

namespace CD.ClaimSoft.Application.Models.Users
{
    public class AspNetUser
    {
        public string Id { get; set; } // Id (Primary key) (length: 128)
        public string Email { get; set; } // Email (length: 256)
        public bool EmailConfirmed { get; set; } // EmailConfirmed
        public string PasswordHash { get; set; } // PasswordHash
        public string SecurityStamp { get; set; } // SecurityStamp
        public string PhoneNumber { get; set; } // PhoneNumber
        public bool PhoneNumberConfirmed { get; set; } // PhoneNumberConfirmed
        public bool TwoFactorEnabled { get; set; } // TwoFactorEnabled
        public System.DateTime? LockoutEndDateUtc { get; set; } // LockoutEndDateUtc
        public bool LockoutEnabled { get; set; } // LockoutEnabled
        public int AccessFailedCount { get; set; } // AccessFailedCount
        public string UserName { get; set; } // UserName (length: 256)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public System.DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public System.DateTime LastModifyDate { get; set; } // LastModifyDate

        // Reverse navigation

        /// <summary>
        /// Child AgencyUsers where [AgencyUser].[AspNetUserId] point to this entity (FK_AgencyUser_AspNetUsers)
        /// </summary>
        public virtual System.Collections.Generic.ICollection<AgencyUser> AgencyUsers { get; set; } // AgencyUser.FK_AgencyUser_AspNetUsers
        /// <summary>
        /// Child AspNetUserClaims where [AspNetUserClaims].[UserId] point to this entity (FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId)
        /// </summary>
        public virtual System.Collections.Generic.ICollection<AspNetUserClaim> AspNetUserClaims { get; set; } // AspNetUserClaims.FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId
        /// <summary>
        /// Child AspNetUserLogins where [AspNetUserLogins].[UserId] point to this entity (FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId)
        /// </summary>
        public virtual System.Collections.Generic.ICollection<AspNetUserLogin> AspNetUserLogins { get; set; } // AspNetUserLogins.FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId
        /// <summary>
        /// Child AspNetUserRoles where [AspNetUserRoles].[UserId] point to this entity (FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId)
        /// </summary>
        public virtual System.Collections.Generic.ICollection<AspNetUserRole> AspNetUserRoles { get; set; } // AspNetUserRoles.FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId

        public AspNetUser()
        {
            CreateDate = System.DateTime.Now;
            LastModifyDate = System.DateTime.Now;
            AgencyUsers = new System.Collections.Generic.List<AgencyUser>();
            AspNetUserClaims = new System.Collections.Generic.List<AspNetUserClaim>();
            AspNetUserLogins = new System.Collections.Generic.List<AspNetUserLogin>();
            AspNetUserRoles = new System.Collections.Generic.List<AspNetUserRole>();
        }
    }
}
