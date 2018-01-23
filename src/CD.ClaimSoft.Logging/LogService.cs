#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;

using log4net;

namespace CD.ClaimSoft.Logging
{
    /// <inheritdoc />
    /// <summary>
    /// Logging service that handles all application logging within ClaimSoft.
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <seealso cref="T:CD.ClaimSoft.Logging.ILogService`1" />
    public class LogService<T> : ILogService<T>
    {
        #region Instance Members

        /// <summary>
        /// The log.
        /// </summary>
        readonly ILog _log;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="LogService{T}" /> class.
        /// </summary>
        public LogService()
        {
            _log = LogManager.GetLogger(typeof(T));
        }

        #endregion

        #region Debug Methods

        /// <inheritdoc />
        /// <summary>
        /// Logs the specified debug message and associated exception.
        /// </summary>
        /// <param name="message">The debug message.</param>
        /// <param name="exception">The exception.</param>
        public void Debug(object message, Exception exception) => _log.Debug(message, exception);

        /// <inheritdoc />
        /// <summary>
        /// Logs the specified debug message.
        /// </summary>
        /// <param name="message">The debug message.</param>
        public void Debug(object message) => _log.Debug(message);

        /// <inheritdoc />
        /// <summary>
        /// Logs a formatted debug message.
        /// </summary>
        /// <param name="provider">The provider.</param>
        /// <param name="format">The format.</param>
        /// <param name="args">The arguments.</param>
        public void DebugFormat(IFormatProvider provider, string format, params object[] args)
        {
            _log.DebugFormat(provider, format, args);
        }

        #endregion

        #region Info Methods

        /// <inheritdoc />
        /// <summary>
        /// Logs the specified info message and associated exception.
        /// </summary>
        /// <param name="message">The info message.</param>
        /// <param name="exception">The exception.</param>
        public void Info(object message, Exception exception) => _log.Info(message, exception);

        /// <inheritdoc />
        /// <summary>
        /// Logs the specified info message.
        /// </summary>
        /// <param name="message">The info message.</param>
        public void Info(object message) => _log.Info(message);

        /// <inheritdoc />
        /// <summary>
        /// Logs a formatted info message.
        /// </summary>
        /// <param name="provider">The provider.</param>
        /// <param name="format">The format.</param>
        /// <param name="args">The arguments.</param>
        public void InfoFormat(IFormatProvider provider, string format, params object[] args)
        {
            _log.InfoFormat(provider, format, args);
        }

        #endregion

        #region Warn Methods

        /// <inheritdoc />
        /// <summary>
        /// Logs the specified warn message and associated exception.
        /// </summary>
        /// <param name="message">The warn message.</param>
        /// <param name="exception">The exception.</param>
        public void Warn(object message, Exception exception) => _log.Warn(message, exception);

        /// <inheritdoc />
        /// <summary>
        /// Logs the specified warn message.
        /// </summary>
        /// <param name="message">The warn message.</param>
        public void Warn(object message) => _log.Warn(message);

        /// <inheritdoc />
        /// <summary>
        /// Logs a formatted warn message.
        /// </summary>
        /// <param name="provider">The provider.</param>
        /// <param name="format">The format.</param>
        /// <param name="args">The arguments.</param>
        public void WarnFormat(IFormatProvider provider, string format, params object[] args)
        {
            _log.WarnFormat(provider, format, args);
        }

        #endregion

        #region Error Methods

        /// <inheritdoc />
        /// <summary>
        /// Logs the specified error message and associated exception.
        /// </summary>
        /// <param name="message">The error message.</param>
        /// <param name="exception">The exception.</param>
        public void Error(object message, Exception exception) => _log.Error(message, exception);

        /// <inheritdoc />
        /// <summary>
        /// Logs the specified error message.
        /// </summary>
        /// <param name="message">The error message.</param>
        public void Error(object message) => _log.Error(message);

        /// <inheritdoc />
        /// <summary>
        /// Logs a formatted error message.
        /// </summary>
        /// <param name="provider">The provider.</param>
        /// <param name="format">The format.</param>
        /// <param name="args">The arguments.</param>
        public void ErrorFormat(IFormatProvider provider, string format, params object[] args)
        {
            _log.ErrorFormat(provider, format, args);
        }

        #endregion

        #region Instance Methods

        /// <inheritdoc />
        /// <summary>
        /// Determines whether log debugging is enabled.
        /// </summary>
        /// <returns>
        /// <c>true</c> if log debugging is enabled; otherwise, <c>false</c>.
        /// </returns>
        public bool IsDebugEnabled() => _log.IsDebugEnabled;

        /// <summary>
        /// Gets the logger.
        /// </summary>
        /// <value>
        /// The logger.
        /// </value>
        public log4net.Core.ILogger Logger => _log.Logger;

        #endregion
    }
}