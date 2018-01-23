#region Copyright
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// -=- Copyright (C) ClaimSoft 2017-2018. All Rights Reserved. 
// -=- This code may not be used without the express written 
// -=- permission of the copyright holder, ClaimSoft.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
#endregion

using AutoMapper;

using DB = CD.ClaimSoft.Database;

using Model = CD.ClaimSoft.Application.Models;

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
                cfg.CreateMap<DB.Agency, Model.Agencies.Agency>()
                    .ForMember(dto => dto.AgencyId, conf => conf.MapFrom(ol => ol.Id))
                    .ForMember(dto => dto.AgencyTenantId, conf => conf.MapFrom(ol => ol.AgencyTenantId))
                    .ForMember(dto => dto.Code, conf => conf.MapFrom(ol => ol.Code))
                    .ForMember(dto => dto.Name, conf => conf.MapFrom(ol => ol.Name))
                    .ForMember(dto => dto.IsActive, conf => conf.MapFrom(ol => ol.IsActive))
                    .ForMember(dto => dto.InactiveDate, conf => conf.MapFrom(ol => ol.InactiveDate))
                    .ForMember(dto => dto.ParentAgencyId, conf => conf.MapFrom(ol => ol.ParentAgencyId))
                    .ForMember(dto => dto.WebSite, conf => conf.MapFrom(ol => ol.WebSite))
                    .ForMember(dto => dto.ContactName, conf => conf.MapFrom(ol => ol.ContactName))
                    .ForMember(dto => dto.NpiNumber, conf => conf.MapFrom(ol => ol.NpiNumber))
                    .ForMember(dto => dto.TaxIdNumber, conf => conf.MapFrom(ol => ol.TaxIdNumber))
                    .ForMember(dto => dto.Taxonomy, conf => conf.MapFrom(ol => ol.Taxonomy))
                    .ForMember(dto => dto.DisableLifetimeSignature, conf => conf.MapFrom(ol => ol.DisableLifetimeSignature))
                    .ForMember(dto => dto.LogoFileName, conf => conf.MapFrom(ol => ol.LogoFileName))
                    .ForMember(dto => dto.LogoStreamId, conf => conf.MapFrom(ol => ol.LogoStreamId))
                    .ForMember(dto => dto.UseImageOnStatement, conf => conf.MapFrom(ol => ol.UseImageOnStatement))
                    .ForMember(dto => dto.AgencyAddresses, conf => conf.MapFrom(ol => ol.AgencyAddresses))
                    .ForMember(dto => dto.AgencyNumbers, conf => conf.MapFrom(ol => ol.AgencyNumbers))
                    .ForMember(dto => dto.AgencyPhones, conf => conf.MapFrom(ol => ol.AgencyPhones))
                    .ForMember(dto => dto.AgencyUsers, conf => conf.MapFrom(ol => ol.AgencyUsers))
                    .ForMember(dto => dto.CreateBy, conf => conf.MapFrom(ol => ol.CreateBy))
                    .ForMember(dto => dto.CreateDate, conf => conf.MapFrom(ol => ol.CreateDate))
                    .ForMember(dto => dto.LastModifyBy, conf => conf.MapFrom(ol => ol.LastModifyBy))
                    .ForMember(dto => dto.LastModifyDate, conf => conf.MapFrom(ol => ol.LastModifyDate));

                // DTO => EF
                cfg.CreateMap<Model.Agencies.Agency, DB.Agency>()
                    .ForMember(ef => ef.Id, conf => conf.MapFrom(ol => ol.AgencyId))
                    .ForMember(ef => ef.AgencyTenantId, conf => conf.MapFrom(ol => ol.AgencyTenantId))
                    .ForMember(ef => ef.Code, conf => conf.MapFrom(ol => ol.Code))
                    .ForMember(ef => ef.Name, conf => conf.MapFrom(ol => ol.Name))
                    .ForMember(ef => ef.IsActive, conf => conf.MapFrom(ol => ol.IsActive))
                    .ForMember(ef => ef.InactiveDate, conf => conf.MapFrom(ol => ol.InactiveDate))
                    .ForMember(ef => ef.ParentAgencyId, conf => conf.MapFrom(ol => ol.ParentAgencyId))
                    .ForMember(ef => ef.WebSite, conf => conf.MapFrom(ol => ol.WebSite))
                    .ForMember(ef => ef.ContactName, conf => conf.MapFrom(ol => ol.ContactName))
                    .ForMember(ef => ef.NpiNumber, conf => conf.MapFrom(ol => ol.NpiNumber))
                    .ForMember(ef => ef.TaxIdNumber, conf => conf.MapFrom(ol => ol.TaxIdNumber))
                    .ForMember(ef => ef.Taxonomy, conf => conf.MapFrom(ol => ol.Taxonomy))
                    .ForMember(ef => ef.DisableLifetimeSignature, conf => conf.MapFrom(ol => ol.DisableLifetimeSignature))
                    .ForMember(ef => ef.LogoFileName, conf => conf.MapFrom(ol => ol.LogoFileName))
                    .ForMember(ef => ef.LogoStreamId, conf => conf.MapFrom(ol => ol.LogoStreamId))
                    .ForMember(ef => ef.UseImageOnStatement, conf => conf.MapFrom(ol => ol.UseImageOnStatement))
                    .ForMember(ef => ef.AgencyAddresses, conf => conf.MapFrom(ol => ol.AgencyAddresses))
                    .ForMember(ef => ef.AgencyNumbers, conf => conf.MapFrom(ol => ol.AgencyNumbers))
                    .ForMember(ef => ef.AgencyPhones, conf => conf.MapFrom(ol => ol.AgencyPhones))
                    .ForMember(ef => ef.AgencyUsers, conf => conf.MapFrom(ol => ol.AgencyUsers))
                    .ForMember(ef => ef.CreateBy, conf => conf.MapFrom(ol => ol.CreateBy))
                    .ForMember(ef => ef.CreateDate, conf => conf.MapFrom(ol => ol.CreateDate))
                    .ForMember(ef => ef.LastModifyBy, conf => conf.MapFrom(ol => ol.LastModifyBy))
                    .ForMember(ef => ef.LastModifyDate, conf => conf.MapFrom(ol => ol.LastModifyDate));

                cfg.CreateMap<DB.Country, Model.Common.Country>()
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

                cfg.CreateMap<DB.State, Model.Common.State>()
                    .ForMember(dto => dto.Id, conf => conf.MapFrom(ol => ol.Id))
                    .ForMember(dto => dto.CountryId, conf => conf.MapFrom(ol => ol.CountryId))
                    .ForMember(dto => dto.Code, conf => conf.MapFrom(ol => ol.Code))
                    .ForMember(dto => dto.Name, conf => conf.MapFrom(ol => ol.Name))
                    .ForMember(dto => dto.CreateBy, conf => conf.MapFrom(ol => ol.CreateBy))
                    .ForMember(dto => dto.CreateDate, conf => conf.MapFrom(ol => ol.CreateDate))
                    .ForMember(dto => dto.LastModifyBy, conf => conf.MapFrom(ol => ol.LastModifyBy))
                    .ForMember(dto => dto.LastModifyDate, conf => conf.MapFrom(ol => ol.LastModifyDate));

                cfg.CreateMap<DB.County, Model.Common.County>()
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