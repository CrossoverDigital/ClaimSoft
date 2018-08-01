using System;
using CD.ClaimSoft.Database.Model.Common;

namespace CD.ClaimSoft.Database.Model.System
{
    public class ApplicationSetting
    {
        public int Id { get; set; } // Id (Primary key)
        public int SettingTypeId { get; set; } // SettingTypeId
        public string SettingKey { get; set; } // SettingKey (length: 50)
        public string SettingValue { get; set; } // SettingValue (length: 255)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        // Foreign keys

        /// <summary>
        /// Parent SettingType pointed by [ApplicationSettings].([SettingTypeId]) (FK_ApplicationSettings_SettingType)
        /// </summary>
        public virtual SettingType SettingType { get; set; } // FK_ApplicationSettings_SettingType

        public ApplicationSetting()
        {
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
