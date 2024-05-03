using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OutModern.src.Admin.Orders;
using System.Web.UI.HtmlControls;

namespace OutModern.src.Client.UserProfile
{
    public partial class ToShip : System.Web.UI.Page
    {

        private string ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            int custID;
            if (Request.Cookies["CustID"] == null)
            {
                Response.Redirect("~/src/Client/Login/Login.aspx");
            }
            else
            {
                custID = int.Parse(Request.Cookies["CustID"].Value);

                if (!IsPostBack)
                {
                    lvOrders.DataSource = getOrders(); // Bind the ListView on first load
                    lvOrders.DataBind();
                }
                else
                {
                    // Re-bind during postbacks to ensure data persists
                    lvOrders.DataSource = getOrders();
                    lvOrders.DataBind();
                }

                try
                {

                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        conn.Open();
                        //use parameterized query to prevent sql injection
                        string query = "SELECT * FROM [Customer] WHERE CustomerId = @custId";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@custId", custID);

                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.HasRows) // Check if there are any results
                        {
                            reader.Read(); // Read the first row

                            //left box display
                            lbl_username.Text = reader["CustomerUsername"].ToString();

                            string profileImagePath = reader["ProfileImagePath"].ToString();
                            img_profile.ImageUrl = profileImagePath;

                            reader.Close();
                        }

                    }
                }
                catch (Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
            
        }

        ////search logic
        //public void FilterListView(string searchTerm)
        //{
        //    lvOrders.DataSource = FilterDataTable(getOrders(), searchTerm);
        //    lvOrders.DataBind();
        //}

        //private DataTable FilterDataTable(DataTable dataTable, string searchTerm)
        //{
        //    // Escape single quotes for safety
        //    string safeSearchTerm = searchTerm.Replace("'", "''");

        //    // Build the filter expression with relevant fields
        //    string expression = string.Format(
        //        "Convert(OrderId, 'System.String') LIKE '%{0}%' OR " +
        //        "CustomerName LIKE '%{0}%' OR " +
        //        "Convert(OrderDateTime, 'System.String') LIKE '%{0}%' OR " +
        //        "Convert(Total, 'System.String') LIKE '%{0}%' OR " +
        //        "OrderStatus LIKE '%{0}%'",
        //        safeSearchTerm);

        //    // Filter the rows
        //    DataRow[] filteredRows = dataTable.Select(expression);

        //    // Create a new DataTable for the filtered results
        //    DataTable filteredDataTable = dataTable.Clone();

        //    // Import the filtered rows
        //    foreach (DataRow row in filteredRows)
        //    {
        //        filteredDataTable.ImportRow(row);
        //    }

        //    return filteredDataTable;
        //}

        ////store each column sorting state into viewstate
        //private Dictionary<string, string> SortDirections
        //{
        //    get
        //    {
        //        if (ViewState["SortDirections"] == null)
        //        {
        //            ViewState["SortDirections"] = new Dictionary<string, string>();
        //        }
        //        return (Dictionary<string, string>)ViewState["SortDirections"];
        //    }
        //    set
        //    {
        //        ViewState["SortDirections"] = value;
        //    }
        //}

        //// Toggle Sorting
        //private void toggleSortDirection(string columnName)
        //{
        //    if (!SortDirections.ContainsKey(columnName))
        //    {
        //        SortDirections[columnName] = "ASC";
        //    }
        //    else
        //    {
        //        SortDirections[columnName] = SortDirections[columnName] == "ASC" ? "DESC" : "ASC";
        //    }
        //}

        //
        // DB Operation
        //

