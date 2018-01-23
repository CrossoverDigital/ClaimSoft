#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;
using System.Data;
using System.Data.SqlClient;

using CD.ClaimSoft.Database.FileTable.Interfaces;

namespace CD.ClaimSoft.Database.FileTable.Managers
{
    /// <inheritdoc />
    /// <summary>
    /// SQL Connection Manager for working with the FileTables.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.Database.FileTable.Interfaces.ISqlConnectionManager" />
    internal class SqlConnectionManager : ISqlConnectionManager
    {
        /// <inheritdoc />
        /// <summary>
        /// Determines whether the specified SQL connection is connected.
        /// </summary>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <returns>
        ///   <c>true</c> if the specified SQL connection is connected; otherwise, <c>false</c>.
        /// </returns>
        public bool IsConnected(SqlConnection sqlConnection)
        {
            if (sqlConnection == null || sqlConnection.State != ConnectionState.Open)
            {
                throw new Exception("The Sql Connection must be open. It was " + sqlConnection?.State);
            }

            return true;
        }
    }
}
