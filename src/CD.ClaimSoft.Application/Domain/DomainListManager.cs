using System;
using System.Collections.Generic;
using System.Linq;

using AutoMapper.QueryableExtensions;

using CD.ClaimSoft.Database;

using Model = CD.ClaimSoft.Application.Models.Common;

namespace CD.ClaimSoft.Application.Domain
{
    public static class DomainListManager
    {
        public static List<Model.County> GetCountyList()
        {
            using (var claimSoftContext = new ClaimSoftContext())
            {
                return claimSoftContext.Counties.ProjectTo<Model.County>().ToList();
            }
        }

        public static List<Model.State> GetStateList()
        {
            using (var claimSoftContext = new ClaimSoftContext())
            {
                return claimSoftContext.States.ProjectTo<Model.State>().ToList();
            }
        }

        public static List<TimeZoneInfo> GetTimeZones()
        {
            var timeZones = TimeZoneInfo.GetSystemTimeZones().ToList();

            return timeZones.OrderBy(ob => ob.StandardName).ToList();
        }
        public static List<Model.PhoneType> GetPhoneTypeList()
        {
            using (var claimSoftContext = new ClaimSoftContext())
            {
                return claimSoftContext.PhoneTypes.ProjectTo<Model.PhoneType>().ToList();
            }
        }
    }
}
