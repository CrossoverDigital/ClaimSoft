#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

namespace CD.ClaimSoft.Database.FileTable.Extensions
{
    /// <summary>
    /// Directory extension methods for working with directories in the FileTables.
    /// </summary>
    public static class StringDirectoryExtensions
    {
        /// <summary>
        /// Gets the relative path.
        /// </summary>
        /// <param name="fullPath">The full path.</param>
        /// <param name="root">The root.</param>
        /// <returns>The relative path.</returns>
        public static string GetRelativePath(this string fullPath, string root)
        {
            var index = 0;

            do
            {
                root = root.Substring(index);
                if (fullPath.StartsWith(root))
                {
                    return fullPath.Remove(0, root.Length);
                }
            } while ((index = GetNextIndex(root)) > 0);

            return fullPath;
        }

        /// <summary>
        /// Gets the next index.
        /// </summary>
        /// <param name="root">The root.</param>
        /// <returns>The next index.</returns>
        private static int GetNextIndex(string root)
        {
            var index = root.IndexOfAny(@"\/".ToCharArray());

            return index == 0 ? 1 : index;
        }

        /// <summary>
        /// Splits the path by directory.
        /// </summary>
        /// <param name="path">The path.</param>
        /// <returns>Directory array generated from the given path.</returns>
        public static string[] SplitByDirectory(this string path)
        {
            var splitChars = @"\/".ToCharArray();

            return path.Trim().Trim(splitChars).Split(splitChars);
        }
    }
}
