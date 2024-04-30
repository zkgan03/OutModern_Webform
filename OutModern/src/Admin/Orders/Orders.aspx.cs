using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using OutModern.src.Admin.Interfaces;

namespace OutModern.src.Admin.Orders
{
    public partial class Orders : System.Web.UI.Page, IFilter
    {

        protected static readonly string OrderDetails = "OrderDetails";
        protected static readonly string OrderEdit = "OrderEdit";
        protected static readonly string OrderAdd = "OrderAdd";

        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { OrderDetails , "~/src/Admin/OrderDetails/OrderDetails.aspx" },
            { OrderEdit , "~/src/Admin/OrderEdit/OrderEdit.aspx" },
            {OrderAdd, "~/src/Admin/OrderAdd/OrderAdd.aspx" }
        };

        private string ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lvOrders.DataSource = getOrders();
                lvOrders.DataBind();
            }
        }
        //search logic
        public void FilterListView(string searchTerm)
        {
            lvOrders.DataSource = FilterDataTable(getOrders(), searchTerm);
            lvOrders.DataBind();
        }

        private DataTable FilterDataTable(DataTable dataTable, string searchTerm)
        {
            // Escape single quotes for safety
            string safeSearchTerm = searchTerm.Replace("'", "''");

            // Build the filter expression with relevant fields
            string expression = string.Format(
                "Convert(OrderId, 'System.String') LIKE '%{0}%' OR " +
                "CustomerName LIKE '%{0}%' OR " +
                "Convert(OrderDateTime, 'System.String') LIKE '%{0}%' OR " +
                "Convert(Total, 'System.String') LIKE '%{0}%' OR " +
                "OrderStatus LIKE '%{0}%'",
                safeSearchTerm);

            // Filter the rows
            DataRow[] filteredRows = dataTable.Select(expression);

            // Create a new DataTable for the filtered results
            DataTable filteredDataTable = dataTable.Clone();

            // Import the filtered rows
            foreach (DataRow row in filteredRows)
            {
                filteredDataTable.ImportRow(row);
            }

            return filteredDataTable;
        }


        //store each column sorting state into viewstate
        private Dictionary<string, string> SortDirections
        {
            get
            {
                if (ViewState["SortDirections"] == null)
                {
                    ViewState["SortDirections"] = new Dictionary<string, string>();
                }
                return (Dictionary<string, string>)ViewState["SortDirections"];
            }
            set
            {
                ViewState["SortDirections"] = value;
            }
        }

        // Toggle Sorting
        private void toggleSortDirection(string columnName)
        {
            if (!SortDirections.ContainsKey(columnName))
            {
                SortDirections[columnName] = "ASC";
            }
            else
            {
                SortDirections[columnName] = SortDirections[columnName] == "ASC" ? "DESC" : "ASC";
            }
        }

        //
        // DB Operation
        //

        //Get all orders
        protected DataTable getOrders(string sortExpression = null, string sortDirection = "ASC")
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string sqlQuery =
                    "Select OrderId, CustomerFullName as CustomerName, OrderDateTime, Total, OrderStatusName " +
                    "FROM [Order], OrderStatus, Customer " +
                    "WHERE [Order].OrderStatusId = OrderStatus.OrderStatusId " +
                    "AND [Order].CustomerId = Customer.CustomerId ";

                if (!string.IsNullOrEmpty(sortExpression))
                {
                    sqlQuery += "ORDER BY " + sortExpression + " " + sortDirection;
                }

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    data.Load(command.ExecuteReader());
                }

                data.Columns.Add("ProductDetails", typeof(DataTable));
                foreach (DataRow row in data.Rows)
                {
                    row["ProductDetails"] = getProductOrdered(row["OrderId"].ToString());
                }
            }

            return data;
        }

        //get the product Ordered for a particular order
        private DataTable getProductOrdered(string orderId)
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string sqlQuery =
                    "Select Product.ProductName, OrderItem.Quantity " +
                    "FROM [Order], OrderItem, ProductDetail, Product " +
                    "WHERE [Order].OrderId = OrderItem.OrderId " +
                    "AND OrderItem.ProductDetailId = ProductDetail.ProductDetailId " +
                    "AND ProductDetail.ProductId = Product.ProductId " +
                    "AND [Order].OrderId = @orderId;";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@orderId", orderId);
                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }

        // update the order status based on the order id
        private int updateOrderStatus(string orderId, string orderStatusName)
        {
            int affectedRows = 0;
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string sqlQuery = "UPDATE [Order] " +
                    "SET [Order].OrderStatusId = OrderStatus.OrderStatusId " +
                    "FROM [Order], OrderStatus " +
                    "WHERE OrderId = @orderId AND OrderStatus.OrderStatusName = @orderStatusName";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@orderId", orderId);
                    command.Parameters.AddWithValue("@orderStatusName", orderStatusName);
                    affectedRows = command.ExecuteNonQuery();
                }
            }
            return affectedRows;
        }


        //
        //Page Event
        //
        protected void lvOrders_PagePropertiesChanged(object sender, EventArgs e)
        {
            string sortExpression = ViewState["SortExpression"]?.ToString();
            lvOrders.DataSource =
                sortExpression == null ?
                getOrders() :
                getOrders(sortExpression, SortDirections[sortExpression]);
            lvOrders.DataBind();
        }

        protected void lvOrders_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType != ListViewItemType.DataItem) return;


            DataRowView rowView = (DataRowView)e.Item.DataItem;
            HtmlGenericControl statusSpan = (HtmlGenericControl)e.Item.FindControl("orderStatus");
            string status = rowView["OrderStatusName"].ToString();

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

        protected void lvOrders_Sorting(object sender, ListViewSortEventArgs e)
        {
            toggleSortDirection(e.SortExpression); // Toggle sorting direction for the clicked column

            ViewState["SortExpression"] = e.SortExpression; // used for retain the sorting

            // Re-bind the ListView with sorted data
            lvOrders.DataSource = getOrders(e.SortExpression, SortDirections[e.SortExpression]);
            lvOrders.DataBind();
        }

        protected void lvOrders_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

            if (e.CommandName == "ToShipped" || e.CommandName == "ToCancel" || e.CommandName == "ToPlaced")
            {
                // Update order status based on the command
                string orderId = e.CommandArgument.ToString();
                string orderStatus = getStatusBasedOnCommand(e.CommandName);
                int affectedRow = updateOrderStatus(orderId, orderStatus);

                if (affectedRow > 0)
                {
                    lblStatusUpdataMsg.CssClass += " text-green-600";
                    lblStatusUpdataMsg.Text = $"Order id={orderId}, status updated successfully";
                }
                else
                {
                    lblStatusUpdataMsg.CssClass += " text-red-600";
                    lblStatusUpdataMsg.Text = $"Order id={orderId}, failed to update order status...";
                }
            }

            string sortExpression = ViewState["SortExpression"]?.ToString();
            lvOrders.DataSource =
                sortExpression == null ?
                getOrders() :
                getOrders(sortExpression, SortDirections[sortExpression]);
            lvOrders.DataBind();
        }

        // helper method to get the status based on the command
        private string getStatusBasedOnCommand(string commandName)
        {
            switch (commandName)
            {
                case "ToShipped":
                    return "Shipped";
                case "ToCancel":
                    return "Cancelled";
                case "ToPlaced":
                    return "Order Placed";
                default:
                    return null;
            }
        }
    }
}