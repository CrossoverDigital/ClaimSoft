#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

using CD.ClaimSoft.Database.Model.Common;

namespace CD.ClaimSoft.Database.Model.Agency
{
    [Serializable]
    public class Agency
    {
        /// <summary>
        /// Gets or sets the agency identifier. (Primary key)
        /// </summary>
        /// <value>
        /// The agency identifier.
        /// </value>
        [Required]
        public int AgencyId { get; set; }

        /// <summary>
        /// NEMSIS V2 - D01_01 Element - The state-assigned provider number of the agency
        /// </summary>
        /// <value>
        /// The agency number.
        /// </value>
        [Required]
        [MaxLength(15)]
        [Display(Name = "Agency Number")]
        public string AgencyNumber { get; set; }

        /// <summary>
        /// NEMSIS V2 - D01_02 Element - The name of the agency
        /// </summary>
        /// <value>
        /// The name of the agency.
        /// </value>
        [Required]
        [DataType(DataType.Text)]
        [MaxLength(100)]
        [Display(Name = "Agency Name")]
        public string AgencyName { get; set; }

        /// <summary>
        /// NEMSIS V2 - D01_05 Element - The agency primary service type
        /// </summary>
        /// <value>
        /// The type of the primary service.
        /// </value>
        [Display(Name = "Primary Service Type")]
        public int? PrimaryServiceType { get; set; }

        /// <summary>
        /// NEMSIS V2 - D01_07 Element - The agency level of service
        /// </summary>
        /// <value>
        /// The level of service.
        /// </value>
        [Required]
        [DataType(DataType.Text)]
        [MaxLength(30)]
        [Display(Name = "Level Of Service")]
        public string LevelOfService { get; set; }

        /// <summary>
        /// NEMSIS V2 - D01_08 Element - The agency organization type
        /// </summary>
        /// <value>
        /// The type of the organization.
        /// </value>
        [Display(Name = "Organization Type")]
        public int OrganizationType { get; set; }

        /// <summary>
        /// NEMSIS V2 - D01_09 Element - The agency organization status
        /// </summary>
        /// <value>
        /// The organization status.
        /// </value>
        [Display(Name = "Organization Status")]
        public int OrganizationStatus { get; set; }

        /// <summary>
        /// NEMSIS V2 - D01_19 Element - The agency time zone
        /// </summary>
        /// <value>
        /// The time zone.
        /// </value>
        [Display(Name = "Time Zone")]
        public int? TimeZone { get; set; }

        /// <summary>
        /// NEMSIS V2 - D01_20 Element - The agency daylight savings setting
        /// </summary>
        /// <value>
        /// The daylight savings.
        /// </value>
        [Display(Name = "Daylight Savings")]
        public int? DaylightSavings { get; set; }

