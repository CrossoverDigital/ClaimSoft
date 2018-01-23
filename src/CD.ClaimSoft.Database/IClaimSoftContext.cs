#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using CD.ClaimSoft.Common.EntityFramework;

namespace CD.ClaimSoft.Database
{
    /// <inheritdoc />
    /// <summary>
    /// Partial database context to extend the save operations.
    /// </summary>
    public partial interface IClaimSoftContext
    {
        /// <summary>
        /// Saves the changes with validation.
        /// </summary>
        /// <returns>The EfStatus model containing the result of the save.</returns>
        EfStatus SaveChangesWithValidation();
    }
}
