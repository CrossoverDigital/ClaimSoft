using System;
using CD.ClaimSoft.Application.Models.Common;

namespace CD.ClaimSoft.Application.Models.Agencies
{
    public class AgencyAddress
    {
        public int Id { get; set; } // Id (Primary key)
        public int AgencyId { get; set; } // AgencyId
        public int AddressTypeId { get; set; } // AddressTypeId
        public string Address1 { get; set; } // Address1 (length: 150)
        public string Address2 { get; set; } // Address2 (length: 150)
        public string City { get; set; } // City (length: 150)
        public int? CountyId { get; set; } // CountyId
        public int StateId { get; set; } // StateId
        public int? CountryId { get; set; } // CountryId
        public string ZipCode { get; set; } // ZipCode (length: 15)
        public bool IsPayToAddress { get; set; } // IsPayToAddress
        public bool IsReturnAddress { get; set; } // IsReturnAddress
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public System.DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public System.DateTime LastModifyDate { get; set; } // LastModifyDate

        // Foreign keys

        /// <summary>
        /// Parent AddressType pointed by [AgencyAddress].([AddressTypeId]) (FK_AgencyAddress_AddressType)
        /// </summary>
        public AddressType AddressType { get; set; } // FK_AgencyAddress_AddressType

        /// <summary>
        /// Parent Agency pointed by [AgencyAddress].([AgencyId]) (FK_AgencyAddress_Agency)
        /// </summary>
        public Agency Agency { get; set; } // FK_AgencyAddress_Agency

        /// <summary>
        /// Parent Country pointed by [AgencyAddress].([CountyId]) (FK_AgencyAddress_Country)
        /// </summary>
        public Country Country { get; set; } // FK_AgencyAddress_Country

        /// <summary>
        /// Parent County pointed by [AgencyAddress].([CountyId]) (FK_AgencyAddress_County)
        /// </summary>
        public County County { get; set; } // FK_AgencyAddress_County

        /// <summary>
        /// Parent State pointed by [AgencyAddress].([StateId]) (FK_AgencyAddress_State)
        /// </summary>
        public State State { get; set; } // FK_AgencyAddress_State

        public AgencyAddress()
        {
            IsPayToAddress = false;
            IsReturnAddress = false;
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