        //Get all orders
        protected DataTable getOrders(string sortExpression = null, string sortDirection = "ASC")
        {
            int custID = int.Parse(Request.Cookies["CustID"].Value);

            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string sqlQuery =
                    "SELECT [Order].OrderId, Customer.CustomerFullName AS CustomerName, [Order].OrderDatetime, [Order].Total, OrderStatus.OrderStatusName " +
                    "FROM [Order] " +
                    "JOIN OrderStatus ON [Order].OrderStatusId = OrderStatus.OrderStatusId " +
                    "JOIN Customer ON [Order].CustomerId = Customer.CustomerId " +
                    "WHERE Customer.CustomerId = @custId AND [Order].OrderStatusId = @orderStatusId";

                if (!string.IsNullOrEmpty(sortExpression))
                {
                    sqlQuery += "ORDER BY " + sortExpression + " " + sortDirection;
                }

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@custId", custID);
                    command.Parameters.AddWithValue("@orderStatusId", 1);
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
        //protected void lvOrders_PagePropertiesChanged(object sender, EventArgs e)
        //{
        //    string sortExpression = ViewState["SortExpression"]?.ToString();
        //    lvOrders.DataSource =
        //        sortExpression == null ?
        //        getOrders() :
        //        getOrders(sortExpression, SortDirections[sortExpression]);
        //    lvOrders.DataBind();
        //}

        //protected void lvOrders_ItemDataBound(object sender, ListViewItemEventArgs e)
        //{
        //    if (e.Item.ItemType != ListViewItemType.DataItem) return;


        //    DataRowView rowView = (DataRowView)e.Item.DataItem;
        //    HtmlGenericControl statusSpan = (HtmlGenericControl)e.Item.FindControl("orderStatus");
        //    string status = rowView["OrderStatusName"].ToString();

        //    ////
        //    if (statusSpan != null)
        //    {

        //        switch (status)
        //        {
        //            case "Order Placed":
        //                statusSpan.Attributes["class"] += " order-placed";
        //                break;
        //            case "Shipped":
        //                statusSpan.Attributes["class"] += " shipped";
        //                break;
        //            case "Cancelled":
        //                statusSpan.Attributes["class"] += " cancelled";
        //                break;
        //            case "Received":
        //                statusSpan.Attributes["class"] += " received";
        //                break;
        //            default:
        //                // Handle cases where status doesn't match any of the above
        //                break;
        //        }

        //    }
        //}

        //protected void lvOrders_Sorting(object sender, ListViewSortEventArgs e)
        //{
        //    toggleSortDirection(e.SortExpression); // Toggle sorting direction for the clicked column

        //    ViewState["SortExpression"] = e.SortExpression; // used for retain the sorting

        //    // Re-bind the ListView with sorted data
        //    lvOrders.DataSource = getOrders(e.SortExpression, SortDirections[e.SortExpression]);
        //    lvOrders.DataBind();
        //}

        protected void lvOrders_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

            if (e.CommandName == "ToCancel")
            {
                // Update order status based on the command
                string orderId = e.CommandArgument.ToString();
                string orderStatus = getStatusBasedOnCommand(e.CommandName);
                int affectedRow = updateOrderStatus(orderId, orderStatus);

                if (affectedRow > 0)
                {
                    lblStatusUpdataMsg.CssClass += " text-green-600";
                    lblStatusUpdataMsg.Text = "Status updated successfully";
                }
                else
                {
                    lblStatusUpdataMsg.CssClass += " text-red-600";
                    lblStatusUpdataMsg.Text = "Failed to update order status...";
                }
            }

            //string sortExpression = ViewState["SortExpression"]?.ToString();
            //lvOrders.DataSource =
            //    sortExpression == null ?
            //    getOrders() :
            //    getOrders(sortExpression, SortDirections[sortExpression]);
            //lvOrders.DataBind();

            // Rebind the ListView with the latest data
            lvOrders.DataSource = getOrders();
            lvOrders.DataBind();

        }

        //helper method to get the status based on the command
        private string getStatusBasedOnCommand(string commandName)
        {
            switch (commandName)
            {
                case "ToShipped":
                    return "Received";
                case "ToCancel":
                    return "Cancelled";
                case "ToPlaced":
                    return "Order Placed";
                default:
                    return null;
            }
        }

        protected void btn_togo_my_order_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("ToShip.aspx");
        }

        protected void btn_to_ship_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("ToShip.aspx");
        }

        protected void btn_to_receive_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("ToReceive.aspx");
        }

        protected void btn_completed_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("Completed.aspx");
        }

        protected void btn_cancelled_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("Cancelled.aspx");
        }

        protected void btn_togo_profile_Click(object sender, EventArgs e)
        {
            // Redirect to User Profile page
            Response.Redirect("UserProfile.aspx");
        }
    }
}