#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;

namespace CD.ClaimSoft.Common.Helpers
{
    /// <summary>
    /// Extension methods for working with exceptions within the ClaimSoft application.
    /// </summary>
    public static class ExceptionExtensions
    {
        /// <summary>
        /// Gets the full message.
        /// </summary>
        /// <param name="ex">The exception.</param>
        /// <returns>The full error message.</returns>
        public static string GetFullMessage(this Exception ex)
        {
            return ex.InnerException == null
                ? ex.Message
                : ex.Message + " --> " + ex.InnerException.GetFullMessage();
        }
    }
}