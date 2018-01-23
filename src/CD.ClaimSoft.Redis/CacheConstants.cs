#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

namespace CD.ClaimSoft.Redis
{
    /// <summary>
    /// The Cache constants for all keyed items in the cache. Used globally.
    /// </summary>
    public static class CacheConstants
    {
        #region Application Defaults

        /// <summary>
        /// The default time to live.
        /// </summary>
        public const int DefaultTimeToLive = 60;

        /// <summary>
        /// The default long time to live.
        /// </summary>
        public const int DefaultLongTimeToLive = 1440;

        #endregion

        #region Application Settings Keys

        /// <summary>
        /// The application settings list key.
        /// </summary>
        public const string ApplicationSettingsListKey = "Cache_Key_Application_Settings_List";

        /// <summary>
        /// The agency logo path key.
        /// </summary>
        public const string AgencyLogoPathKey = "AgencyLogoPath";

        #endregion

        #region Domain List Keys

        /// <summary>
        /// The country domain list key.
        /// </summary>
        public const string CountryDomainListKey = "Cache_Key_Country_Domain_List";

        /// <summary>
        /// The county domain list key.
        /// </summary>
        public const string CountyDomainListKey = "Cache_Key_County_Domain_List";

        /// <summary>
        /// The state domain list key.
        /// </summary>
        public const string StateDomainListKey = "Cache_Key_State_Domain_List";

        /// <summary>
        /// The time zones domain list key.
        /// </summary>
        public const string TimeZonesDomainListKey = "Cache_Key_TimeZones_Domain_List";

        /// <summary>
        /// The address type domain list key.
        /// </summary>
        public const string AddressTypeDomainListKey = "Cache_Key_AddressType_Domain_List";

        /// <summary>
        /// The phone type domain list key.
        /// </summary>
        public const string PhoneTypeDomainListKey = "Cache_Key_PhoneType_Domain_List";

        /// <summary>
        /// The email type domain list key.
        /// </summary>
        public const string EmailTypeDomainListKey = "Cache_Key_EmailType_Domain_List";

        /// <summary>
        /// The unit rounding type domain list key.
        /// </summary>
        public const string UnitRoundingTypeDomainListKey = "Cache_Key_UnitRoundingType_Domain_List";

        #endregion

        #region Agency Keys

        /// <summary>
        /// All agencies key.
        /// </summary>
        public const string AllAgenciesKey = "Cache_Key_All_Agencies_List";

        #endregion
    }
}
