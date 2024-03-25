using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.Orders
{
    public partial class Orders : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lvOrders.DataSource = GetOrders();
                lvOrders.DataBind();
            }
        }

        protected void lvOrders_PagePropertiesChanged(object sender, EventArgs e)
        {
            lvOrders.DataSource = GetOrders();
            lvOrders.DataBind();
        }


        //dummy data
        protected DataTable GetOrders()
        {
            DataTable dtOrders = new DataTable();
            dtOrders.Columns.AddRange(new DataColumn[] {
                new DataColumn("OrderId", typeof(int)),
                new DataColumn("CustomerName", typeof(string)),
                new DataColumn("ProductDetails", typeof(DataTable)),
                new DataColumn("OrderDateTime", typeof(DateTime)),
                new DataColumn("SubTotal", typeof(decimal)),
                new DataColumn("OrderStatus", typeof(string))
              });

            // Generate 5 dummy orders with random statuses
            string[] orderStatuses = { "Order Placed", "Shipped", "Cancelled", "Received" };
            Random random = new Random();
            for (int i = 0; i < 5; i++)
            {
                DataRow drOrder = dtOrders.NewRow();
                drOrder["OrderId"] = i + 1;
                drOrder["CustomerName"] = $"Customer {i + 1}";

                // Nested DataTable for products
                DataTable dtProducts = new DataTable();
                dtProducts.Columns.AddRange(new DataColumn[] {
                   new DataColumn("ProductName", typeof(string)),
                   new DataColumn("Quantity", typeof(int))
                  });
                dtProducts.Rows.Add("Product A", 2);
                dtProducts.Rows.Add("Product B", 1);

                drOrder["ProductDetails"] = dtProducts;
                drOrder["OrderDateTime"] = DateTime.Now.AddDays(-i);
                drOrder["SubTotal"] = 10.00m * (i + 1);
                drOrder["OrderStatus"] = orderStatuses[i % orderStatuses.Length];

                dtOrders.Rows.Add(drOrder);
            }

            return dtOrders;
        }

        protected void lbAddOrder_Click(object sender, EventArgs e)
        {

        }

        protected void lvOrders_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType != ListViewItemType.DataItem) return;


            DataRowView rowView = (DataRowView)e.Item.DataItem;
            HtmlGenericControl statusSpan = (HtmlGenericControl)e.Item.FindControl("orderStatus");
            string status = rowView["OrderStatus"].ToString();

            switch (status)
            {
                case "Order Placed":
                    statusSpan.Attributes["class"] += " order-placed";
                    break;
                case "Shipped":
                    statusSpan.Attributes["class"] += " shipped";
                    break;
                case "Cancelled":
                    statusSpan.Attributes["class"] += " cancelled";
                    break;
                case "Received":
                    statusSpan.Attributes["class"] += " received";
                    break;
                default:
                    // Handle cases where status doesn't match any of the above
                    break;
            }



        }

    }
}