        /// <summary>
        /// NEMSIS V2 - D01_21 Element - The agency national provider ID
        /// </summary>
        /// <value>
        /// The national provider identifier.
        /// </value>
        [Required]
        [DataType(DataType.Text)]
        [MaxLength(10)]
        [Display(Name = "National Provider Id")]
        public string NationalProviderId { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is active.
        /// </summary>
        /// <value>
        ///   <c>true</c> if this instance is active; otherwise, <c>false</c>.
        /// </value>
        [Required]
        [Display(Name = "Is Active")]
        public bool IsActive { get; set; }

        /// <summary>
        /// Gets or sets the inactive date.
        /// </summary>
        /// <value>
        /// The inactive date.
        /// </value>
        [DataType(DataType.DateTime)]
        [Display(Name = "Date Inactivated")]
        public DateTime? InactiveDate { get; set; }

        /// <summary>
        /// Gets or sets the parent agency identifier.
        /// </summary>
        /// <value>
        /// The parent agency identifier.
        /// </value>
        [Display(Name = "Parent Agency")]
        public int? ParentAgencyId { get; set; }

        /// <summary>
        /// Gets or sets the web site.
        /// </summary>
        /// <value>
        /// The web site.
        /// </value>
        [Display(Name = "Web Site")]
        [DataType(DataType.Url)]
        [MaxLength(250)]
        public string WebSite { get; set; }

        /// <summary>
        /// Gets or sets the name of the contact.
        /// </summary>
        /// <value>
        /// The name of the contact.
        /// </value>
        [Required]
        [DataType(DataType.Text)]
        [MaxLength(250)]
        [Display(Name = "Contact Name")]
        public string ContactName { get; set; }

        /// <summary>
        /// Gets or sets the tax identifier number.
        /// </summary>
        /// <value>
        /// The tax identifier number.
        /// </value>
        [Display(Name = "Tax Id Number")]
        public int? TaxIdNumber { get; set; }

        /// <summary>
        /// Gets or sets the taxonomy identifier.
        /// </summary>
        /// <value>
        /// The taxonomy identifier.
        /// </value>
        [Required]
        [DataType(DataType.Text)]
        [MinLength(9)]
        [MaxLength(50)]
        [Display(Name = "Taxonomy")]
        public string Taxonomy { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether [disable lifetime signature].
        /// </summary>
        /// <value>
        ///   <c>true</c> if [disable lifetime signature]; otherwise, <c>false</c>.
        /// </value>
        [Required]
        [Display(Name = "Disable Lifetime Signature")]
        public bool DisableLifetimeSignature { get; set; }

        /// <summary>
        /// Gets or sets the name of the logo file.
        /// </summary>
        /// <value>
        /// The name of the logo file.
        /// </value>
        [DataType(DataType.Text)]
        [MaxLength(255)]
        [Display(Name = "Logo File Name")]
        public string LogoFileName { get; set; }

        /// <summary>
        /// Gets or sets the logo stream identifier.
        /// </summary>
        /// <value>
        /// The logo stream identifier.
        /// </value>
        [DataType(DataType.Text)]
        [MaxLength(128)]
        [Display(Name = "Logo Stream ID")]
        public string LogoStreamId { get; set; }

        /// <summary>
        /// Gets or sets the logo.
        /// </summary>
        /// <value>
        /// The logo.
        /// </value>
        [Display(Name = "Logo")]
        public byte[] Logo { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether to use the image on the statements.
        /// </summary>
        /// <value>
        ///   <c>true</c> if use the image on the statements; otherwise, <c>false</c>.
        /// </value>
        [Required]
        [Display(Name = "Use Image on Statements")]
        public bool UseImageOnStatement { get; set; }

        /// <summary>
        /// Gets or sets the create by.
        /// </summary>
        /// <value>
        /// The create by.
        /// </value>
        [Required]
        [MaxLength(128)]
        [Display(Name = "Created By")]
        public string CreateBy { get; set; }

        /// <summary>
        /// Gets or sets the create date.
        /// </summary>
        /// <value>
        /// The create date.
        /// </value>
        [Required]
        [Display(Name = "Created Date")]
        public DateTime CreateDate { get; set; }

        /// <summary>
        /// Gets or sets the create by.
        /// </summary>
        /// <value>
        /// The create by.
        /// </value>
        [Required]
        [MaxLength(128)]
        [Display(Name = "Last Modify By")]
        public string LastModifyBy { get; set; }

        /// <summary>
        /// Gets or sets the create date.
        /// </summary>
        /// <value>
        /// The create date.
        /// </value>
        [Required]
        [Display(Name = "Last Modify Date")]
        public DateTime LastModifyDate { get; set; }

        /// <summary>
        /// Gets or sets the agency addresses.
        /// </summary>
        /// <value>
        /// The agency addresses.
        /// </value>
        public ICollection<AgencyAddress> AgencyAddresses { get; set; }
        
        /// <summary>
        /// Gets or sets the agency users.
        /// </summary>
        /// <value>
        /// The agency users.
        /// </value>
        public ICollection<AgencyUser> AgencyUsers { get; set; }

        /// <summary>
        /// Gets or sets the parent agency.
        /// </summary>
        /// <value>
        /// The parent agency.
        /// </value>
        public Agency ParentAgency { get; set; }

        /// <summary>
        /// Gets or sets the type of the unit rounding.
        /// </summary>
        /// <value>
        /// The type of the unit rounding.
        /// </value>
        public UnitRoundingType UnitRoundingType { get; set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="Agency"/> class.
        /// </summary>
        public Agency()
        {
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
            AgencyAddresses = new List<AgencyAddress>();
            AgencyUsers = new List<AgencyUser>();
        }
    }
}
