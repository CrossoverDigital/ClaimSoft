#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System;

namespace CD.ClaimSoft.Logging
{
    /// <summary>
    /// Log service definitions.
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public interface ILogService<T>
    {
        /// <summary>
        /// Logs the specified debug message and associated exception.
        /// </summary>
        /// <param name="message">The debug message.</param>
        /// <param name="exception">The exception.</param>
        void Debug(object message, Exception exception);

        /// <summary>
        /// Logs the specified debug message.
        /// </summary>
        /// <param name="message">The debug message.</param>
        void Debug(object message);

        /// <summary>
        /// Logs a formatted debug message.
        /// </summary>
        /// <param name="provider">The provider.</param>
        /// <param name="format">The format.</param>
        /// <param name="args">The arguments.</param>
        void DebugFormat(IFormatProvider provider, string format, params object[] args);

        /// <summary>
        /// Logs the specified info message and associated exception.
        /// </summary>
        /// <param name="message">The info message.</param>
        /// <param name="exception">The exception.</param>
        void Info(object message, Exception exception);

        /// <summary>
        /// Logs the specified info message.
        /// </summary>
        /// <param name="message">The info message.</param>
        void Info(object message);

        /// <summary>
        /// Logs a formatted info message.
        /// </summary>
        /// <param name="provider">The provider.</param>
        /// <param name="format">The format.</param>
        /// <param name="args">The arguments.</param>
        void InfoFormat(IFormatProvider provider, string format, params object[] args);

        /// <summary>
        /// Logs the specified warn message and associated exception.
        /// </summary>
        /// <param name="message">The warn message.</param>
        /// <param name="exception">The exception.</param>
        void Warn(object message, Exception exception);

        /// <summary>
        /// Logs the specified warn message.
        /// </summary>
        /// <param name="message">The warn message.</param>
        void Warn(object message);

        /// <summary>
        /// Logs a formatted warn message.
        /// </summary>
        /// <param name="provider">The provider.</param>
        /// <param name="format">The format.</param>
        /// <param name="args">The arguments.</param>
        void WarnFormat(IFormatProvider provider, string format, params object[] args);

        /// <summary>
        /// Logs the specified error message and associated exception.
        /// </summary>
        /// <param name="message">The error message.</param>
        /// <param name="exception">The exception.</param>
        void Error(object message, Exception exception);

        /// <summary>
        /// Logs the specified error message.
        /// </summary>
        /// <param name="message">The error message.</param>
        void Error(object message);

        /// <summary>
        /// Logs a formatted error message.
        /// </summary>
        /// <param name="provider">The provider.</param>
        /// <param name="format">The format.</param>
        /// <param name="args">The arguments.</param>
        void ErrorFormat(IFormatProvider provider, string format, params object[] args);

        /// <summary>
        /// Determines whether log debugging is enabled.
        /// </summary>
        /// <returns>
        ///   <c>true</c> if log debugging is enabled; otherwise, <c>false</c>.
        /// </returns>
        bool IsDebugEnabled();
    }
}
