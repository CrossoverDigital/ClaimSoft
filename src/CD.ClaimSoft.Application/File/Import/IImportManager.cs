using CD.ClaimSoft.Common.EntityFramework;

namespace CD.ClaimSoft.Application.File.Import
{
    public interface IImportManager
    {
        /// <summary>
        /// Processes the file.
        /// </summary>
        /// <param name="fileName">Name of the file.</param>
        /// <param name="streamId">The stream identifier.</param>
        /// <param name="userId">The user identifier.</param>
        /// <param name="agencyId">The agency identifier.</param>
        /// <returns>The Entity Framework status object. <see cref="EfStatus" /></returns>
        EfStatus ProcessFile(string fileName, string streamId, string userId, int agencyId);
    }
}
