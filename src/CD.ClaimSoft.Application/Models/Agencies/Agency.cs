using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using CD.ClaimSoft.Application.Models.Common;

namespace CD.ClaimSoft.Application.Models.Agencies
{
    public class Agency
    {
        public int AgencyId { get; set; } // Id (Primary key)
        public string AgencyTenantId { get; set; } // AgencyTenantId (length: 128)

        [Required]
        [DataType(DataType.Text)]
        [MinLength(3)]
        [MaxLength(50)]
        [Display(Name = "Code")]

        public string Code { get; set; } // Code (length: 50)

        [Required]
        [DataType(DataType.Text)]
        [MaxLength(100)]
        [Display(Name = "Name")]
        public string Name { get; set; } // Name (length: 100)

        public bool IsActive { get; set; } // IsActive

        public System.DateTime? InactivedDate { get; set; } // InactivedDate

        [Display(Name = "Parent Agency")]
        public int? ParentAgencyId { get; set; } // ParentAgencyId

        [Display(Name = "Time Zone")]
        public string AgencyTimeZone { get; set; } // AgencyTimeZone (length: 100)

        public bool UsesDaylightSavings { get; set; } // UsesDaylightSavings

        [Display(Name = "Web Site")]
        public string WebSite { get; set; } // WebSite (length: 250)

        [Required]
        [DataType(DataType.Text)]
        [MaxLength(250)]
        [Display(Name = "Contact Name")]
        public string ContactName { get; set; } // ContactName (length: 250)
        public int NpiNumber { get; set; } // NpiNumber
        public int? TaxIdNumber { get; set; } // TaxIdNumber
        public string Taxonomy { get; set; } // Taxonomy (length: 50)
        public bool DisableLifetimeSignature { get; set; } // DisableLifetimeSignature
        public bool PatientDataUseNemsis { get; set; } // PatientDataUseNemsis
        public bool ClaimDataUseNemsis { get; set; } // ClaimDataUseNemsis
        public string NemsisTimezone { get; set; } // NemsisTimezone (length: 100)
        public int? DefaultClaimTagId { get; set; } // DefaultClaimTagId
        public int? UnitRoundingTypeId { get; set; } // UnitRoundingTypeId
        public string ImagePath { get; set; } // ImagePath (length: 250)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        /// <summary>
        /// Child AgencyAddresses where [AgencyAddress].[AgencyId] point to this entity (FK_AgencyAddress_Agency)
        /// </summary>
        public ICollection<AgencyAddress> AgencyAddresses { get; set; } // AgencyAddress.FK_AgencyAddress_Agency

        public ICollection<AgencyEmail> AgencyEmails { get; set; }
        /// <summary>
        /// Child AgencyNumbers where [AgencyNumber].[AgencyId] point to this entity (FK_AgencyNumber_Agency)
        /// </summary>
        public ICollection<AgencyNumber> AgencyNumbers { get; set; } // AgencyNumber.FK_AgencyNumber_Agency
        /// <summary>
        /// Child AgencyPhones where [AgencyPhone].[AgencyId] point to this entity (FK_AgencyPhone_Agency)
        /// </summary>
        public ICollection<AgencyPhone> AgencyPhones { get; set; } // AgencyPhone.FK_AgencyPhone_Agency
        /// <summary>
        /// Child AgencyUsers where [AgencyUser].[AgencyId] point to this entity (FK_AgencyUser_Agency)
        /// </summary>
        public ICollection<AgencyUser> AgencyUsers { get; set; } // AgencyUser.FK_AgencyUser_Agency

        // Foreign keys

        /// <summary>
        /// Parent Agency pointed by [Agency].([ParentAgencyId]) (FK_Agency_Agency)
        /// </summary>
        public Agency ParentAgency { get; set; } // FK_Agency_Agency

        /// <summary>
        /// Parent UnitRoundingType pointed by [Agency].([UnitRoundingTypeId]) (FK_Agency_UnitRoundingType)
        /// </summary>
        public UnitRoundingType UnitRoundingType { get; set; } // FK_Agency_UnitRoundingType

        public Agency()
        {
            IsActive = true;
            UsesDaylightSavings = false;
            DisableLifetimeSignature = false;
            PatientDataUseNemsis = false;
            ClaimDataUseNemsis = false;
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
            AgencyAddresses = new List<AgencyAddress>();
            AgencyEmails = new List<AgencyEmail>();
            AgencyNumbers = new List<AgencyNumber>();
            AgencyPhones = new List<AgencyPhone>();
            AgencyUsers = new List<AgencyUser>();
        }
    }
}
