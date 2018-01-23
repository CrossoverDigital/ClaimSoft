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
using System.IO;

using CD.ClaimSoft.Database.FileTable.Business;
using CD.ClaimSoft.Database.FileTable.Interfaces;
using CD.ClaimSoft.Database.FileTable.Repository;

namespace CD.ClaimSoft.Database.FileTable.Managers
{
    /// <inheritdoc />
    /// <summary>
    /// Class to manage all the directories within a SQL Server FileTable.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.Database.FileTable.Interfaces.IFileTableManager" />
    public sealed class DirectoryManager : IFileTableManager
    {
        /// <inheritdoc />
        /// <summary>
        /// Adds a file to a FileTable. Allows for specifying a path.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="path">The path of the file. It must be a full path, or a path relative from, but not including, the table's root directory.</param>
        /// <param name="data">The file in byte array format.</param>
        /// <param name="sqlConnection">The Sql Connection string.</param>
        /// <returns>The Stream ID for the new file.</returns>
        public Guid CreateFile(string table, string path, byte[] data, SqlConnection sqlConnection)
        {
            var file = Path.GetFileName(path);

            var directory = Path.GetDirectoryName(path);

            var pathId = DirectoryExists(table, directory, sqlConnection);

            if (string.IsNullOrWhiteSpace(pathId))
            {
                pathId = CreateDirectory(table, directory, sqlConnection);
            }

            return FileTableRepository.CreateFile(table, file, HierarchyBuilder.NewChildHierarchyId(pathId), data, sqlConnection);
        }

        /// <inheritdoc />
        /// <summary>
        /// Creates a directory in a FileTable. If it already exists, it must not error, but instead return the pathId.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="path">The path to create. It should create the full path, even if multiple directory levels need to be create: \a\b\c
        /// </param>
        /// <param name="sqlConnection">The Sql Connection string.</param>
        /// <returns>The directory's HierarchyId as a string.</returns>
        public string CreateDirectory(string table, string path, SqlConnection sqlConnection)
        {
            var tmpPath = path.TrimEnd('\\');

            var dirsToCreate = new Stack<string>();

            string pathId = null;
            while (string.IsNullOrWhiteSpace(pathId) && !string.IsNullOrWhiteSpace(tmpPath))
            {
                pathId = DirectoryExists(table, tmpPath, sqlConnection);
                if (string.IsNullOrWhiteSpace(pathId))
                {
                    dirsToCreate.Push(Path.GetFileName(tmpPath));
                    tmpPath = Path.GetDirectoryName(tmpPath);
                }
            }

            if (dirsToCreate.Count > 0)
            {
                pathId = CreateDirectoryStructure(table, dirsToCreate, pathId, sqlConnection);
            }

            return pathId;
        }

        /// <inheritdoc />
        /// <summary>
        /// Creates the directory structure.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="directoriesToCreate">The directories to create.</param>
        /// <param name="pathId">The path identifier.</param>
        /// <param name="sqlConnection">The Sql Connection string.</param>
        /// <returns>The Path ID for the new directory.</returns>
        public string CreateDirectoryStructure(string table, Stack<string> directoriesToCreate, string pathId, SqlConnection sqlConnection)
        {
            while (directoriesToCreate.Count > 0)
            {
                pathId = FileTableRepository.CreateDirectory(table, directoriesToCreate.Pop(), pathId, sqlConnection);
            }

            return pathId;
        }

        /// <inheritdoc />
        /// <summary>
        /// Checks for the existance of a directory in a FileTable.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="path">The path of the directory. It must be a full path, or a path relative from, but not including, the table's root directory.</param>
        /// <param name="sqlConnection">The Sql Connection string.</param>
        /// <returns>The directory's HierarchyId as a string if it exists, null if it doesn't.</returns>
        public string DirectoryExists(string table, string path, SqlConnection sqlConnection)
        {
            return FileTableRepository.FindPath(table, path, true, sqlConnection);
        }

        /// <inheritdoc />
        /// <summary>
        /// Checks for the existance of a file in a FileTable.
        /// </summary>
        /// <param name="table">The name of the FileTable.</param>
        /// <param name="path">The path of the directory. It must be a full path, or a path relative from, but not including, the table's root directory.</param>
        /// <param name="sqlConnection">The Sql Connection string.</param>
        /// <returns>The files's HierarchyId as a string if it exists, null if it doesn't.</returns>
        public string FileExists(string table, string path, SqlConnection sqlConnection)
        {
            return FileTableRepository.FindPath(table, path, false, sqlConnection);
        }

        /// <summary>
        /// Gets or sets the file table repository.
        /// </summary>
        /// <value>
        /// The file table repository.
        /// </value>
        public IFileTableRepository FileTableRepository
        {
            private get => _directoryRepository ?? (_directoryRepository = new FileTableRepository());
            set => _directoryRepository = value;
        }
        /// <summary>
        /// The directory repository.
        /// </summary>
        private IFileTableRepository _directoryRepository;

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
