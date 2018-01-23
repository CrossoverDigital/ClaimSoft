#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System.Collections.Generic;

using CD.ClaimSoft.Common.EntityFramework;

namespace CD.ClaimSoft.Application.Administration
{
    /// <summary>
    /// Agency management interface.
    /// </summary>
    public interface IAgencyManager
    {
        #region Agency Methods

        /// <summary>
        /// Gets the colection of all agencies in the application..
        /// </summary>
        /// <returns>The colection of all agencies in the application.</returns>
        List<Models.Agencies.Agency> GetAgencies();

        /// <summary>
        /// Creates a new agency.
        /// </summary>
        /// <param name="agency">The new agency.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus CreateAgency(Models.Agencies.Agency agency);

        /// <summary>
        /// Updates the agency.
        /// </summary>
        /// <param name="agency">The agency to update.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus UpdateAgency(Models.Agencies.Agency agency);

        #endregion

        #region Agency Address Methods

        /// <summary>
        /// Gets the agency address.
        /// </summary>
        /// <param name="agencyAddressId">The agency address identifier.</param>
        /// <returns>The specified agency address.</returns>
        Models.Agencies.AgencyAddress GetAgencyAddress(int agencyAddressId);

        /// <summary>
        /// Creates the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address to create.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus CreateAgencyAddress(Models.Agencies.AgencyAddress agencyAddress);

        /// <summary>
        /// Updates the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus UpdateAgencyAddress(Models.Agencies.AgencyAddress agencyAddress);

        /// <summary>
        /// Deletes the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address to remove.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus DeleteAgencyAddress(Models.Agencies.AgencyAddress agencyAddress);

        #endregion

        #region Agency Number Methods

        /// <summary>
        /// Gets the agency number.
        /// </summary>
        /// <param name="numberId">The number identifier.</param>
        /// <returns>The agency number for the specified numberId.</returns>
        Models.Agencies.AgencyNumber GetAgencyNumber(int numberId);

        /// <summary>
        /// Creates a new agency number.
        /// </summary>
        /// <param name="agencyNumber">The agency number.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus CreateAgencyNumber(Models.Agencies.AgencyNumber agencyNumber);

        /// <summary>
        /// Updates the agency number.
        /// </summary>
        /// <param name="agencyNumber">The agency number.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus UpdateAgencyNumber(Models.Agencies.AgencyNumber agencyNumber);

        /// <summary>
        /// Deletes the agency number.
        /// </summary>
        /// <param name="agencyNumber">The agency number.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus DeleteAgencyNumber(Models.Agencies.AgencyNumber agencyNumber);

        #endregion

        #region Agency Phone Methods

        /// <summary>
        /// Gets the agency phone.
        /// </summary>
        /// <param name="phoneId">The phone identifier.</param>
        /// <returns>The agency phone for the specified identifier.</returns>
        Models.Agencies.AgencyPhone GetAgencyPhone(int phoneId);

        /// <summary>
        /// Creates a new agency phone.
        /// </summary>
        /// <param name="agencyPhone">The agency phone.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus CreateAgencyPhone(Models.Agencies.AgencyPhone agencyPhone);

        /// <summary>
        /// Updates the agency phone.
        /// </summary>
        /// <param name="agencyPhone">The agency phone.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus UpdateAgencyPhone(Models.Agencies.AgencyPhone agencyPhone);

        /// <summary>
        /// Deletes the agency phone.
        /// </summary>
        /// <param name="agencyPhone">The agency phone.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus DeleteAgencyPhone(Models.Agencies.AgencyPhone agencyPhone);

        #endregion
    }
}