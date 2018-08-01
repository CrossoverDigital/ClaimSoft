using System;
using CD.ClaimSoft.Database.Model.Common;

namespace CD.ClaimSoft.Database.Model.Agency
{
    [Serializable]
    public class AgencyEmail
    {
        public int Id { get; set; } // Id (Primary key)
        public int AgencyId { get; set; } // AgencyId
        public int EmailTypeId { get; set; } // EmailTypeId
        public string EmailAddress { get; set; } // EmailAddress (length: 255)

        public bool IsDefault { get; set; }

        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        // Foreign keys

        /// <summary>
        /// Parent Agency pointed by [AgencyEmail].([AgencyId]) (FK_AgencyEmail_Agency)
        /// </summary>
        public Agency Agency { get; set; }

        /// <summary>
        /// Parent EmailType pointed by [AgencyEmail].([EmailTypeId]) (FK_AgencyEmail_EmailType)
        /// </summary>
        public EmailType EmailType { get; set; }

        public AgencyEmail()
        {
            CreateBy = "CDUNCAN";
            CreateDate = DateTime.Now;
            LastModifyBy = "CDUNCAN";
            LastModifyDate = DateTime.Now;
        }
    }
}