#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Collections.Generic;
using CD.ClaimSoft.Database.Model.Agency;
using CD.ClaimSoft.Database.Model.Common;

namespace CD.ClaimSoft.Application.Domain
{
    /// <summary>
    /// Interface that defines the domain list manager methods.
    /// </summary>
    public interface IDomainListManager
    {
        /// <summary>
        /// Gets the country list.
        /// </summary>
        /// <returns>The country list.</returns>
        List<Country> GetCountryList();

        /// <summary>
        /// Gets the county list.
        /// </summary>
        /// <returns>The county list.</returns>
        List<County> GetCountyList();

        /// <summary>
        /// Gets the state list.
        /// </summary>
        /// <returns>The state list.</returns>
        List<State> GetStateList();

        /// <summary>
        /// Gets the time zones.
        /// </summary>
        /// <returns>The time zones.</returns>
        List<TimeZoneInfo> GetTimeZonesList();

        /// <summary>
        /// Gets the address type list.
        /// </summary>
        /// <returns>The address type list.</returns>
        List<AddressType> GetAddressTypeList();

        /// <summary>
        /// Gets the phone type list.
        /// </summary>
        /// <returns>The phone type list.</returns>
        List<PhoneType> GetPhoneTypeList();

        /// <summary>
        /// Gets the email type list.
        /// </summary>
        /// <returns>The email type list.</returns>
        List<EmailType> GetEmailTypeList();

        /// <summary>
        /// Gets the unit rounding type list.
        /// </summary>
        /// <returns>The unit rounding type list.</returns>
        List<UnitRoundingType> GetUnitRoundingTypeList();

        /// <summary>
        /// Gets all the agencies in ClaimSoft.
        /// </summary>
        /// <returns>
        /// The collection of all the agencies in ClaimSoft.
        /// </returns>
        List<Agency> GetAllAgenciesList();

        /// <summary>
        /// Gets the file type list.
        /// </summary>
        /// <returns>The file type list.</returns>
        List<FileType> GetFileTypeList();
    }
}