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

        private void BindData(DataTable dataSource)
        {
            // Set the data source for the ProductListView
            ProductListView.DataSource = dataSource;

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
            dummyData.Rows.Add("~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-zoomed-in-61167de6440a2.png", "Premium Hoodie", "White", "XL", 1500.00m, 1, 3000.00m);
            dummyData.Rows.Add("~/images/product-img/trouser-size-guide.png", "DTX 4090", "Black", "XL", 10.00m, 2, 10.00m);
            // Add more rows as needed for testing

            foreach (DataRow row in dummyData.Rows)
            {
                decimal price = (decimal)row["Price"];
                int quantity = (int)row["Quantity"];
                row["Subtotal"] = price * quantity;
            }

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

                // Update the quantity in the DataTable
                dummyData.Rows[itemIndex]["Quantity"] = quantity;

                // Update the subtotal for the corresponding row
                decimal price = (decimal)dummyData.Rows[itemIndex]["Price"];
                dummyData.Rows[itemIndex]["Subtotal"] = price * quantity;

                // Recalculate subtotal and grand total
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

            // Update the quantity in the DataTable
            dummyData.Rows[itemIndex]["Quantity"] = quantity;

            // Update the subtotal for the corresponding row
            decimal price = (decimal)dummyData.Rows[itemIndex]["Price"];
            dummyData.Rows[itemIndex]["Subtotal"] = price * quantity;

            // Recalculate subtotal and grand total
            UpdateSubtotalAndGrandTotal(dummyData);

            // Rebind the ListView with the updated data source for the specific item
            BindData(dummyData);
        }



        private void UpdateSubtotalAndGrandTotal(DataTable dummyData)
        {

            // Recalculate subtotal and grand total
            decimal subtotal = dummyData.AsEnumerable().Sum(row => row.Field<decimal>("Price") * row.Field<int>("Quantity"));

            decimal delivery = 5;
            lblDeliveryCost.Text = "RM5.00";
            if (subtotal > 100)
            {
                delivery = 0;
                lblDeliveryCost.Text = "RM0.00";
            }

            lblSubtotal.Text = "RM" + subtotal.ToString("N2");
            lblGrandTotal.Text = "RM" + (subtotal + delivery).ToString("N2"); // Adding $5.00 for delivery charge

            // Store the subtotal value in a session variable
            Session["Subtotal"] = subtotal;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btnDelete = (LinkButton)sender;
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

                // Store subtotal in session
                UpdateSubtotalAndGrandTotal(dummyData);

                // Redirect to the Shipping page
                Response.Redirect("~/src/Client/Shipping/Shipping.aspx");
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