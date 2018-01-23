using System;

namespace CD.ClaimSoft.Application.Models.Common
{
    public class County
    {
        public int Id { get; set; } // Id (Primary key)
        public int StateId { get; set; } // StateId
        public string Name { get; set; } // Name (length: 50)
        public string Code { get; set; } // Code (length: 10)
        public string Gnis { get; set; } // GNIS (length: 10)
        public string FipsStcty { get; set; } // FIPS_STCTY (length: 10)
        public string Fips { get; set; } // FIPS (length: 10)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        public County()
        {
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
