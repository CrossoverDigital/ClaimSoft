#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System.IO;
using System.Linq;

namespace CD.ClaimSoft.Common.Utlilty
{
    /// <summary>
    /// File utility class for all utility methods for processing files for upload and download.
    /// </summary>
    public static class FileUtility
    {
        /// <summary>
        /// Removes the invalid characters.
        /// </summary>
        /// <param name="stringToClean">String to clean (path or file name).</param>
        /// <returns>Clean string.</returns>
        public static string RemoveInvalidCharacters(string stringToClean)
        {
            return Path.GetInvalidFileNameChars().Aggregate(stringToClean, (current, c) => current.Replace(c.ToString(), string.Empty));
        }
    }
}
