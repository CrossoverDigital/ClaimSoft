using System;

namespace CD.ClaimSoft.Database.Model.Agency
{
    /// <summary>
    /// 
    /// </summary>
    [Serializable]
    public class AgencyFile
    {
        /// <summary>
        /// Gets or sets the identifier.
        /// </summary>
        /// <value>
        /// The identifier.
        /// </value>
        public int Id { get; set; } // Id (Primary key)

        /// <summary>
        /// Gets or sets the agency identifier.
        /// </summary>
        /// <value>
        /// The agency identifier.
        /// </value>
        public int AgencyId { get; set; }

        /// <summary>
        /// Gets or sets the stream identifier.
        /// </summary>
        /// <value>
        /// The stream identifier.
        /// </value>
        public string StreamId { get; set; } // stream_id (length: 255)

        /// <summary>
        /// Gets or sets the name.
        /// </summary>
        /// <value>
        /// The name.
        /// </value>
        public string Name { get; set; } // Name (length: 50)

        /// <summary>
        /// Gets or sets the file type identifier.
        /// </summary>
        /// <value>
        /// The file type identifier.
        /// </value>
        public int FileTypeId { get; set; }

        /// <summary>
        /// Gets or sets the type of the file.
        /// </summary>
        /// <value>
        /// The type of the file.
        /// </value>
        public string FileType { get; set; }

        /// <summary>
        /// Gets or sets the processed date.
        /// </summary>
        /// <value>
        /// The processed date.
        /// </value>
        public DateTime? ProcessedDate { get; set; }

        /// <summary>
        /// Gets or sets the local processed date.
        /// </summary>
        /// <value>
        /// The local processed date.
        /// </value>
        public DateTime? LocalProcessedDate => ProcessedDate?.ToLocalTime() ?? ProcessedDate;

        /// <summary>
        /// Gets or sets the create by.
        /// </summary>
        /// <value>
        /// The create by.
        /// </value>
        public string CreateBy { get; set; } // CreateBy (length: 50)

        /// <summary>
        /// Gets or sets the create date.
        /// </summary>
        /// <value>
        /// The create date.
        /// </value>
        public DateTime CreateDate { get; set; } // CreateDate

        /// <summary>
        /// Gets the local create date.
        /// </summary>
        /// <value>
        /// The local create date.
        /// </value>
        public DateTime LocalCreateDate => CreateDate.ToLocalTime();

        /// <summary>
        /// Gets or sets the last modify by.
        /// </summary>
        /// <value>
        /// The last modify by.
        /// </value>
        public string LastModifyBy { get; set; } // LastModifyBy (length: 50)

        /// <summary>
        /// Gets or sets the last modify date.
        /// </summary>
        /// <value>
        /// The last modify date.
        /// </value>
        public DateTime LastModifyDate { get; set; } // LastModifyDate

        /// <summary>
        /// Parent Agency pointed by [AgencyFiles].([AgencyId]) (FK_AgencyFiles_Agency)
        /// </summary>
        /// <value>
        /// The agency.
        /// </value>
        public Agency Agency { get; set; }
    }
}
