#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Data.SqlClient;

using CD.ClaimSoft.Database.FileTable.Interfaces;
using CD.ClaimSoft.Database.FileTable.Managers;
using CD.ClaimSoft.Database.FileTable.Repository;
using CD.ClaimSoft.Logging;

using Microsoft.SqlServer.Server;

namespace CD.ClaimSoft.Database.FileTable
{
    /// <summary>
    /// Extension methods for working with the SQL Server FileTables.
    /// </summary>
    public class FileTableExtensions
    {
        #region Instance Variables

        /// <summary>
        /// The log.
        /// </summary>
        static readonly ILogService<FileTableExtensions> LogService = new LogService<FileTableExtensions>();

        #endregion

        /// <summary>
        /// Checks if the file table exists.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <returns><code>true</code>, if the file table exists.</returns>
        [SqlFunction(DataAccess = DataAccessKind.Read, SystemDataAccess = SystemDataAccessKind.Read)]
        public static bool FileTableExists(string table)
        {
            try
            {
                using (var dbContext = new ClaimSoftContext())
                {
                    if (dbContext.Database.Connection is SqlConnection connection)
                    {
                        connection.Open();

                        return _FileTableExists(table, connection);
                    }
                }

                return true;
            }
            catch (Exception exception)
            {
                LogService.Error(exception);
                throw;
            }
        }

        /// <summary>
        /// Checks if the file table exists.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <param name="fileTableRepository">The file table repository.</param>
        /// <returns><code>true</code>, if the file table exists.</returns>
        private static bool _FileTableExists(string table, SqlConnection sqlConnection, IFileTableRepository fileTableRepository = null)
        {
            return (fileTableRepository ?? new FileTableRepository()).FileTableExists(table, sqlConnection);
        }

        /// <summary>
        /// Checks if the directory exists.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="path">The path.</param>
        /// <returns><code>true</code>, if the directory exists.</returns>
        [SqlFunction(DataAccess = DataAccessKind.Read, SystemDataAccess = SystemDataAccessKind.Read)]
        public static string DirectoryExists(string table, string path)
        {
            try
            {
                using (var dbContext = new ClaimSoftContext())
                {
                    var connection = dbContext.Database.Connection as SqlConnection;
                    connection.Open();

                    return _DirectoryExists(table, path, connection);
                }
            }
            catch (Exception exception)
            {
                LogService.Error(exception);
                throw;
            }
        }

        /// <summary>
        /// Checks if the directory exists.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="path">The path.</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <param name="fileTableManager">The file table manager.</param>
        /// <returns><code>true</code>, if the directory exists.</returns>
        private static string _DirectoryExists(string table, string path, SqlConnection sqlConnection, IFileTableManager fileTableManager = null)
        {
            return (fileTableManager ?? new DirectoryManager()).DirectoryExists(table, path, sqlConnection);
        }

        /// <summary>
        /// Checks if the file exists.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="path">The path.</param>
        /// <returns><code>true</code>, if the file exists.</returns>
        [SqlFunction(DataAccess = DataAccessKind.Read, SystemDataAccess = SystemDataAccessKind.Read)]
        public static string FileExists(string table, string path)
        {
            try
            {
                using (var dbContext = new ClaimSoftContext())
                {
                    var connection = dbContext.Database.Connection as SqlConnection;
                    connection.Open();

                    return _FileExists(table, path, connection);
                }
            }
            catch (Exception exception)
            {
                LogService.Error(exception);
                throw;
            }
        }

        /// <summary>
        /// Checks if the file exists.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="path">The path.</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <param name="fileTableManager">The file table manager.</param>
        /// <returns><code>true</code>, if the file exists.</returns>
        private static string _FileExists(string table, string path, SqlConnection sqlConnection, IFileTableManager fileTableManager = null)
        {
            return (fileTableManager ?? new DirectoryManager()).FileExists(table, path, sqlConnection);
        }

        /// <summary>
        /// Creates the directory.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="path">The path.</param>
        /// <param name="id">The identifier.</param>
        [SqlProcedure()]
        public static void CreateDirectory(string table, string path, out string id)
        {
            try
            {
                using (var dbContext = new ClaimSoftContext())
                {
                    var connection = dbContext.Database.Connection as SqlConnection;
                    connection.Open();

                    id = _CreateDirectory(table, path, connection);
                }
            }
            catch (Exception exception)
            {
                LogService.Error(exception);
                throw;
            }
        }

        /// <summary>
        /// Creates the directory.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="path">The path.</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <param name="fileTableManager">The file table manager.</param>
        /// <returns>The directory's HierarchyId as a string.</returns>
        private static string _CreateDirectory(string table, string path, SqlConnection sqlConnection, IFileTableManager fileTableManager = null)
        {
            return (fileTableManager ?? new DirectoryManager()).CreateDirectory(table, path, sqlConnection);
        }

        /// <summary>
        /// Creates the file.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="path">The path.</param>
        /// <param name="data">The data.</param>
        /// <param name="id">The Stream ID for the new file.</param>
        [SqlProcedure()]
        public static void CreateFile(string table, string path, byte[] data, out Guid id)
        {
            try
            {
                using (var dbContext = new ClaimSoftContext())
                {
                    var connection = dbContext.Database.Connection as SqlConnection;

                    connection.Open();

                    id = _CreateFile(table, path, data, connection);
                }
            }
            catch (Exception exception)
            {
                LogService.Error(exception);
                throw;
            }
        }

        /// <summary>
        /// Creates the file.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="path">The path.</param>
        /// <param name="data">The data.</param>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <param name="fileTableManager">The file table manager.</param>
        /// <returns>The Stream ID for the new file.</returns>
        private static Guid _CreateFile(string table, string path, byte[] data, SqlConnection sqlConnection, IFileTableManager fileTableManager = null)
        {
            return (fileTableManager ?? new DirectoryManager()).CreateFile(table, path, data, sqlConnection);
        }
    }
}
