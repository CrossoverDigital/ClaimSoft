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

namespace CD.ClaimSoft.Application.User
{
    /// <summary>
    /// User management interface.
    /// </summary>
    public interface IUserProfileHelper
    {
        #region Agency Methods

        /// <summary>
        /// Get User Agencies.
        /// </summary>
        /// <param name="userId">The user identifier.</param>
        /// <returns>
        /// The list of Agencies the user has. <see cref="Agency" />
        /// </returns>
        List<Agency> UserAgencies(string userId);
        
        #endregion
    }
}