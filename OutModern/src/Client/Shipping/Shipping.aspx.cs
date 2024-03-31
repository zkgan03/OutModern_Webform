using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Shipping
{
    public partial class Shipping : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve the dummy data from the session variable
                DataTable dummyData = (DataTable)Session["DummyData"];

                //// Retrieve the subtotal value from session
                decimal subtotal = (decimal)Session["Subtotal"];
                decimal delivery = 5;
                if (subtotal > 100)
                {
                    delivery = 0;
                    lblDeliveryCost.Text = "RM0.00";
                }
                decimal tax = (subtotal * 6 / 100);
                decimal total = subtotal + tax + delivery;



                lblItemPrice.Text = "RM" + subtotal.ToString("N2");
                lblTax.Text = "RM" + (subtotal * 6 / 100).ToString("N2");
                lblTotal.Text = "RM" + total.ToString("N2");

                // Bind the dummy data to the ListView control
                ProductListView.DataSource = dummyData;
                ProductListView.DataBind();
                BindData();
            }

        }

        private void BindData()
        {
            DataTable dummyAddData = GetDummyAddData();

            // Store the data source in a session variable
            Session["DummyAddData"] = dummyAddData;

            // Bind the data to the ProductListView
            AddressListView.DataSource = dummyAddData;
            AddressListView.DataBind();


        }

        public static DataTable GetDummyAddData()
        {
            DataTable dummyAddData = new DataTable();

            // Add columns to match your GridView's DataFields
            dummyAddData.Columns.Add("AddressName", typeof(string));
            dummyAddData.Columns.Add("AddressLine", typeof(string));
            dummyAddData.Columns.Add("Country", typeof(string));
            dummyAddData.Columns.Add("State", typeof(string));
            dummyAddData.Columns.Add("PostalCode", typeof(string));

            // Add rows with dummy data
            dummyAddData.Rows.Add("Zhiken", "Sample Address Address", "Malaysia", "Wilayah Persekutuan", "54200");
            dummyAddData.Rows.Add("Rando", "Sample Address", "Malaysia", "Wilayah Persekutuan", "54200");

            // Add more rows as needed for testing


            return dummyAddData;
        }

        protected void AddressListView_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                // Add client-side click event handler to the data item
                var dataItem = e.Item.FindControl("address-item") as HtmlGenericControl;
                if (dataItem != null)
                {
                    dataItem.Attributes["onclick"] = "selectAddress(this)";
                }
            }
        }


        protected void btnProceed_Click(object sender, EventArgs e)
        {
            // Retrieve the data source from the session variable
            DataTable dummyData = (DataTable)Session["DummyData"];

            // Check if the DataTable is not null and contains at least one row
            if (dummyData != null && dummyData.Rows.Count > 0)
            {
                // Store the dummy data in a session variable
                Session["DummyData"] = dummyData;

                // Redirect to the Shipping page
                Response.Redirect("~/src/Client/Payment/Payment.aspx");
            }
            else
            {
                // Cart is empty, disable the button
                btnProceed.Enabled = false;

                // Optionally, you can also display a message to the user
                // lblEmptyCart.Visible = true;
            }
        }
    }
}