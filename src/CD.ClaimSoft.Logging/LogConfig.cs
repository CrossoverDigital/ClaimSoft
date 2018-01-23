#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System.IO;

using log4net.Config;

namespace CD.ClaimSoft.Logging
{
    /// <summary>
    /// Utility class for application logging.
    /// </summary>
    public static class LogConfig
    {
        /// <summary>
        /// Registers the log4net configuration file, and sets log4net watching the file for changes.
        /// </summary>
        /// <param name="filePath">The path/file name to the log4net configuration.</param>
        /// <exception cref="System.IO.FileNotFoundException">Exception thrown when the log configuration file is not found.</exception>
        public static void RegisterConfigFile(string filePath)
        {
            if (File.Exists(filePath) == false)
            {
                throw new FileNotFoundException($"Logging Configuration file '{filePath}' does not exist.");
            }

            XmlConfigurator.ConfigureAndWatch(new FileInfo(filePath));
        }
    }
}