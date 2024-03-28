using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Payment
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            DataTable dummyData = GetDummyData();

            // Set the data source for the ProductListView
            ProductListView.DataSource = dummyData;

            // Bind the data to the ProductListView
            ProductListView.DataBind();
        }



        public static DataTable GetDummyData()
        {
            DataTable dummyData = new DataTable();

            // Add columns to match your GridView's DataFields
            dummyData.Columns.Add("ProductImageUrl", typeof(string));
            dummyData.Columns.Add("ProductName", typeof(string));
            dummyData.Columns.Add("Color", typeof(string));
            dummyData.Columns.Add("Size", typeof(string));
            dummyData.Columns.Add("Price", typeof(decimal));
            dummyData.Columns.Add("Quantity", typeof(int));
            dummyData.Columns.Add("Subtotal", typeof(decimal));

            // Add rows with dummy data
            dummyData.Rows.Add("~/images/mastercard_logo.png", "Premium Hoodie", "White", "XL", 1500.00m, 1, 3000.00m);
            dummyData.Rows.Add("~/images/mastercard_logo.png", "Premium Hoodie", "White", "XL", 1500.00m, 1, 3000.00m);
            dummyData.Rows.Add("~/images/mastercard_logo.png", "Premium Hoodie", "White", "XL", 1500.00m, 1, 3000.00m);
            dummyData.Rows.Add("~/images/mastercard_logo.png", "Premium Hoodie", "White", "XL", 1500.00m, 1, 3000.00m);
            dummyData.Rows.Add("~/images/product-img/trouser-size-guide.png", "DTX 4090", "Black", "XL", 10.00m, 2, 10.00m);
            // Add more rows as needed for testing

            return dummyData;
        }

        protected void TogglePaymentMethod(object sender, EventArgs e)
        {
            pnlPaymentDetails.Visible = !pnlPaymentDetails.Visible;
        }

        protected void ToggleBillingAddress(object sender, EventArgs e)
        {
            pnlBillingDetails.Visible = !pnlBillingDetails.Visible;
        }
    }
}