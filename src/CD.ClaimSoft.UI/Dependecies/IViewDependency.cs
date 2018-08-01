using System.Collections.Generic;
using CD.ClaimSoft.Database.Model.Agency;
using Syncfusion.JavaScript.Models;

namespace CD.ClaimSoft.UI.Dependecies
{
    /// <summary>
    /// Simple dependency to inject into a Razor view.
    /// </summary>
    public interface IViewDependency
    {
        /// <summary>
        /// Gets the time zone DDL.
        /// </summary>
        /// <value>
        /// The time zone DDL.
        /// </value>
        DropDownListProperties TimeZoneDdl { get; }

        /// <summary>
        /// Gets the address type DDL.
        /// </summary>
        /// <value>
        /// The address type DDL.
        /// </value>
        DropDownListProperties AddressTypeDdl { get; }

        /// <summary>
        /// Gets the phone type DDL.
        /// </summary>
        /// <value>
        /// The phone type DDL.
        /// </value>
        DropDownListProperties PhoneTypeDdl { get; }

        /// <summary>
        /// Gets the email type DDL.
        /// </summary>
        /// <value>
        /// The email type DDL.
        /// </value>
        DropDownListProperties EmailTypeDdl { get; }

        /// <summary>
        /// Gets the unit rounding type DDL.
        /// </summary>
        /// <value>
        /// The unit rounding type DDL.
        /// </value>
        DropDownListProperties UnitRoundingTypeDdl { get; }

        /// <summary>
        /// Gets the county DDL.
        /// </summary>
        /// <value>
        /// The county DDL.
        /// </value>
        DropDownListProperties CountyDdl { get; }

        /// <summary>
        /// Gets the state DDL.
        /// </summary>
        /// <value>
        /// The state DDL.
        /// </value>
        DropDownListProperties StateDdl { get; }

        /// <summary>
        /// Gets the country DDL.
        /// </summary>
        /// <value>
        /// The country DDL.
        /// </value>
        DropDownListProperties CountryDdl { get; }

        /// <summary>
        /// Gets the agencies DDL.
        /// </summary>
        /// <value>
        /// The agencies DDL.
        /// </value>
        DropDownListProperties AgenciesDdl { get; }

        /// <summary>
        /// Gets the agencies datasource.
        /// </summary>
        /// <returns>
        /// The agencies datasource.
        /// </returns>
        List<Agency> GetAgenciesDatasource { get; }
    }
}
