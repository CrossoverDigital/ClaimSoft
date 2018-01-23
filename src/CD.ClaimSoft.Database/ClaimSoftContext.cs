#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.Entity.Core;
using System.Data.Entity.Infrastructure;
using System.Data.Entity.Validation;
using System.Data.SqlClient;
using System.Linq;

using CD.ClaimSoft.Common.EntityFramework;

namespace CD.ClaimSoft.Database
{
    /// <inheritdoc />
    /// <summary>
    /// Partial database context to extend the save operations.
    /// </summary>
    /// <seealso cref="T:System.Data.Entity.DbContext" />
    /// <seealso cref="T:CD.ClaimSoft.Database.IClaimSoftContext" />
    public partial class ClaimSoftContext
    {
        /// <summary>
        /// Saves all changes made in this context to the underlying database.
        /// </summary>
        /// <returns>
        /// The number of state entries written to the underlying database. This can include
        /// state entries for entities and/or relationships. Relationship state entries are created for
        /// many-to-many relationships and relationships where there is no foreign key property
        /// included in the entity class (often referred to as independent associations).
        /// </returns>
        /// <exception cref="DbEntityValidationException"></exception>
        public override int SaveChanges()
        {
            try
            {
                return base.SaveChanges();
            }
            catch (DbEntityValidationException ex)
            {
                // Retrieve the error messages as a list of strings.
                var errorMessages = ex.EntityValidationErrors
                    .SelectMany(x => x.ValidationErrors)
                    .Select(x => x.ErrorMessage);

                // Join the list to a single string.
                var fullErrorMessage = string.Join("; ", errorMessages);

                // Combine the original exception message with the new one.
                var exceptionMessage = string.Concat(ex.Message, "The validation errors are: ", fullErrorMessage);

                // Throw a new DbEntityValidationException with the improved exception message.
                throw new DbEntityValidationException(exceptionMessage, ex.EntityValidationErrors);
            }
        }

        /// <summary>
        /// Saves the changes with validation.
        /// </summary>
        /// <returns>The EfStatus model containing the result of the save.</returns>
        public EfStatus SaveChangesWithValidation()
        {
            var status = new EfStatus();
            try
            {
                base.SaveChanges();
            }
            catch (DbEntityValidationException ex)
            {
                return status.SetErrors(ex.EntityValidationErrors);
            }

            catch (DbUpdateException ex)
            {
                var decodedErrors = TryDecodeDbUpdateException(ex);
                if (decodedErrors == null)
                    throw;  //it isn't something we understand so rethrow

                return status.SetErrors(decodedErrors);
            }

            return status;
        }

        /// <summary>
        /// The SQL error text dictionary.
        /// </summary>
        static readonly Dictionary<int, string> SqlErrorTextDict =
            new Dictionary<int, string>
            {
                {547, "This operation failed because another data entry uses this entry."},
                {2601, "One of the properties is marked as Unique index and there is already an entry with that value."}
            };

        /// <summary>
        /// This decodes the DbUpdateException. If there are any errors it can
        /// handle then it returns a list of errors. Otherwise it returns null
        /// which means rethrow the error as it has not been handled
        /// </summary>
        /// <param name="ex">The exception.</param>
        /// <returns>
        /// null if cannot handle errors, otherwise a list of errors
        /// </returns>
        IEnumerable<ValidationResult> TryDecodeDbUpdateException(DbUpdateException ex)
        {
            if (!(ex.InnerException is UpdateException) || !(ex.InnerException.InnerException is SqlException))
                return null;

            var sqlException = (SqlException)ex.InnerException.InnerException;

            var result = new List<ValidationResult>();

            for (var i = 0; i < sqlException.Errors.Count; i++)
            {
                var errorNum = sqlException.Errors[i].Number;

                if (SqlErrorTextDict.TryGetValue(errorNum, out var errorText))
                    result.Add(new ValidationResult(errorText));
            }

            return result.Any() ? result : null;
        }
    }
}
