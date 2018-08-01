using System;

namespace CD.ClaimSoft.Database.Model.Common
{
    [Serializable]
    public class AddressType
    {
        public int Id { get; set; } // Id (Primary key)
        public string Name { get; set; } // Name (length: 50)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        public AddressType()
        {
            CreateBy = "CDUNCAN";
            CreateDate = DateTime.Now;
            LastModifyBy = "CDUNCAN";
            LastModifyDate = DateTime.Now;
        }
    }
}
