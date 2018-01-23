#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System.Data.SqlClient;

namespace CD.ClaimSoft.Database.FileTable.Interfaces
{
    /// <summary>
    /// SQL Connection Manager for working with the FileTables.
    /// </summary>
    public interface ISqlConnectionManager
    {
        /// <summary>
        /// Determines whether the specified SQL connection is connected.
        /// </summary>
        /// <param name="sqlConnection">The SQL connection.</param>
        /// <returns>
        ///   <c>true</c> if the specified SQL connection is connected; otherwise, <c>false</c>.
        /// </returns>
        bool IsConnected(SqlConnection sqlConnection);
    }
}
