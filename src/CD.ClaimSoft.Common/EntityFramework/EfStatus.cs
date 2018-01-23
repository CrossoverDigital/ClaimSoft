#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity.Validation;
using System.Linq;

namespace CD.ClaimSoft.Common.EntityFramework
{
    /// <summary>
    /// Entity Framework Status class that encapsulates the success indicator and any error messages pertaining to failure.
    /// </summary>
    public class EfStatus
    {
        /// <summary>
        /// The errors.
        /// </summary>
        List<ValidationResult> _errors;

        /// <summary>
        /// Gets or sets the return object.
        /// </summary>
        /// <value>
        /// The return object.
        /// </value>
        public object ReturnObject { get; set; }

        /// <summary>
        /// The object.
        /// </summary>
        object _object;

        /// <summary>
        /// Sets the return object.
        /// </summary>
        /// <typeparam name="T">The type of the return object.</typeparam>
        /// <param name="value">The value.</param>
        public void SetReturnObject<T>(T value) where T : class => _object = value;

        /// <summary>
        /// Gets the return object.
        /// </summary>
        /// <typeparam name="T">The type of the return object.</typeparam>
        /// <returns>The return object of the given type.</returns>
        public T GetReturnObject<T>() where T : class => _object as T;

        /// <summary>
        /// If there are no errors then it is valid.
        /// </summary>
        /// <value><c>true</c> if this instance is valid; otherwise, <c>false</c>.</value>
        public bool IsValid => _errors == null;

        /// <summary>
        /// Gets the EF errors.
        /// </summary>
        /// <value>
        /// The EF errors.
        /// </value>
        public IReadOnlyList<ValidationResult> EfErrors => _errors ?? new List<ValidationResult>();

        /// <summary>
        /// This converts the Entity framework errors into Validation errors.
        /// </summary>
        /// <param name="errors">The errors.</param>
        /// <returns>This instance.</returns>
        public EfStatus SetErrors(IEnumerable<DbEntityValidationResult> errors)
        {
            _errors = errors.SelectMany(x => x.ValidationErrors.Select(y => new ValidationResult(y.ErrorMessage, new[] { y.PropertyName }))).ToList();

            return this;
        }

        /// <summary>
        /// Sets the errors.
        /// </summary>
        /// <param name="errors">The errors.</param>
        /// <returns>This instance.</returns>
        public EfStatus SetErrors(IEnumerable<ValidationResult> errors)
        {
            _errors = errors.ToList();

            return this;
        }
    }
}