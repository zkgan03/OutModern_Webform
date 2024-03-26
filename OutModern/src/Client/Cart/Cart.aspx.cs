using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.Client.Cart
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

            // Set the data source for the ProductListView
            ProductListView.DataSource = dummyData;

            // Bind the data to the ProductListView
            ProductListView.DataBind();

            // Calculate subtotal and grand total
            decimal subtotal = dummyData.AsEnumerable().Sum(row => row.Field<decimal>("Subtotal"));
            lblSubtotal.Text = subtotal.ToString("C");
            lblGrandTotal.Text = (subtotal + 5.00m).ToString("C"); // Adding $5.00 for delivery charge
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
            dummyData.Rows.Add("~/images/mastercard_logo.png", "Iphone 11", "White", "XL", 1500.00m, 1,3000.00m);
            dummyData.Rows.Add("~/images/product-img/trouser-size-guide.png", "DTX 4090", "Black", "XL", 10.00m, 2, 10.00m);
            // Add more rows as needed for testing

            return dummyData;
        }

        protected void btnDecrement_Click(object sender, EventArgs e)
        {
            // Find the corresponding text box and decrement its value
            Button btnDecrement = (Button)sender;
            ListViewItem item = (ListViewItem)btnDecrement.NamingContainer;
            TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");

            int quantity = int.Parse(txtQuantity.Text);
            if (quantity > 1)
            {
                quantity--;
                txtQuantity.Text = quantity.ToString();
                UpdateSubtotal(item, quantity);
            }
        }

        protected void btnIncrement_Click(object sender, EventArgs e)
        {
            // Find the corresponding text box and increment its value
            Button btnIncrement = (Button)sender;
            ListViewItem item = (ListViewItem)btnIncrement.NamingContainer;
            TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");

            int quantity = int.Parse(txtQuantity.Text);
            quantity++;
            txtQuantity.Text = quantity.ToString();
            UpdateSubtotal(item, quantity);
        }

        private void UpdateSubtotal(ListViewItem item, int quantity)
        {
            Label lblPrice = (Label)item.FindControl("lblPrice");
            Label lblSubtotal = (Label)item.FindControl("lblSubtotal");

            if (lblPrice != null && lblSubtotal != null)
            {
                decimal price = 0;
                if (decimal.TryParse(lblPrice.Text.Replace("$", "").Replace(",", ""), out price))
                {
                    decimal subtotal = price * quantity;
                    lblSubtotal.Text = subtotal.ToString("C");
                    UpdateGrandTotal();
                }
                else
                {
                    // Handle the case where lblPrice.Text is not a valid decimal
                }
            }
            else
            {
                // Handle the case where lblPrice or lblSubtotal is not found
            }
        }


        private void UpdateGrandTotal()
        {
            // Recalculate the grand total
            decimal grandTotal = 0;
            foreach (ListViewItem item in ProductListView.Items)
            {
                Label lblSubtotal = (Label)item.FindControl("lblSubtotal");
                grandTotal += decimal.Parse(lblSubtotal.Text.Replace("$", "").Replace(",", ""));
            }
            lblSubtotal.Text = grandTotal.ToString("C");
            lblGrandTotal.Text = (grandTotal + 5.00m).ToString("C"); // Adding $5.00 for delivery charge
        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {

            //code



        }
    }


}