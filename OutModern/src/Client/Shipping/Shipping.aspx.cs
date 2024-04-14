using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Shipping
{
    public class Address
    {
        public int AddressId { get; set; }
        public int CustomerId { get; set; }
        public string AddressName { get; set; }
        public string AddressLine { get; set; }
        public string Country { get; set; }
        public string State { get; set; }
        public string PostalCode { get; set; }
    }

    public partial class Shipping : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the dummy data from the session variable
                DataTable dummyData = (DataTable)Session["DummyData"];

                //// Retrieve the subtotal value from session
                //decimal subtotal = (decimal)Session["Subtotal"];
                //decimal delivery = 5;
                //if (subtotal > 100)
                //{
                //    delivery = 0;
                //    lblDeliveryCost.Text = "RM0.00";
                //}
                //decimal tax = (subtotal * 6 / 100);
                //decimal total = subtotal + tax + delivery;



                //lblItemPrice.Text = "RM" + subtotal.ToString("N2");
                //lblTax.Text = "RM" + (subtotal * 6 / 100).ToString("N2");
                //lblTotal.Text = "RM" + total.ToString("N2");

                // Bind the dummy data to the ListView control
                ProductListView.DataSource = dummyData;
                ProductListView.DataBind();
                BindAddresses();
            }

        }

        private void BindAddresses()
        {
            // Get the list of addresses for the current customer
            List<Address> addresses = GetAddresses();

            // Bind the addresses to the ListView control
            AddressListView.DataSource = addresses;
            AddressListView.DataBind();
        }

        //REMEMBER CHANGE CUSTOMER ID 
        private List<Address> GetAddresses()
        {
            List<Address> addresses = new List<Address>();

            // Dummy customer ID for testing
            int dummyCustomerId = 1;

            // Establish connection to your database (assuming SQL Server)
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\b1ank3r\source\repos\OutModern_Webform\OutModern\App_Data\OutModern.mdf;Integrated Security=True";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Write SQL query to select addresses based on customer ID
                string query = "SELECT * FROM Address WHERE CustomerId = @CustomerId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameter for the customer ID
                    command.Parameters.AddWithValue("@CustomerId", dummyCustomerId);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // Create a new Address object for each record and add it to the list
                            Address address = new Address
                            {
                                AddressId = Convert.ToInt32(reader["AddressId"]),
                                CustomerId = Convert.ToInt32(reader["CustomerId"]),
                                AddressName = reader["AddressName"].ToString(),
                                AddressLine = reader["AddressLine"].ToString(),
                                Country = reader["Country"].ToString(),
                                State = reader["State"].ToString(),
                                PostalCode = reader["PostalCode"].ToString()
                            };

                            addresses.Add(address);
                        }
                    }
                }
            }

            // Return the list of addresses
            return addresses;
        }


        //REMEMBER CHANGE CUSTOMER ID 
        protected void btnAddAddress_Click(object sender, EventArgs e)
        {

            // If all textboxes are filled, proceed to add the address to the database
            Address address = new Address
            {
                CustomerId = 1, // Replace with the actual customer ID
                AddressName = txtNickname.Text,
                AddressLine = txtAddr.Text,
                Country = ddlCountryOrigin.SelectedItem.Text,
                State = txtState.Text,
                PostalCode = txtPostal.Text
            };

            // Add the address to the database
            AddAddressToDatabase(address);

            // Rebind the addresses after adding a new address
            BindAddresses();
        }

        private void AddAddressToDatabase(Address address)
        {
            // Database connection and insert command logic as shown in the previous response
            string connectionString = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=C:\Users\b1ank3r\source\repos\OutModern_Webform\OutModern\App_Data\OutModern.mdf;Integrated Security=True";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string insertQuery = @"INSERT INTO [dbo].[Address] (CustomerId, AddressName, AddressLine, Country, State, PostalCode) 
                        VALUES (@CustomerId, @AddressName, @AddressLine, @Country, @State, @PostalCode)";

                using (SqlCommand command = new SqlCommand(insertQuery, connection))
                {
                    command.Parameters.AddWithValue("@CustomerId", address.CustomerId);
                    command.Parameters.AddWithValue("@AddressName", address.AddressName);
                    command.Parameters.AddWithValue("@AddressLine", address.AddressLine);
                    command.Parameters.AddWithValue("@Country", address.Country);
                    command.Parameters.AddWithValue("@State", address.State);
                    command.Parameters.AddWithValue("@PostalCode", address.PostalCode);

                    command.ExecuteNonQuery();
                }

            }

        }

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            // Retrieve the selected address details from session variables
            string addressName = Session["SelectedAddressName"] as string;
            string addressLine = Session["SelectedAddressLine"] as string;
            string postalCode = Session["SelectedPostalCode"] as string;
            string state = Session["SelectedState"] as string;
            string country = Session["SelectedCountry"] as string;

            // Check if an address is selected
            if (!string.IsNullOrEmpty(addressName) && !string.IsNullOrEmpty(addressLine) &&
                !string.IsNullOrEmpty(postalCode) && !string.IsNullOrEmpty(state) &&
                !string.IsNullOrEmpty(country))
            {
                // Proceed with further actions using the selected address details

                // For example, redirect to the payment page with selected address details
                Response.Redirect(string.Format("Payment.aspx?AddressName={0}&AddressLine={1}&PostalCode={2}&State={3}&Country={4}",
                    addressName, addressLine, postalCode, state, country));
            }
            else
            {
                // Display a message if no address is selected
                lblMessage.Visible = true;
            }

            BindAddresses();
        }

        protected void AddressListView_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Get the index of the selected item
            int selectedIndex = AddressListView.SelectedIndex;

            // Check if an item is selected
            if (selectedIndex != -1)
            {
                // Retrieve the data item bound to the selected index
                var dataItem = AddressListView.DataKeys[selectedIndex];

                // Retrieve the values of the properties
                string addressName = dataItem["AddressName"].ToString();
                string addressLine = dataItem["AddressLine"].ToString();
                string postalCode = dataItem["PostalCode"].ToString();
                string state = dataItem["State"].ToString();
                string country = dataItem["Country"].ToString();

                // Store the selected address details in session variables
                Session["SelectedAddressName"] = addressName;
                Session["SelectedAddressLine"] = addressLine;
                Session["SelectedPostalCode"] = postalCode;
                Session["SelectedState"] = state;
                Session["SelectedCountry"] = country;

                // Log debug information to the browser's console
                string script = $"console.log('Selected Address: {addressName}, {addressLine}, {postalCode}, {state}, {country}');";
                ScriptManager.RegisterStartupScript(this, GetType(), "logSelectedAddress", script, true);

            }
        }



    }
}