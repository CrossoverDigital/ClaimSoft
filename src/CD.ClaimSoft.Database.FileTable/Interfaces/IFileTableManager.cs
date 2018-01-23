#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace CD.ClaimSoft.Database.FileTable.Interfaces
{
    /// <summary>
    /// Methods for managing the FileTables in SQL Server.
    /// </summary>
    public interface IFileTableManager
    {
        /// <summary>
        /// Checks for the existance of a directory in a FileTable.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="path">The path of the directory. It must be a full path, or a path relative from, but not including, the table's root directory.</param>
        /// <param name="sqlConnection">The Sql Connection string.</param>
        /// <returns>The directory's HierarchyId as a string if it exists, null if it doesn't.</returns>
        string DirectoryExists(string table, string path, SqlConnection sqlConnection);

        /// <summary>
        /// Checks for the existance of a file in a FileTable.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="path">The path of the directory. It must be a full path, or a path relative from, but not including, the table's root directory.</param>
        /// <param name="sqlConnection">The Sql Connection string.</param>
        /// <returns>The files's HierarchyId as a string if it exists, null if it doesn't.</returns>
        string FileExists(string table, string path, SqlConnection sqlConnection);

        /// <summary>
        /// Creates a directory in a FileTable. If it already exists, it must not error, but instead return the pathId.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="path">The path to create. It should create the full path, even if multiple directory levels need to be create: \a\b\c
        /// </param>
        /// <param name="sqlConnection">The Sql Connection string.</param>
        /// <returns>The directory's HierarchyId as a string.</returns>
        string CreateDirectory(string table, string path, SqlConnection sqlConnection);

        /// <summary>
        /// Creates the directory structure.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="directoriesToCreate">The directories to create.</param>
        /// <param name="pathId">The path identifier.</param>
        /// <param name="sqlConnection">The Sql Connection string.</param>
        /// <returns>The Path ID for the new directory.</returns>
        string CreateDirectoryStructure(string table, Stack<string> directoriesToCreate, string pathId, SqlConnection sqlConnection);

        /// <summary>
        /// Adds a file to a FileTable. Allows for specifying a path.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="path">The path of the file. It must be a full path, or a path relative from, but not including, the table's root directory.</param>
        /// <param name="data">The file in byte array format.</param>
        /// <param name="sqlConnection">The Sql Connection string.</param>
        /// <returns>The Stream ID for the new file.</returns>
        Guid CreateFile(string table, string path, byte[] data, SqlConnection sqlConnection);
    }
}
