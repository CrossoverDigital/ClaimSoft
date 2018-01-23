using System;
using System.ComponentModel.DataAnnotations;
using CD.ClaimSoft.Application.Models.Common;

namespace CD.ClaimSoft.Application.Models.Agencies
{
    public class AgencyPhone
    {
        public int Id { get; set; }

        public int AgencyId { get; set; }

        [Required]
        [Display(Name = "Phone Type")]
        public int PhoneTypeId { get; set; }

        [Required]
        [DataType(DataType.PhoneNumber)]
        [MinLength(10)]
        [MaxLength(25)]
        [Display(Name = "Phone Number")]
        public string PhoneNumber { get; set; }

        public bool IsDefault { get; set; }

        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        /// <summary>
        /// Parent Agency pointed by [AgencyPhone].([AgencyId]) (FK_AgencyPhone_Agency)
        /// </summary>
        public Agency Agency { get; set; } // FK_AgencyPhone_Agency

        /// <summary>
        /// Parent PhoneType pointed by [AgencyPhone].([PhoneTypeId]) (FK_AgencyPhone_PhoneType)
        /// </summary>
        public PhoneType PhoneType { get; set; } // FK_AgencyPhone_PhoneType

        public AgencyPhone()
        {
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
