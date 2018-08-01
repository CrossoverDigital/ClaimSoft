#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System.Collections.Generic;
using CD.ClaimSoft.Common.EntityFramework;
using CD.ClaimSoft.Database.Model.Agency;

namespace CD.ClaimSoft.Application.Administration
{
    /// <summary>
    /// Agency management interface.
    /// </summary>
    public interface IAgencyManager
    {
        #region Agency Methods

        /// <summary>
        /// Creates a new agency.
        /// </summary>
        /// <param name="agency">The new agency.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus CreateAgency(Agency agency);

        /// <summary>
        /// Updates the agency.
        /// </summary>
        /// <param name="agency">The agency to update.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus UpdateAgency(Agency agency);

        #endregion

        #region Agency Address Methods

        /// <summary>
        /// Gets the agency address.
        /// </summary>
        /// <param name="agencyAddressId">The agency address identifier.</param>
        /// <returns>The specified agency address.</returns>
        AgencyAddress GetAgencyAddress(int agencyAddressId);

        /// <summary>
        /// Creates the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address to create.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus CreateAgencyAddress(AgencyAddress agencyAddress);

        /// <summary>
        /// Updates the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus UpdateAgencyAddress(AgencyAddress agencyAddress);
        
        /// <summary>
        /// Deletes the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address to remove.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus"/></returns>
        EfStatus DeleteAgencyAddress(AgencyAddress agencyAddress);

        #endregion

        #region Agency File Methods

        /// <summary>
        /// Gets the agency files.
        /// </summary>
        /// <param name="agencyId">The agency identifier.</param>
        /// <returns>
        /// Collection of agency files. <see cref="AgencyFile" />
        /// </returns>
        IEnumerable<AgencyFile> GetAgencyFiles(int agencyId);

        /// <summary>
        /// Inserts the agency file.
        /// </summary>
        /// <param name="agencyFile">The agency file. <see cref="AgencyFile" /></param>
        /// <returns>
        /// The Entity Framework status object. <see cref="EfStatus" />
        /// </returns>
        EfStatus InsertAgencyFile(AgencyFile agencyFile);

        #endregion
    }
}