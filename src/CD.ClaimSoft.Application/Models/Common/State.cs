using System;

namespace CD.ClaimSoft.Application.Models.Common
{
    public class State
    {
        public int Id { get; set; } // Id (Primary key)
        public int CountryId { get; set; } // CountryId
        public string Code { get; set; } // Code (length: 2)
        public string Name { get; set; } // Name (length: 128)
        public string CreateBy { get; set; } // CreateBy (length: 50)
        public DateTime CreateDate { get; set; } // CreateDate
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        public State()
        {
            CreateDate = DateTime.Now;
            LastModifyDate = DateTime.Now;
        }
    }
}
