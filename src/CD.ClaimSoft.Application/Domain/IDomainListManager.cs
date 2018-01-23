#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Collections.Generic;

using Model = CD.ClaimSoft.Application.Models;

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
        List<Model.Common.Country> GetCountryList();

        /// <summary>
        /// Gets the county list.
        /// </summary>
        /// <returns>The county list.</returns>
        List<Model.Common.County> GetCountyList();

        /// <summary>
        /// Gets the state list.
        /// </summary>
        /// <returns>The state list.</returns>
        List<Model.Common.State> GetStateList();

        /// <summary>
        /// Gets the time zones.
        /// </summary>
        /// <returns>The time zones.</returns>
        List<TimeZoneInfo> GetTimeZonesList();

        /// <summary>
        /// Gets the address type list.
        /// </summary>
        /// <returns>The address type list.</returns>
        List<Model.Common.AddressType> GetAddressTypeList();

        /// <summary>
        /// Gets the phone type list.
        /// </summary>
        /// <returns>The phone type list.</returns>
        List<Model.Common.PhoneType> GetPhoneTypeList();

        /// <summary>
        /// Gets the email type list.
        /// </summary>
        /// <returns>The email type list.</returns>
        List<Model.Common.EmailType> GetEmailTypeList();

        /// <summary>
        /// Gets the unit rounding type list.
        /// </summary>
        /// <returns>The unit rounding type list.</returns>
        List<Model.Common.UnitRoundingType> GetUnitRoundingTypeList();
    }
}