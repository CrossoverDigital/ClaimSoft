#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Data.SqlClient;
using System.IO;

using CD.ClaimSoft.Database.FileTable.Business;
using CD.ClaimSoft.Database.FileTable.Extensions;
using CD.ClaimSoft.Database.FileTable.Interfaces;
using CD.ClaimSoft.Database.FileTable.Managers;

namespace CD.ClaimSoft.Database.FileTable.Repository
{
    /// <inheritdoc />
    /// <summary>
    /// Repository class that manages the creation and removal of files and directories 
    /// for the SQL Server File Tables.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.Database.FileTable.Interfaces.IFileTableRepository" />
    public sealed class FileTableRepository : IFileTableRepository
    {
        /// <inheritdoc />
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
        /// <exception cref="T:System.Exception">Table does not exist or is not a FileTable.</exception>
        public Guid CreateFile(string table, string fileName, string hierarchyId, byte[] data, SqlConnection sqlConnection)
        {
            SqlConnManager.IsConnected(sqlConnection);

            if (!FileTableExists(table, sqlConnection)) // This is used to prevent SQL injection
            {
                throw new Exception("Table does not exist or is not a FileTable.");
            }

            if (string.IsNullOrWhiteSpace(hierarchyId))
            {
                hierarchyId = HierarchyBuilder.NewChildHierarchyId(null);
            }

            var sqlCommand = new SqlCommand($"INSERT INTO {table} (name, file_stream, path_locator) OUTPUT Inserted.stream_id VALUES (@fileName, @data, HierarchyId::Parse(@pathId))", sqlConnection);

            sqlCommand.Parameters.Add(new SqlParameter("@fileName", fileName));
            sqlCommand.Parameters.Add(new SqlParameter("@data", data));
            sqlCommand.Parameters.Add(new SqlParameter("@pathId", hierarchyId));

            return (Guid)sqlCommand.ExecuteScalar();
        }

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
        /// <exception cref="Exception">Table does not exist or is not a FileTable.</exception>
        /// <exception cref="T:System.Exception">Table does not exist or is not a FileTable.</exception>
        /// <inheritdoc />
        public string CreateDirectory(string table, string directory, string hierarchyId, SqlConnection sqlConnection)
        {
            SqlConnManager.IsConnected(sqlConnection);

            if (!FileTableExists(table, sqlConnection))
            {
                throw new Exception("Table does not exist or is not a FileTable.");
            }

            var sqlCommand = new SqlCommand($"INSERT INTO {table} (name, is_directory) OUTPUT Inserted.path_locator.ToString() VALUES (@dir, 1)", sqlConnection);

            sqlCommand.Parameters.Add(new SqlParameter("@dir", directory));

            if (!string.IsNullOrWhiteSpace(hierarchyId))
            {
                hierarchyId = HierarchyBuilder.NewChildHierarchyId(hierarchyId);

                sqlCommand.CommandText = $"INSERT INTO {table} (name, is_directory, path_locator) OUTPUT Inserted.path_locator.ToString() VALUES (@dir, 1, @pathId)";

                sqlCommand.Parameters.Add(new SqlParameter("@pathId", hierarchyId));
            }

            return sqlCommand.ExecuteScalar() as string;
        }

        /// <inheritdoc />
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
        /// <exception cref="T:System.Exception">Table does not exist or is not a FileTable.</exception>
        public string FindPath(string table, string path, bool isDirectory, SqlConnection sqlConnection)
        {
            SqlConnManager.IsConnected(sqlConnection);

            if (!FileTableExists(table, sqlConnection))
            {
                throw new Exception("Table does not exist or is not a FileTable.");
            }

            var tableRoot = GetTableRootPath(table, 0, sqlConnection);

            var tableRootFqdn = GetTableRootPath(table, 2, sqlConnection);

            if (IsTableRoot(path, tableRoot, tableRootFqdn))
            {
                return "/";
            }

            var relativePath = path.GetRelativePath(tableRoot);

            if (path.Length == relativePath.Length)
                relativePath = path.GetRelativePath(tableRootFqdn);

            var directories = relativePath.SplitByDirectory();

            string pathLocator = null;
            foreach (var directory in directories)
            {
                var sqlCommand = new SqlCommand($"SELECT path_locator.ToString() FROM {table} WHERE parent_path_locator.ToString() {(string.IsNullOrEmpty(pathLocator) ? "is null" : "= @pathLocator")} AND name = @dir", sqlConnection);

                if (string.IsNullOrEmpty(pathLocator) == false)
                {
                    sqlCommand.Parameters.Add(new SqlParameter("@pathLocator", pathLocator));
                }

                sqlCommand.Parameters.Add(new SqlParameter("@dir", directory));

                pathLocator = sqlCommand.ExecuteScalar() as string;

                if (string.IsNullOrWhiteSpace(pathLocator))
                    break;
            }

            return pathLocator;
        }

