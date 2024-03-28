using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Cart
{
    public partial class Cart : System.Web.UI.Page
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

            // Store the data source in a session variable
            Session["DummyData"] = dummyData;

            // Bind the data to the ProductListView
            ProductListView.DataSource = dummyData;
            ProductListView.DataBind();

            // Calculate subtotal and grand total
            UpdateSubtotalAndGrandTotal(dummyData);
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

        protected void btnDecrement_Click(object sender, EventArgs e)
        {
            Button btnDecrement = (Button)sender;
            ListViewItem item = (ListViewItem)btnDecrement.NamingContainer;
            TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");

            int quantity = int.Parse(txtQuantity.Text);
            if (quantity > 1)
            {
                quantity--;
                txtQuantity.Text = quantity.ToString();

                // Get the index of the item in the ListView
                int itemIndex = item.DataItemIndex;

                // Retrieve the data source from the session variable
                DataTable dummyData = (DataTable)Session["DummyData"];
                dummyData.Rows[itemIndex]["Quantity"] = quantity;

                // Recalculate subtotal and update UI
                UpdateSubtotalAndGrandTotal(dummyData);

                // Rebind the ListView with the updated data source for the specific item
                BindData(dummyData);
            }
        }

        protected void btnIncrement_Click(object sender, EventArgs e)
        {
            Button btnIncrement = (Button)sender;
            ListViewItem item = (ListViewItem)btnIncrement.NamingContainer;
            TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");

            int quantity = int.Parse(txtQuantity.Text);
            quantity++;
            txtQuantity.Text = quantity.ToString();

            // Get the index of the item in the ListView
            int itemIndex = item.DataItemIndex;

            // Retrieve the data source from the session variable
            DataTable dummyData = (DataTable)Session["DummyData"];
            dummyData.Rows[itemIndex]["Quantity"] = quantity;

            // Recalculate subtotal and update UI
            UpdateSubtotalAndGrandTotal(dummyData);

            // Rebind the ListView with the updated data source for the specific item
            BindData(dummyData);
        }


        private void UpdateSubtotalAndGrandTotal(DataTable dummyData)
        {
            // Recalculate subtotal and grand total
            decimal subtotal = dummyData.AsEnumerable().Sum(row => row.Field<decimal>("Price") * row.Field<int>("Quantity"));
            lblSubtotal.Text = subtotal.ToString("C");
            lblGrandTotal.Text = (subtotal + 5.00m).ToString("C"); // Adding $5.00 for delivery charge
        }

        private void BindData(DataTable dataSource)
        {
            // Set the data source for the ProductListView
            ProductListView.DataSource = dataSource;

            // Bind the data to the ProductListView
            ProductListView.DataBind();
        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Button btnDelete = (Button)sender;
            ListViewItem item = (ListViewItem)btnDelete.NamingContainer;

            // Retrieve the data source from the session variable
            DataTable dummyData = (DataTable)Session["DummyData"];

            // Check if the DataTable is not empty
            if (dummyData.Rows.Count > 0)
            {
                // Get the index of the item in the ListView
                int itemIndex = item.DataItemIndex;

                // Remove the row corresponding to the item to be deleted
                dummyData.Rows.RemoveAt(itemIndex);

                // Recalculate subtotal and update UI
                UpdateSubtotalAndGrandTotal(dummyData);

                // Rebind the ListView with the updated data source
                BindData(dummyData);
            }
        }



        protected void btnApply_Click(object sender, EventArgs e)
        {

        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            // Retrieve the data source from the session variable
            DataTable dummyData = (DataTable)Session["DummyData"];

            // Check if the DataTable is not null and contains at least one row
            if (dummyData != null && dummyData.Rows.Count > 0)
            {
                // Store the dummy data in a session variable
                Session["DummyData"] = dummyData;

                // Redirect to the Payment page
                Response.Redirect("~/src/Client/Payment/Payment.aspx");
            }
            else
            {
                // Cart is empty, disable the button
                btnCheckout.Enabled = false;

                // Optionally, you can also display a message to the user
                // lblEmptyCart.Visible = true;
            }
        }

    }


}