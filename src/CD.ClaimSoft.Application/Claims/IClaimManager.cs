using System.Collections.Generic;

using CD.ClaimSoft.Database.Model.Claim;

namespace CD.ClaimSoft.Application.Claims
{
    public interface IClaimManager
    {
        /// <summary>
        /// Gets the claims.
        /// </summary>
        /// <param name="agencyId">The agency identifier.</param>
        /// <returns></returns>
        IEnumerable<PatientCareReport> GetClaims(int agencyId);
    }
}
