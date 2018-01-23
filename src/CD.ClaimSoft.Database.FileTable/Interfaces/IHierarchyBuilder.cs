#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;

namespace CD.ClaimSoft.Database.FileTable.Interfaces
{
    /// <summary>
    /// Manages FileTable hierarchy.
    /// </summary>
    public interface IHierarchyBuilder
    {
        /// <summary>
        /// Gets the new HierachyId as string.
        /// </summary>
        /// <param name="pathId">The path id.</param>
        /// <returns>The new HierachyId as string.</returns>
        string NewChildHierarchyId(string pathId);

        /// <summary>
        /// Gets the new HierachyId as string.
        /// </summary>
        /// <param name="pathId">The path id.</param>
        /// <param name="guid">The Guid to append to the path id.</param>
        /// <returns>The new HierachyId as string.</returns>
        string NewChildHierarchyId(string pathId, Guid guid);
    }
}
