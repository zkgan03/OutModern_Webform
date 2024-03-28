using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.OrderDetails
{
    public partial class OrderDetails : System.Web.UI.Page
    {

        protected static readonly string OrderEdit = "OrderEdit";
        protected static readonly string CustomerDetails = "CustomerDetails";


        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { OrderEdit , "~/src/Admin/OrderEdit/OrderEdit.aspx" },
            { CustomerDetails , "~/src/Admin/CustomerDetails/CustomerDetails.aspx" }
        };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lvProductOrder.DataSource = GetOrderDetails();
                lvProductOrder.DataBind();
                Page.DataBind();
            }
        }

        // dummy data
        private DataTable GetOrderDetails()
        {
            DataTable table = new DataTable();
            table.Columns.Add("Id", typeof(int));
            table.Columns.Add("Name", typeof(string));
            table.Columns.Add("Size", typeof(string));
            table.Columns.Add("Path", typeof(string)); // Assuming you have an image path column
            table.Columns.Add("Price", typeof(double));
            table.Columns.Add("Quantity", typeof(int));
            table.Columns.Add("Subtotal", typeof(double));

            // Add 10 rows of dummy data
            for (int i = 1; i <= 5; i++)
            {
                DataRow row = table.NewRow();
                row["Id"] = i;
                row["Name"] = $"Product {i}";
                row["Size"] = "M"; // Example size
                row["Path"] = "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png"; // Example image path
                row["Price"] = 19.99m;
                row["Quantity"] = 2;
                row["Subtotal"] = 100.00;
                table.Rows.Add(row);
            }

            return table;
        }

        protected void lvProductOrder_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void lvProductOrder_PagePropertiesChanged(object sender, EventArgs e)
        {
            lvProductOrder.DataSource = GetOrderDetails();
            lvProductOrder.DataBind();
        }

    }
}