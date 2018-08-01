using System;

namespace CD.ClaimSoft.Database.Model.Common
{
    [Serializable]
    public class FileType
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public string CreateBy { get; set; }

        public DateTime CreateDate { get; set; }

        public string LastModifyBy { get; set; }

        public DateTime LastModifyDate { get; set; }
    }
}
