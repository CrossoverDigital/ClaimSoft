using System;
using CD.ClaimSoft.Application.Models.Users;

namespace CD.ClaimSoft.Application.Models.Agencies
{
    public class AgencyUser
    {
        public int Id { get; set; } // Id (Primary key)
        public int AgencyId { get; set; } // AgencyId
        public string AspNetUserId { get; set; } // AspNetUserId (length: 128)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        // Foreign keys

        /// <summary>
        /// Parent Agency pointed by [AgencyUser].([AgencyId]) (FK_AgencyUser_Agency)
        /// </summary>
        public Agency Agency { get; set; } // FK_AgencyUser_Agency

        /// <summary>
        /// Parent AspNetUser pointed by [AgencyUser].([AspNetUserId]) (FK_AgencyUser_AspNetUsers)
        /// </summary>
        public AspNetUser AspNetUser { get; set; } // FK_AgencyUser_AspNetUsers

        public AgencyUser()
        {
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
