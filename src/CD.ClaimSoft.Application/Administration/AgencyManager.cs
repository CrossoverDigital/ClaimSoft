using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;

using AutoMapper;
using AutoMapper.QueryableExtensions;

using CD.ClaimSoft.Application.Logging;

using CD.ClaimSoft.Common.EntityFramework;

using CD.ClaimSoft.Database;

using Model = CD.ClaimSoft.Application.Models;

namespace CD.ClaimSoft.Application.Administration
{
    public class AgencyManager
    {
        #region Instance Variables

        /// <summary>
        /// The log.
        /// </summary>
        private static readonly Logger Log = new Logger(typeof(AgencyManager));

        #endregion

        #region Agency Methods

        /// <summary>
        /// Gets the agencies.
        /// </summary>
        /// <returns>The colection of agencies in the application.</returns>
        public List<Model.Agencies.Agency> GetAgencies()
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    return claimSoftContext.Agencies.ProjectTo<Model.Agencies.Agency>().ToList();
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Creates a new agency.
        /// </summary>
        /// <param name="agency">The new agency.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus CreateAgency(Model.Agencies.Agency agency)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyTenantId = Guid.NewGuid().ToString().ToUpperInvariant();

                    agency.AgencyTenantId = agencyTenantId;

                    var entity = Mapper.Map<Agency>(agency);

                    claimSoftContext.Agencies.Attach(entity);

                    claimSoftContext.Entry<Agency>(entity).State = EntityState.Added;

                    var returnValue = claimSoftContext.SaveChangesWithValidation();

                    if (returnValue.IsValid)
                    {
                        var newAgency = claimSoftContext.Agencies.Include(aa => aa.AgencyAddresses).First(a => a.AgencyTenantId == agencyTenantId);

                        returnValue.SetReturnObject(Mapper.Map<Agency, Model.Agencies.Agency>(newAgency));
                    }

                    return returnValue;
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Updates the agency.
        /// </summary>
        /// <param name="agency">The agency to update.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus UpdateAgency(Model.Agencies.Agency agency)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var entity = Mapper.Map<Agency>(agency);

                    claimSoftContext.Agencies.Attach(entity);

                    claimSoftContext.Entry<Agency>(entity).State = EntityState.Modified;

                    return claimSoftContext.SaveChangesWithValidation();
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        #endregion

        #region Agency Address Methods

