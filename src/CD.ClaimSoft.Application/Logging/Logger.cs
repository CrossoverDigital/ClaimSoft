using log4net;
using log4net.Config;
using System;
using System.IO;

namespace CD.ClaimSoft.Application.Logging
{
    public class Logger
    {
        private readonly ILog _log;

        public static readonly Logger DefaultLogger;

        static Logger()
        {
            DefaultLogger = new Logger(typeof(Logger));
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="Logger"/> class.
        /// </summary>
        /// <param name="t">The t.</param>
        public Logger(Type t)
        {
            _log = LogManager.GetLogger(t);
        }

        /// <summary>
        /// Registers the configuration file.
        /// </summary>
        /// <param name="filePath">The file path.</param>
        /// <exception cref="FileNotFoundException"></exception>
        public static void RegisterConfigFile(string filePath)
        {
            if (File.Exists(filePath) == false)
            {
                throw new FileNotFoundException($"Logging Configuration file '{filePath}' does not exist.");
            }

            XmlConfigurator.ConfigureAndWatch(new FileInfo(filePath));
        }

        /// <summary>
        /// Logs Debug level messages.
        /// </summary>
        /// <param name="message">The message.</param>
        public void Debug(string message)
        {
            _log.Debug(message);
        }

        /// <summary>
        /// Logs Info level messages.
        /// </summary>
        /// <param name="message">The message.</param>
        public void Info(string message)
        {
            _log.Info(message);
        }

        /// <summary>
        /// Logs Warning level messages.
        /// </summary>
        /// <param name="message">The message.</param>
        public void Warn(string message)
        {
            _log.Warn(message);
        }

        /// <summary>
        /// Logs Error level messages.
        /// </summary>
        /// <param name="message">The message.</param>
        public void Error(string message)
        {
            _log.Error(message);
        }

        /// <summary>
        /// Logs Error level exceptions.
        /// </summary>
        /// <param name="e">The e.</param>
        public void Error(Exception e)
        {
            _log.Error(e);
        }
    }
}
