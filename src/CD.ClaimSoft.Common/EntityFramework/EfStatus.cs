using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity.Validation;
using System.Linq;

namespace CD.ClaimSoft.Common.EntityFramework
{
    public class EfStatus
    {
        /// <summary>
        /// The errors.
        /// </summary>
        private List<ValidationResult> _errors;

        /// <summary>
        /// Gets or sets the return object.
        /// </summary>
        /// <value>
        /// The return object.
        /// </value>
        public object ReturnObject { get; set; }

        private object _object;

        public void SetReturnObject<T>(T value) where T : class
        {
            _object = value;
        }

        public T GetReturnObject<T>() where T : class
        {
            return _object as T;
        }


        /// <summary>
        /// If there are no errors then it is valid
        /// </summary>
        public bool IsValid { get { return _errors == null; } }

        public IReadOnlyList<ValidationResult> EfErrors
        {
            get { return _errors ?? new List<ValidationResult>(); }
        }

        /// <summary>
        /// This converts the Entity framework errors into Validation errors
        /// </summary>
        public EfStatus SetErrors(IEnumerable<DbEntityValidationResult> errors)
        {
            _errors = errors.SelectMany(x => x.ValidationErrors.Select(y => new ValidationResult(y.ErrorMessage, new[] { y.PropertyName }))).ToList();

            return this;
        }

        public EfStatus SetErrors(IEnumerable<ValidationResult> errors)
        {
            _errors = errors.ToList();

            return this;
        }

    }
}