        /// <summary>
        /// Gets the agency address.
        /// </summary>
        /// <param name="agencyAddressId">The agency address identifier.</param>
        /// <returns>The specified agency address.</returns>
        public Model.Agencies.AgencyAddress GetAgencyAddress(int agencyAddressId)
        {
            try
            {
                if (agencyAddressId == 0)
                {
                    return new Model.Agencies.AgencyAddress();
                }

                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyAddress = claimSoftContext.AgencyAddresses.First(a => a.Id == agencyAddressId);

                    return Mapper.Map<AgencyAddress, Model.Agencies.AgencyAddress>(agencyAddress);
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Creates the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address to create.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus CreateAgencyAddress(Model.Agencies.AgencyAddress agencyAddress)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyAddressEntity = Mapper.Map<AgencyAddress>(agencyAddress);

                    claimSoftContext.AgencyAddresses.Attach(agencyAddressEntity);

                    claimSoftContext.Entry(agencyAddressEntity).State = EntityState.Added;

                    var returnValue = claimSoftContext.SaveChangesWithValidation();

                    if (returnValue.IsValid)
                    {
                        var newAgencyAddress = claimSoftContext.AgencyAddresses.First(a => a.AgencyId == agencyAddress.AgencyId
                                        && a.Address1 == agencyAddress.Address1
                                        && a.City == agencyAddress.City
                                        && a.CountyId == agencyAddress.CountyId
                                        && a.StateId == agencyAddress.StateId
                                        && a.ZipCode == agencyAddress.ZipCode);

                        returnValue.SetReturnObject(Mapper.Map<AgencyAddress, Model.Agencies.AgencyAddress>(newAgencyAddress));
                    }

                    return returnValue;
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Updates the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus UpdateAgencyAddress(Model.Agencies.AgencyAddress agencyAddress)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyAddressEntity = Mapper.Map<AgencyAddress>(agencyAddress);

                    claimSoftContext.AgencyAddresses.Attach(agencyAddressEntity);

                    claimSoftContext.Entry(agencyAddressEntity).State = EntityState.Modified;

                    return claimSoftContext.SaveChangesWithValidation();
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Deletes the agency address.
        /// </summary>
        /// <param name="agencyAddress">The agency address to remove.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus DeleteAgencyAddress(Model.Agencies.AgencyAddress agencyAddress)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyAddressEntity = Mapper.Map<AgencyAddress>(agencyAddress);

                    claimSoftContext.AgencyAddresses.Attach(agencyAddressEntity);

                    claimSoftContext.Entry(agencyAddressEntity).State = EntityState.Deleted;

                    return claimSoftContext.SaveChangesWithValidation();
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        #endregion

        #region Agency Number Methods

        /// <summary>
        /// Gets the agency number.
        /// </summary>
        /// <param name="numberId">The number identifier.</param>
        /// <returns>The agency number for the specified numberId.</returns>
        public Model.Agencies.AgencyNumber GetAgencyNumber(int numberId)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyNumber = claimSoftContext.AgencyNumbers.FirstOrDefault(an => an.Id == numberId);

                    return Mapper.Map<AgencyNumber, Model.Agencies.AgencyNumber>(agencyNumber);
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Creates a new agency number.
        /// </summary>
        /// <param name="agencyNumber">The agency number.</param>
        /// <returns>
        /// The Entity Framework status object.
        /// </returns>
        public EfStatus CreateAgencyNumber(Model.Agencies.AgencyNumber agencyNumber)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var entity = Mapper.Map<AgencyNumber>(agencyNumber);

                    claimSoftContext.AgencyNumbers.Attach(entity);

                    claimSoftContext.Entry(entity).State = EntityState.Added;

                    var returnValue = claimSoftContext.SaveChangesWithValidation();

                    if (returnValue.IsValid)
                    {
                        var newAgencyNumber = claimSoftContext.AgencyNumbers.FirstOrDefault(an => an.AgencyId == agencyNumber.AgencyId && an.Number == agencyNumber.Number);

                        returnValue.SetReturnObject(Mapper.Map<AgencyNumber, Model.Agencies.AgencyNumber>(newAgencyNumber));
                    }

                    return returnValue;
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Updates the agency number.
        /// </summary>
        /// <param name="agencyNumber">The agency number.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus UpdateAgencyNumber(Model.Agencies.AgencyNumber agencyNumber)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyNumberEntity = Mapper.Map<AgencyNumber>(agencyNumber);

                    claimSoftContext.AgencyNumbers.Attach(agencyNumberEntity);

                    claimSoftContext.Entry(agencyNumberEntity).State = EntityState.Modified;

                    return claimSoftContext.SaveChangesWithValidation();
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Deletes the agency number.
        /// </summary>
        /// <param name="agencyNumber">The agency number.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus DeleteAgencyNumber(Model.Agencies.AgencyNumber agencyNumber)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyNumberEntity = Mapper.Map<AgencyNumber>(agencyNumber);

                    claimSoftContext.AgencyNumbers.Attach(agencyNumberEntity);

                    claimSoftContext.Entry(agencyNumberEntity).State = EntityState.Deleted;

                    return claimSoftContext.SaveChangesWithValidation();
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        #endregion

        #region Agency Phone Methods

        /// <summary>
        /// Gets the agency phone.
        /// </summary>
        /// <param name="phoneId">The phone identifier.</param>
        /// <returns>The agency phone for the specified identifier.</returns>
        public Model.Agencies.AgencyPhone GetAgencyPhone(int phoneId)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyNumber = claimSoftContext.AgencyPhones.FirstOrDefault(an => an.Id == phoneId);

                    return Mapper.Map<AgencyPhone, Model.Agencies.AgencyPhone>(agencyNumber);
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Creates a new agency phone.
        /// </summary>
        /// <param name="agencyPhone">The agency phone.</param>
        /// <returns>
        /// The Entity Framework status object.
        /// </returns>
        public EfStatus CreateAgencyPhone(Model.Agencies.AgencyPhone agencyPhone)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var entity = Mapper.Map<AgencyPhone>(agencyPhone);

                    claimSoftContext.AgencyPhones.Attach(entity);

                    claimSoftContext.Entry(entity).State = EntityState.Added;

                    var returnValue = claimSoftContext.SaveChangesWithValidation();

                    if (returnValue.IsValid)
                    {
                        var newAgencyPhone = claimSoftContext.AgencyPhones.FirstOrDefault(an => an.AgencyId == agencyPhone.AgencyId && an.AreaCode == agencyPhone.AreaCode
                                                                                                 && an.Prefix == agencyPhone.Prefix && an.LineNumber == agencyPhone.LineNumber);

                        returnValue.SetReturnObject(Mapper.Map<AgencyPhone, Model.Agencies.AgencyPhone>(newAgencyPhone));
                    }

                    return returnValue;
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Updates the agency phone.
        /// </summary>
        /// <param name="agencyPhone">The agency phone.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus UpdateAgencyPhone(Model.Agencies.AgencyPhone agencyPhone)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyPhoneEntity = Mapper.Map<AgencyPhone>(agencyPhone);

                    claimSoftContext.AgencyPhones.Attach(agencyPhoneEntity);

                    claimSoftContext.Entry(agencyPhoneEntity).State = EntityState.Modified;

                    return claimSoftContext.SaveChangesWithValidation();
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        /// <summary>
        /// Deletes the agency phone.
        /// </summary>
        /// <param name="agencyPhone">The agency phone.</param>
        /// <returns>The Entity Framework status object.</returns>
        public EfStatus DeleteAgencyPhone(Model.Agencies.AgencyPhone agencyPhone)
        {
            try
            {
                using (var claimSoftContext = new ClaimSoftContext())
                {
                    var agencyPhoneEntity = Mapper.Map<AgencyPhone>(agencyPhone);

                    claimSoftContext.AgencyPhones.Attach(agencyPhoneEntity);

                    claimSoftContext.Entry(agencyPhoneEntity).State = EntityState.Deleted;

                    return claimSoftContext.SaveChangesWithValidation();
                }
            }
            catch (Exception ex)
            {
                Log.Error(ex);

                throw;
            }
        }

        #endregion
    }
}
