using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;
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

            }

            BindAddresses();
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
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Write SQL query to select addresses based on customer ID
                string query = "SELECT * FROM Address WHERE CustomerId = @CustomerId AND isDeleted = 0";

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

            if (ValidateAndHighlight())
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

                txtNickname.Text = "";
                txtAddr.Text = "";
                txtState.Text = "";
                txtPostal.Text = "";
                ddlCountryOrigin.SelectedIndex = 0;

                // Add the address to the database
                AddAddressToDatabase(address);

                Response.Redirect(Request.RawUrl);
            }

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
            Address selectedAddress = Session["SelectedAddress"] as Address;

            Session.Remove("SelectedAddress");

            // Check if an address is selected
            if (selectedAddress != null)
            {
                // Store the selected address in a session variable
                Session["SelectedAddressPayment"] = selectedAddress;



                // Redirect to the Payment.aspx page
                Response.Redirect("../Payment/Payment.aspx");
            }
            else
            {
                // Display a message if no address is selected
                lblMessage.Visible = true;
            }

        }

        protected void AddressListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                ViewState["selectedItem"] = Convert.ToInt32(e.CommandArgument);  // Store the selected index

                // Retrieve the index of the selected item
                int index = Convert.ToInt32(e.CommandArgument);

                // Retrieve the primary key of the selected item
                int addressId = Convert.ToInt32(AddressListView.DataKeys[index].Value);

                // Access the selected data item using the primary key
                Address selectedAddress = GetAddressById(addressId);

                // Save the selected address details to session
                Session["SelectedAddress"] = selectedAddress;

                BindAddresses();

            }
        }

        protected void AddressListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var dataItem = e.Item as ListViewDataItem;

                // Check if the current row is the selected row
                if (ViewState["selectedItem"] != null && ViewState["selectedItem"].ToString() == e.Item.DataItemIndex.ToString())
                {
                    // Find the LinkButton in the current item
                    LinkButton linkButton = e.Item.FindControl("LinkButton1") as LinkButton;
                    if (linkButton != null)
                    {
                        // Apply the highlight CSS class or any other desired styling
                        linkButton.Style["box-shadow"] += "0 0 10px #000000;";
                    }
                }
            }
        }


        private Address GetAddressById(int addressId)
        {
            Address address = null;

            // Establish connection to your database (assuming SQL Server)
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Write SQL query to select address details based on addressId
                string query = "SELECT * FROM Address WHERE AddressId = @AddressId";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Add parameter for the addressId
                    command.Parameters.AddWithValue("@AddressId", addressId);

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Create a new Address object with the retrieved details
                            address = new Address
                            {
                                AddressId = Convert.ToInt32(reader["AddressId"]),
                                CustomerId = Convert.ToInt32(reader["CustomerId"]),
                                AddressName = reader["AddressName"].ToString(),
                                AddressLine = reader["AddressLine"].ToString(),
                                Country = reader["Country"].ToString(),
                                State = reader["State"].ToString(),
                                PostalCode = reader["PostalCode"].ToString()
                            };
                        }
                    }
                }
            }

            return address;
        }

        protected void AddressListView_SelectedIndexChanging(object sender, ListViewSelectEventArgs e)
        {

        }
        protected void AddressListView_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected bool ValidateAndHighlight()
        {
            try
            {
                string nickname = txtNickname.Text.Trim();
                string addr = txtAddr.Text.Trim();
                string postal = txtPostal.Text.Trim();
                string state = txtState.Text.Trim();
                string country = ddlCountryOrigin.SelectedValue;

                List<Control> errorControls = new List<Control>();

                if (string.IsNullOrEmpty(nickname))
                {
                    errorControls.Add(txtNickname);
                }
                else
                {
                    RemoveErrorBorder(txtNickname);
                }

                if (string.IsNullOrEmpty(addr))
                {
                    errorControls.Add(txtAddr);
                }
                else
                {
                    RemoveErrorBorder(txtAddr);
                }

                if (string.IsNullOrEmpty(postal))
                {
                    errorControls.Add(txtPostal);
                }
                else
                {
                    RemoveErrorBorder(txtPostal);
                }

                if (string.IsNullOrEmpty(state))
                {
                    errorControls.Add(txtState);
                }
                else
                {
                    RemoveErrorBorder(txtState);
                }

                if (country == "default")
                {
                    errorControls.Add(ddlCountryOrigin);
                }
                else
                {
                    RemoveErrorBorder(ddlCountryOrigin);
                }

                // Apply red border only to controls with errors
                foreach (Control control in errorControls)
                {
                    if (control is WebControl webControl)
                    {
                        webControl.CssClass += " error-border";
                    }
                }

                return errorControls.Count == 0; // Return true if no errors, false otherwise
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error in ValidateAndHighlight: " + ex.Message);
                return false;
            }
        }

        protected void RemoveErrorBorder(WebControl control)
        {
            // Remove error border CSS class from the control
            control.CssClass = control.CssClass.Replace("error-border", "").Trim();
        }




    }

}