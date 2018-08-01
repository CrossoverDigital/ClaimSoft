
using System.Collections.Generic;
using CD.ClaimSoft.Application.Domain;
using CD.ClaimSoft.Database.Model.Agency;
using Syncfusion.JavaScript.Models;

namespace CD.ClaimSoft.UI.Dependecies
{
    /// <inheritdoc />
    /// <summary>
    /// Implementation of a simple dependency to inject into a view.
    /// </summary>
    /// <seealso cref="T:CD.ClaimSoft.UI.Dependecies.IViewDependency" />
    public class ViewDependency : IViewDependency
    {
        #region Instance Variables

        /// <summary>
        /// The domain list manager.
        /// </summary>
        readonly IDomainListManager _domainListManager;

        #endregion

        #region Constructor

        /// <summary>
        /// Initializes a new instance of the <see cref="ViewDependency"/> class.
        /// </summary>
        public ViewDependency(IDomainListManager domainListManager)
        {
            _domainListManager = domainListManager;
        }

        #endregion

        #region DropDownList Datasources

        /// <inheritdoc />
        /// <summary>
        /// Gets the time zone DDL.
        /// </summary>
        /// <value>
        /// The time zone DDL.
        /// </value>
        public DropDownListProperties TimeZoneDdl
        {
            get
            {
                var timeZoneDdlProperties = new DropDownListProperties();
                var timeZoneDdlFields = new DropDownListFields();

                timeZoneDdlProperties.DataSource = _domainListManager.GetTimeZonesList();

                timeZoneDdlFields.Text = "StandardName";
                timeZoneDdlFields.Value = "Id";

                timeZoneDdlProperties.DropDownListFields = timeZoneDdlFields;

                return timeZoneDdlProperties;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the address type DDL.
        /// </summary>
        /// <value>
        /// The address type DDL.
        /// </value>
        public DropDownListProperties AddressTypeDdl
        {
            get
            {
                var addressTypeDdlProperties = new DropDownListProperties();
                var addressTypeDdlFields = new DropDownListFields();

                addressTypeDdlProperties.DataSource = _domainListManager.GetAddressTypeList();

                addressTypeDdlFields.Text = "Name";
                addressTypeDdlFields.Value = "Id";

                addressTypeDdlProperties.DropDownListFields = addressTypeDdlFields;

                return addressTypeDdlProperties;
            }
        }


        /// <inheritdoc />
        /// <summary>
        /// Gets the phone type DDL.
        /// </summary>
        /// <value>
        /// The phone type DDL.
        /// </value>
        public DropDownListProperties PhoneTypeDdl
        {
            get
            {
                var phoneTypeDdlProperties = new DropDownListProperties();
                var phoneTypeDdlFields = new DropDownListFields();

                phoneTypeDdlProperties.DataSource = _domainListManager.GetPhoneTypeList();

                phoneTypeDdlFields.Text = "Name";
                phoneTypeDdlFields.Value = "Id";

                phoneTypeDdlProperties.DropDownListFields = phoneTypeDdlFields;

                return phoneTypeDdlProperties;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the email type DDL.
        /// </summary>
        /// <value>
        /// The email type DDL.
        /// </value>
        public DropDownListProperties EmailTypeDdl
        {
            get
            {
                var emailTypeDdlProperties = new DropDownListProperties();
                var emailTypeDdlFields = new DropDownListFields();

                emailTypeDdlProperties.DataSource = _domainListManager.GetEmailTypeList();

                emailTypeDdlFields.Text = "Name";
                emailTypeDdlFields.Value = "Id";

                emailTypeDdlProperties.DropDownListFields = emailTypeDdlFields;

                return emailTypeDdlProperties;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the unit rounding type DDL.
        /// </summary>
        /// <value>
        /// The unit rounding type DDL.
        /// </value>
        public DropDownListProperties UnitRoundingTypeDdl
        {
            get
            {
                var unitRoundingTypeDdlProperties = new DropDownListProperties();
                var unitRoundingTypeDdlFields = new DropDownListFields();

                unitRoundingTypeDdlProperties.DataSource = _domainListManager.GetUnitRoundingTypeList();

                unitRoundingTypeDdlFields.Text = "Name";
                unitRoundingTypeDdlFields.Value = "Id";

                unitRoundingTypeDdlProperties.DropDownListFields = unitRoundingTypeDdlFields;

                return unitRoundingTypeDdlProperties;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the county DDL.
        /// </summary>
        /// <value>
        /// The county DDL.
        /// </value>
        public DropDownListProperties CountyDdl
        {
            get
            {
                var countyDdlProperties = new DropDownListProperties();
                var countyDdlFields = new DropDownListFields();

                countyDdlProperties.DataSource = _domainListManager.GetCountyList();

                countyDdlFields.Text = "Name";
                countyDdlFields.Value = "Id";

                countyDdlProperties.DropDownListFields = countyDdlFields;

                return countyDdlProperties;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the state DDL.
        /// </summary>
        /// <value>
        /// The state DDL.
        /// </value>
        public DropDownListProperties StateDdl
        {
            get
            {
                var stateDdlProperties = new DropDownListProperties();
                var stateDdlFields = new DropDownListFields();

                stateDdlProperties.DataSource = _domainListManager.GetStateList();

                stateDdlFields.Text = "Name";
                stateDdlFields.Value = "Id";

                stateDdlProperties.DropDownListFields = stateDdlFields;

                return stateDdlProperties;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the country DDL.
        /// </summary>
        /// <value>
        /// The country DDL.
        /// </value>
        public DropDownListProperties CountryDdl
        {
            get
            {
                var countryDdlProperties = new DropDownListProperties();
                var countryDdlFields = new DropDownListFields();

                countryDdlProperties.DataSource = _domainListManager.GetCountryList();

                countryDdlFields.Text = "Name";
                countryDdlFields.Value = "Id";

                countryDdlProperties.DropDownListFields = countryDdlFields;

                return countryDdlProperties;
            }
        }

        /// <inheritdoc />
        /// <summary>
        /// Gets the agencies DDL.
        /// </summary>
        /// <value>
        /// The agencies DDL.
        /// </value>
        public DropDownListProperties AgenciesDdl
        {
            get
            {
                var agenciesDdlProperties = new DropDownListProperties();
                var agenciesDdlFields = new DropDownListFields();

                agenciesDdlProperties.DataSource = _domainListManager.GetAllAgenciesList();

                agenciesDdlFields.Text = "Name";
                agenciesDdlFields.Value = "Id";

                agenciesDdlProperties.DropDownListFields = agenciesDdlFields;

                return agenciesDdlProperties;
            }
        }

        #endregion

        #region Datasources

        /// <inheritdoc />
        /// <summary>
        /// Gets the agencies datasource.
        /// </summary>
        /// <returns>
        /// The agencies datasource.
        /// </returns>
        public List<Agency> GetAgenciesDatasource => _domainListManager.GetAllAgenciesList();

        #endregion
    }
}
