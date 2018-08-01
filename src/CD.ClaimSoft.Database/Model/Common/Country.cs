using System;

namespace CD.ClaimSoft.Database.Model.Common
{
    [Serializable]
    public class Country
    {
        public int Id { get; set; } // Id (Primary key)
        public string Iso { get; set; } // Iso (length: 2)
        public string Name { get; set; } // Name (length: 80)
        public string NiceName { get; set; } // NiceName (length: 80)
        public string Iso3 { get; set; } // Iso3 (length: 3)
        public short? NumCode { get; set; } // NumCode
        public int PhoneCode { get; set; } // PhoneCode
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        public Country()
        {
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
