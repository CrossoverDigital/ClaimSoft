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
using CD.ClaimSoft.Application.Models.Common;

namespace CD.ClaimSoft.Application.Models.Agencies
{
    public class Agency
    {
        /// <summary>
        /// Gets or sets the agency identifier.
        /// </summary>
        /// <value>
        /// The agency identifier.
        /// </value>
        public int AgencyId { get; set; }

        /// <summary>
        /// Gets or sets the agency tenant identifier.
        /// </summary>
        /// <value>
        /// The agency tenant identifier.
        /// </value>
        [Display(Name = "Agency Tenant Id")]
        public string AgencyTenantId { get; set; }

        /// <summary>
        /// Gets or sets the code.
        /// </summary>
        /// <value>
        /// The code.
        /// </value>
        [Required]
        [DataType(DataType.Text)]
        [MinLength(3)]
        [MaxLength(50)]
        [Display(Name = "Code")]

        public string Code { get; set; }

        /// <summary>
        /// Gets or sets the name.
        /// </summary>
        /// <value>
        /// The name.
        /// </value>
        [Required]
        [DataType(DataType.Text)]
        [MaxLength(100)]
        [Display(Name = "Name")]
        public string Name { get; set; }

        /// <summary>
        /// Gets or sets a value indicating whether this instance is active.
        /// </summary>
        /// <value>
        ///   <c>true</c> if this instance is active; otherwise, <c>false</c>.
        /// </value>
        [Display(Name = "Is Active")]
        public bool IsActive { get; set; }

        /// <summary>
        /// Gets or sets the inactive date.
        /// </summary>
        /// <value>
        /// The inactive date.
        /// </value>
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
        /// Gets or sets the npi number.
        /// </summary>
        /// <value>
        /// The npi number.
        /// </value>
        [Required]
        [Display(Name = "NPI Number")]
        public int NpiNumber { get; set; }

        /// <summary>
        /// Gets or sets the tax identifier number.
        /// </summary>
        /// <value>
        /// The tax identifier number.
        /// </value>
        [Display(Name = "Tax Number")]
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
        [Display(Name = "Disable Lifetime Signature")]
        public bool DisableLifetimeSignature { get; set; }

        /// <summary>
        /// Gets or sets the name of the logo file.
        /// </summary>
        /// <value>
        /// The name of the logo file.
        /// </value>
        [Display(Name = "Logo File Name")]
        [MaxLength(50)]
        public string LogoFileName { get; set; }

        /// <summary>
        /// Gets or sets the logo stream identifier.
        /// </summary>
        /// <value>
        /// The logo stream identifier.
        /// </value>
        [Display(Name = "Logo Steam ID")]
        [MaxLength(250)]
        public Guid? LogoStreamId { get; set; }

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
        [Display(Name = "Use Image on Statements")]
        public bool UseImageOnStatement { get; set; }

        /// <summary>
        /// Gets or sets the create by.
        /// </summary>
        /// <value>
        /// The create by.
        /// </value>
        public string CreateBy { get; set; }

        /// <summary>
        /// Gets or sets the create date.
        /// </summary>
        /// <value>
        /// The create date.
        /// </value>
        public DateTime CreateDate { get; set; }

        /// <summary>
        /// Gets or sets the last modify by.
        /// </summary>
        /// <value>
        /// The last modify by.
        /// </value>
        public string LastModifyBy { get; set; }

        /// <summary>
        /// Gets or sets the last modify date.
        /// </summary>
        /// <value>
        /// The last modify date.
        /// </value>
        public DateTime LastModifyDate { get; set; }

        /// <summary>
        /// Gets or sets the agency addresses.
        /// </summary>
        /// <value>
        /// The agency addresses.
        /// </value>
        public ICollection<AgencyAddress> AgencyAddresses { get; set; }

        /// <summary>
        /// Gets or sets the agency emails.
        /// </summary>
        /// <value>
        /// The agency emails.
        /// </value>
        public ICollection<AgencyEmail> AgencyEmails { get; set; }

        /// <summary>
        /// Gets or sets the agency numbers.
        /// </summary>
        /// <value>
        /// The agency numbers.
        /// </value>
        public ICollection<AgencyNumber> AgencyNumbers { get; set; }

        /// <summary>
        /// Gets or sets the agency phones.
        /// </summary>
        /// <value>
        /// The agency phones.
        /// </value>
        public ICollection<AgencyPhone> AgencyPhones { get; set; }

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
            AgencyEmails = new List<AgencyEmail>();
            AgencyNumbers = new List<AgencyNumber>();
            AgencyPhones = new List<AgencyPhone>();
            AgencyUsers = new List<AgencyUser>();
        }
    }
}
