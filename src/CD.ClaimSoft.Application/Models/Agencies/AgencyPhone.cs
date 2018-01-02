using System;
using System.ComponentModel.DataAnnotations;
using CD.ClaimSoft.Application.Models.Common;

namespace CD.ClaimSoft.Application.Models.Agencies
{
    public class AgencyPhone
    {
        public int Id { get; set; } // Id (Primary key)
        public int AgencyId { get; set; } // AgencyId
        public int PhoneTypeId { get; set; } // PhoneTypeId

        [Required]
        //[DataType(DataType.PhoneNumber)]
        [MinLength(3)]
        [MaxLength(3)]
        [Display(Name = "Area Code")]
        public int AreaCode { get; set; } // AreaCode
        public int Prefix { get; set; } // Prefix
        public int LineNumber { get; set; } // LineNumber
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        private string _phoneNumber = string.Empty;
        public string PhoneNumber
        {
            get
            {
                return $"({AreaCode}) {Prefix}-{LineNumber}";
            }
            private set
            {
                _phoneNumber = value;
            }
        }

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