        /// <inheritdoc />
        /// <summary>
        /// Checks if the FileTable exists.
        /// </summary>
        /// <param name="table">The name of the FileTable</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <returns><code>true</code> if the file table exists.</returns>
        public bool FileTableExists(string table, SqlConnection sqlConnection)
        {
            SqlConnManager.IsConnected(sqlConnection);

            var sqlCommand = new SqlCommand("SELECT Count(name) FROM Sys.Tables WHERE name = @table and is_filetable = 1", sqlConnection);

            sqlCommand.Parameters.Add(new SqlParameter("@table", table));

            return (int)sqlCommand.ExecuteScalar() == 1;
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the root path of a FileTable.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="option">The option.</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <returns>The table root path.</returns>
        /// <exception cref="T:System.Exception">Table does not exist or is not a FileTable.</exception>
        public string GetTableRootPath(string table, int option, SqlConnection sqlConnection)
        {
            SqlConnManager.IsConnected(sqlConnection);

            if (!FileTableExists(table, sqlConnection))
            {
                throw new Exception("Table does not exist or is not a FileTable.");
            }

            option = (option < 0 || option > 2) ? 0 : option;// Only allow valid options

            var sqlCommand = new SqlCommand("SELECT FileTableRootPath(@table, @option)", sqlConnection);

            sqlCommand.Parameters.Add(new SqlParameter("@table", table));
            sqlCommand.Parameters.Add(new SqlParameter("@option", option));

            return sqlCommand.ExecuteScalar() as string;
        }

        /// <inheritdoc />
        /// <summary>
        /// Determines whether [is table root] [the specified path].
        /// </summary>
        /// <param name="path">The path.</param>
        /// <param name="tableRoot">The table root.</param>
        /// <param name="tableRootFqdn">The table root FQDN.</param>
        /// <returns>
        ///   <c>true</c> if [is table root] [the specified path]; otherwise, <c>false</c>.
        /// </returns>
        public bool IsTableRoot(string path, string tableRoot, string tableRootFqdn)
        {
            var tableRootRelative = Path.GetFileName(tableRoot);

            return string.IsNullOrEmpty(path)
                || path.Equals(tableRoot, StringComparison.InvariantCultureIgnoreCase)
                || path.Equals(tableRootFqdn, StringComparison.InvariantCultureIgnoreCase)
                || path.TrimStart('\\').Equals(tableRootRelative, StringComparison.InvariantCultureIgnoreCase);
        }

        /// <summary>
        /// Gets or sets the SQL connection manager.
        /// </summary>
        /// <value>
        /// The SQL connection manager.
        /// </value>
        private ISqlConnectionManager SqlConnManager => _sqlConnManager ?? (_sqlConnManager = new SqlConnectionManager());

        /// <summary>
        /// The SQL connection manager.
        /// </summary>
        private ISqlConnectionManager _sqlConnManager;

        /// <summary>
        /// Gets or sets the hierarchy builder.
        /// </summary>
        /// <value>
        /// The hierarchy builder.
        /// </value>
        private IHierarchyBuilder HierarchyBuilder => _hierarchyBuilder ?? (_hierarchyBuilder = new HierarchyBuilder());

        /// <summary>
        /// The hierarchy builder.
        /// </summary>
        private IHierarchyBuilder _hierarchyBuilder;
    }
}
