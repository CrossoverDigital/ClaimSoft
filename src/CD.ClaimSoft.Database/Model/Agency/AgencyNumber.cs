using System;
using System.ComponentModel.DataAnnotations;

namespace CD.ClaimSoft.Database.Model.Agency
{
    [Serializable]
    public class AgencyNumber
    {
        public int Id { get; set; } // Id (Primary key)
        public int AgencyId { get; set; } // AgencyId

        [Required]
        [DataType(DataType.Text)]
        [MinLength(3)]
        [MaxLength(50)]
        [Display(Name = "Number")]
        public string Number { get; set; } // Number (length: 50)
        public bool IgnoreTimeStamps { get; set; } // IgnoreTimeStamps
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        // Foreign keys

        /// <summary>
        /// Parent Agency pointed by [AgencyNumber].([AgencyId]) (FK_AgencyNumber_Agency)
        /// </summary>
        public Agency Agency { get; set; } // FK_AgencyNumber_Agency

        public AgencyNumber()
        {
            IgnoreTimeStamps = false;
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
