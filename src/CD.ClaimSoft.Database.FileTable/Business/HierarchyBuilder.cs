#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;

using CD.ClaimSoft.Database.FileTable.Interfaces;

namespace CD.ClaimSoft.Database.FileTable.Business
{
    /// <inheritdoc />
    /// <summary>
    /// Manages FileTable hierarchy.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.Database.FileTable.Interfaces.IHierarchyBuilder" />
    public class HierarchyBuilder : IHierarchyBuilder
    {
        /// <inheritdoc />
        /// <summary>
        /// Gets the new HierachyId as string.
        /// </summary>
        /// <param name="pathId">The path id.</param>
        /// <returns>The new HierachyId as string.</returns>
        public string NewChildHierarchyId(string pathId)
        {
            return NewChildHierarchyId(pathId, Guid.NewGuid());
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the new HierachyId as string.
        /// </summary>
        /// <param name="pathId">The path id.</param>
        /// <param name="guid">The Guid to append to the path id.</param>
        /// <returns>The new HierachyId as string.</returns>
        public string NewChildHierarchyId(string pathId, Guid guid)
        {
            var template = "{0}{1}.{2}.{3}/";
            var bytes = guid.ToByteArray();
            if (string.IsNullOrWhiteSpace(pathId))
                pathId = "/"; //Root
            var hierarchyId = string.Format(template, pathId, GetLong(0, 6, bytes), GetLong(6, 6, bytes), GetLong(12, 4, bytes));
            return hierarchyId;
        }

        /// <summary>
        /// Gets the long representation of the passed in byte array.
        /// </summary>
        /// <param name="sourceIndex">A 32-bit integer that represents the index in the sourceArray at which copying begins.</param>
        /// <param name="length">A 32-bit integer that represents the number of elements to copy.</param>
        /// <param name="bytes">The byte array to convert.</param>
        /// <returns>The long representation of the passed in byte array.</returns>
        public static long GetLong(int sourceIndex, int length, byte[] bytes)
        {
            var subBytes = new byte[8];

            Array.Copy(bytes, sourceIndex, subBytes, 8 - length, length);

            Array.Reverse(subBytes);

            return BitConverter.ToInt64(subBytes, 0);
        }
    }
}