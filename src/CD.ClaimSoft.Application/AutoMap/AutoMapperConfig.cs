#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using AutoMapper;
using CD.ClaimSoft.Database;
using CD.ClaimSoft.Database.Model.Agency;
using CD.ClaimSoft.Database.Model.Common;

namespace CD.ClaimSoft.Application.AutoMap
{
    /// <summary>
    /// Configuration class for all Automapper mappings.
    /// </summary>
    public static class AutoMapperConfig
    {
        /// <summary>
        /// Configures the mappings for AutoMapper.
        /// </summary>
        public static void Configure()
        {
            Mapper.Initialize(cfg =>
            {
                // EF => DTO
                cfg.CreateMap<AgencyEntity, Agency>()
                    .ForMember(dto => dto.AgencyId, conf => conf.MapFrom(ol => ol.Id))
                    .ForMember(dto => dto.AgencyNumber, conf => conf.MapFrom(ol => ol.AgencyNumber))
                    .ForMember(dto => dto.AgencyName, conf => conf.MapFrom(ol => ol.AgencyName))
                    .ForMember(dto => dto.PrimaryServiceType, conf => conf.MapFrom(ol => ol.PrimaryServiceType))
                    .ForMember(dto => dto.LevelOfService, conf => conf.MapFrom(ol => ol.LevelOfService))
                    .ForMember(dto => dto.OrganizationType, conf => conf.MapFrom(ol => ol.OrganizationType))
                    .ForMember(dto => dto.OrganizationStatus, conf => conf.MapFrom(ol => ol.OrganizationStatus))
                    .ForMember(dto => dto.TimeZone, conf => conf.MapFrom(ol => ol.TimeZone))
                    .ForMember(dto => dto.DaylightSavings, conf => conf.MapFrom(ol => ol.DaylightSavings))
                    .ForMember(dto => dto.NationalProviderId, conf => conf.MapFrom(ol => ol.NationalProviderId))
                    .ForMember(dto => dto.IsActive, conf => conf.MapFrom(ol => ol.IsActive))
                    .ForMember(dto => dto.InactiveDate, conf => conf.MapFrom(ol => ol.InactiveDate))
                    .ForMember(dto => dto.ParentAgencyId, conf => conf.MapFrom(ol => ol.ParentAgencyId))
                    .ForMember(dto => dto.WebSite, conf => conf.MapFrom(ol => ol.WebSite))
                    .ForMember(dto => dto.ContactName, conf => conf.MapFrom(ol => ol.ContactName))
                    .ForMember(dto => dto.TaxIdNumber, conf => conf.MapFrom(ol => ol.TaxIdNumber))
                    .ForMember(dto => dto.Taxonomy, conf => conf.MapFrom(ol => ol.Taxonomy))
                    .ForMember(dto => dto.DisableLifetimeSignature, conf => conf.MapFrom(ol => ol.DisableLifetimeSignature))
                    .ForMember(dto => dto.LogoFileName, conf => conf.MapFrom(ol => ol.LogoFileName))
                    .ForMember(dto => dto.LogoStreamId, conf => conf.MapFrom(ol => ol.LogoStreamId))
                    .ForMember(dto => dto.UseImageOnStatement, conf => conf.MapFrom(ol => ol.UseImageOnStatement))
                    .ForMember(dto => dto.AgencyAddresses, conf => conf.MapFrom(ol => ol.AgencyAddresses))
                    .ForMember(dto => dto.AgencyUsers, conf => conf.MapFrom(ol => ol.AgencyUsers))
                    .ForMember(dto => dto.CreateBy, conf => conf.MapFrom(ol => ol.CreateBy))
                    .ForMember(dto => dto.CreateDate, conf => conf.MapFrom(ol => ol.CreateDate))
                    .ForMember(dto => dto.LastModifyBy, conf => conf.MapFrom(ol => ol.LastModifyBy))
                    .ForMember(dto => dto.LastModifyDate, conf => conf.MapFrom(ol => ol.LastModifyDate));

                // DTO => EF
                cfg.CreateMap<Agency, AgencyEntity>()
                    .ForMember(ef => ef.Id, conf => conf.MapFrom(ol => ol.AgencyId))
                    .ForMember(ef => ef.AgencyNumber, conf => conf.MapFrom(ol => ol.AgencyNumber))
                    .ForMember(ef => ef.AgencyName, conf => conf.MapFrom(ol => ol.AgencyName))
                    .ForMember(ef => ef.PrimaryServiceType, conf => conf.MapFrom(ol => ol.PrimaryServiceType))
                    .ForMember(ef => ef.LevelOfService, conf => conf.MapFrom(ol => ol.LevelOfService))
                    .ForMember(ef => ef.OrganizationType, conf => conf.MapFrom(ol => ol.OrganizationType))
                    .ForMember(ef => ef.OrganizationStatus, conf => conf.MapFrom(ol => ol.OrganizationStatus))
                    .ForMember(ef => ef.TimeZone, conf => conf.MapFrom(ol => ol.TimeZone))
                    .ForMember(ef => ef.DaylightSavings, conf => conf.MapFrom(ol => ol.DaylightSavings))
                    .ForMember(ef => ef.NationalProviderId, conf => conf.MapFrom(ol => ol.NationalProviderId))
                    .ForMember(ef => ef.IsActive, conf => conf.MapFrom(ol => ol.IsActive))
                    .ForMember(ef => ef.InactiveDate, conf => conf.MapFrom(ol => ol.InactiveDate))
                    .ForMember(ef => ef.ParentAgencyId, conf => conf.MapFrom(ol => ol.ParentAgencyId))
                    .ForMember(ef => ef.WebSite, conf => conf.MapFrom(ol => ol.WebSite))
                    .ForMember(ef => ef.ContactName, conf => conf.MapFrom(ol => ol.ContactName))
                    .ForMember(ef => ef.TaxIdNumber, conf => conf.MapFrom(ol => ol.TaxIdNumber))
                    .ForMember(ef => ef.Taxonomy, conf => conf.MapFrom(ol => ol.Taxonomy))
                    .ForMember(ef => ef.DisableLifetimeSignature, conf => conf.MapFrom(ol => ol.DisableLifetimeSignature))
                    .ForMember(ef => ef.LogoFileName, conf => conf.MapFrom(ol => ol.LogoFileName))
                    .ForMember(ef => ef.LogoStreamId, conf => conf.MapFrom(ol => ol.LogoStreamId))
                    .ForMember(ef => ef.UseImageOnStatement, conf => conf.MapFrom(ol => ol.UseImageOnStatement))
                    .ForMember(ef => ef.AgencyAddresses, conf => conf.MapFrom(ol => ol.AgencyAddresses))
                    .ForMember(ef => ef.AgencyUsers, conf => conf.MapFrom(ol => ol.AgencyUsers))
                    .ForMember(ef => ef.CreateBy, conf => conf.MapFrom(ol => ol.CreateBy))
                    .ForMember(ef => ef.CreateDate, conf => conf.MapFrom(ol => ol.CreateDate))
                    .ForMember(ef => ef.LastModifyBy, conf => conf.MapFrom(ol => ol.LastModifyBy))
                    .ForMember(ef => ef.LastModifyDate, conf => conf.MapFrom(ol => ol.LastModifyDate));

                // EF => DTO
                cfg.CreateMap<AgencyFileEntity, AgencyFile>()
                    .ForMember(dto => dto.Id, conf => conf.MapFrom(ol => ol.Id))
                    .ForMember(dto => dto.AgencyId, conf => conf.MapFrom(ol => ol.AgencyId))
                    .ForMember(dto => dto.StreamId, conf => conf.MapFrom(ol => ol.StreamId))
                    .ForMember(dto => dto.Name, conf => conf.MapFrom(ol => ol.Name))
                    .ForMember(dto => dto.FileTypeId, conf => conf.MapFrom(ol => ol.FileTypeId))
                    .ForMember(dto => dto.FileType, conf => conf.MapFrom(ol => ol.FileType.Name))
                    .ForMember(dto => dto.ProcessedDate, conf => conf.MapFrom(ol => ol.ProcessedDate))
                    .ForMember(dto => dto.CreateBy, conf => conf.MapFrom(ol => ol.CreateBy))
                    .ForMember(dto => dto.CreateDate, conf => conf.MapFrom(ol => ol.CreateDate))
                    .ForMember(dto => dto.LastModifyBy, conf => conf.MapFrom(ol => ol.LastModifyBy))
                    .ForMember(dto => dto.LastModifyDate, conf => conf.MapFrom(ol => ol.LastModifyDate));


                // DTO => EF
                cfg.CreateMap<AgencyFile, AgencyFileEntity>()
                    .ForMember(ef => ef.Id, conf => conf.MapFrom(ol => ol.Id))
                    .ForMember(ef => ef.AgencyId, conf => conf.MapFrom(ol => ol.AgencyId))
                    .ForMember(ef => ef.StreamId, conf => conf.MapFrom(ol => ol.StreamId))
                    .ForMember(ef => ef.Name, conf => conf.MapFrom(ol => ol.Name))
                    .ForMember(ef => ef.FileTypeId, conf => conf.MapFrom(ol => ol.FileTypeId))
                    .ForMember(ef => ef.ProcessedDate, conf => conf.MapFrom(ol => ol.ProcessedDate))
                    .ForMember(ef => ef.CreateBy, conf => conf.MapFrom(ol => ol.CreateBy))
                    .ForMember(ef => ef.CreateDate, conf => conf.MapFrom(ol => ol.CreateDate))
                    .ForMember(ef => ef.LastModifyBy, conf => conf.MapFrom(ol => ol.LastModifyBy))
                    .ForMember(ef => ef.LastModifyDate, conf => conf.MapFrom(ol => ol.LastModifyDate));

                cfg.CreateMap<CountryEntity, Country>()
                    .ForMember(dto => dto.Id, conf => conf.MapFrom(ol => ol.Id))
                    .ForMember(dto => dto.Iso, conf => conf.MapFrom(ol => ol.Iso))
                    .ForMember(dto => dto.Name, conf => conf.MapFrom(ol => ol.Name))
                    .ForMember(dto => dto.NiceName, conf => conf.MapFrom(ol => ol.NiceName))
                    .ForMember(dto => dto.Iso3, conf => conf.MapFrom(ol => ol.Iso3))
                    .ForMember(dto => dto.NumCode, conf => conf.MapFrom(ol => ol.NumCode))
                    .ForMember(dto => dto.PhoneCode, conf => conf.MapFrom(ol => ol.PhoneCode))
                    .ForMember(dto => dto.CreateBy, conf => conf.MapFrom(ol => ol.CreateBy))
                    .ForMember(dto => dto.CreateDate, conf => conf.MapFrom(ol => ol.CreateDate))
                    .ForMember(dto => dto.LastModifyBy, conf => conf.MapFrom(ol => ol.LastModifyBy))
                    .ForMember(dto => dto.LastModifyDate, conf => conf.MapFrom(ol => ol.LastModifyDate));

                cfg.CreateMap<StateEntity, State>()
                    .ForMember(dto => dto.Id, conf => conf.MapFrom(ol => ol.Id))
                    .ForMember(dto => dto.CountryId, conf => conf.MapFrom(ol => ol.CountryId))
                    .ForMember(dto => dto.Code, conf => conf.MapFrom(ol => ol.Code))
                    .ForMember(dto => dto.Name, conf => conf.MapFrom(ol => ol.Name))
                    .ForMember(dto => dto.CreateBy, conf => conf.MapFrom(ol => ol.CreateBy))
                    .ForMember(dto => dto.CreateDate, conf => conf.MapFrom(ol => ol.CreateDate))
                    .ForMember(dto => dto.LastModifyBy, conf => conf.MapFrom(ol => ol.LastModifyBy))
                    .ForMember(dto => dto.LastModifyDate, conf => conf.MapFrom(ol => ol.LastModifyDate));

                cfg.CreateMap<CountyEntity, County>()
                    .ForMember(dto => dto.Id, conf => conf.MapFrom(ol => ol.Id))
                    .ForMember(dto => dto.StateId, conf => conf.MapFrom(ol => ol.StateId))
                    .ForMember(dto => dto.Code, conf => conf.MapFrom(ol => ol.Code))
                    .ForMember(dto => dto.Name, conf => conf.MapFrom(ol => ol.Name))
                    .ForMember(dto => dto.Gnis, conf => conf.MapFrom(ol => ol.Gnis))
                    .ForMember(dto => dto.FipsStcty, conf => conf.MapFrom(ol => ol.FipsStcty))
                    .ForMember(dto => dto.Fips, conf => conf.MapFrom(ol => ol.Fips))
                    .ForMember(dto => dto.CreateBy, conf => conf.MapFrom(ol => ol.CreateBy))
                    .ForMember(dto => dto.CreateDate, conf => conf.MapFrom(ol => ol.CreateDate))
                    .ForMember(dto => dto.LastModifyBy, conf => conf.MapFrom(ol => ol.LastModifyBy))
                    .ForMember(dto => dto.LastModifyDate, conf => conf.MapFrom(ol => ol.LastModifyDate));
            });
        }
    }
}