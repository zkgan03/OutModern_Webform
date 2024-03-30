using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.CustomerEdit
{
    public partial class CustomerEdit : System.Web.UI.Page
    {
        protected static readonly string CustomerDetails = "CustomerDetails";

        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { CustomerDetails , "~/src/Admin/CustomerDetails/CustomerDetails.aspx" },
        };
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                // Bind the DataTable to the Repeater control
                rptAddresses.DataSource = GetAddresses();
                rptAddresses.DataBind();
            }
        }

        private DataTable GetAddresses()
        {
            // Create a DataTable with desired columns
            DataTable addresses = new DataTable();
            addresses.Columns.Add("AddressName");
            addresses.Columns.Add("AddressLine");
            addresses.Columns.Add("PostalCode");
            addresses.Columns.Add("City");
            addresses.Columns.Add("State");
            addresses.Columns.Add("Country");

            // Generate dummy data (modify as needed)
            for (int i = 0; i < 2; i++) // Create 5 dummy entries
            {
                DataRow row = addresses.NewRow();
                row["AddressName"] = $"Address {i + 1}";
                row["AddressLine"] = $"Jalan Example {i}";
                row["PostalCode"] = $"12345-{i}";
                row["City"] = $"City {i}";
                row["State"] = $"State {i}";
                row["Country"] = $"Country {i}";
                addresses.Rows.Add(row);
            }

            return addresses;
        }

        protected void lbUpdate_Click(object sender, EventArgs e)
        {
            Response.Redirect(urls[CustomerDetails] + "?id=" + "123");
        }

        protected void lbDiscard_Click(object sender, EventArgs e)
        {
            Response.Redirect(urls[CustomerDetails] + "?id=" + "123");
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            Response.Redirect(urls[CustomerDetails] + "?id=" + "123");
        }
    }
}