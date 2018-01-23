#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Data.SqlClient;

namespace CD.ClaimSoft.Database.FileTable.Interfaces
{
    /// <summary>
    /// Repository class that manages the creation and removal of files and directories 
    /// for the SQL Server File Tables.
    /// </summary>
    public interface IFileTableRepository
    {
        /// <summary>
        /// Creates a directory at the specified location using the location HierachyId as a string. If hierarchyid is null, 
        /// empty, or whitespace, the directory is added to the root.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="fileName">The name of the file to create. It should not include a path.</param>
        /// <param name="hierarchyId">The hierarchy identifier.</param>
        /// <param name="data">The file data.</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <returns>
        /// The Stream ID for the new file.
        /// </returns>
        Guid CreateFile(string table, string fileName, string hierarchyId, byte[] data, SqlConnection sqlConnection);

        /// <summary>
        /// Creates a directory at the specified location using the location HierachyId as a string. If hierarchyId is null, 
        /// empty, or whitespace, the directory is added to the root.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="directory">The directory.</param>
        /// <param name="hierarchyId">The string representation of the HierarchyId, which is the path_locator column.</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <returns>
        /// The Path ID for the new directory.
        /// </returns>
        string CreateDirectory(string table, string directory, string hierarchyId, SqlConnection sqlConnection);

        /// <summary>
        /// Finds the path.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="path">The path.</param>
        /// <param name="isDirectory">if set to <c>true</c> [is directory].</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <returns>
        /// The path locator for the given path.
        /// </returns>
        string FindPath(string table, string path, bool isDirectory, SqlConnection sqlConnection);

        /// <summary>
        /// Checks if the FileTable exists.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <returns><code>true</code> if the file table exists.</returns>
        bool FileTableExists(string table, SqlConnection sqlConnection);

        /// <summary>
        /// Gets the root path of a FileTable.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="option">The option.</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <returns>The table root path.</returns>
        string GetTableRootPath(string table, int option, SqlConnection sqlConnection);

        /// <summary>
        /// Determines whether the table root is the specified path.
        /// </summary>
        /// <param name="path">The path.</param>
        /// <param name="tableRoot">The table root.</param>
        /// <param name="tableRootFqdn">The table root FQDN.</param>
        /// <returns>
        ///   <c>true</c> if the table root is the specified path; otherwise, <c>false</c>.
        /// </returns>
        bool IsTableRoot(string path, string tableRoot, string tableRootFqdn);
    }
}
