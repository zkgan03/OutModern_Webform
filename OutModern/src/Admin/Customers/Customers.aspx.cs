using OutModern.src.Admin.Staffs;
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

namespace OutModern.src.Admin.Customers
{
    public partial class Customers : System.Web.UI.Page
    {
        protected static readonly string CustomerDetails = "CustomerDetails";
        protected static readonly string CustomerEdit = "CustomerEdit";
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { CustomerDetails , "~/src/Admin/CustomerDetails/CustomerDetails.aspx" },
            { CustomerEdit, "~/src/Admin/CustomerEdit/CustomerEdit.aspx"}
        };

        private string ConnectionStirng = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lvCustomers.DataSource = getCustomers();
                lvCustomers.DataBind();
            }
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
        //DB operation
        //
        protected DataTable getCustomers(string sortExpression = null, string sortDirection = "ASC")
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                connection.Open();
                string sqlQuery =
                    "Select CustomerId, CustomerFullName, CustomerUsername, CustomerEmail, CustomerPhoneNumber, UserStatusName " +
                    "FROM Customer, UserStatus " +
                    "Where Customer.CustomerStatusId = UserStatus.UserStatusId ";

                if (!string.IsNullOrEmpty(sortExpression))
                {
                    sqlQuery += "ORDER BY " + sortExpression + " " + sortDirection;
                }

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }

        //
        //Page event
        //
        protected void lvCustomers_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType != ListViewItemType.DataItem) return;


            DataRowView rowView = (DataRowView)e.Item.DataItem;
            HtmlGenericControl statusSpan = (HtmlGenericControl)e.Item.FindControl("userStatus");
            string status = rowView["UserStatusName"].ToString();

            switch (status)
            {
                case "Activated":
                    statusSpan.Attributes["class"] += " activated";
                    break;
                case "Locked":
                    statusSpan.Attributes["class"] += " locked";
                    break;
                case "Deleted":
                    statusSpan.Attributes["class"] += " deleted";
                    break;
                default:
                    // Handle cases where status doesn't match any of the above
                    break;
            }
        }

        protected void lvCustomers_PagePropertiesChanged(object sender, EventArgs e)
        {
            string sortExpression = ViewState["SortExpression"]?.ToString();
            lvCustomers.DataSource = sortExpression == null ?
                getCustomers() :
                getCustomers(sortExpression, SortDirections[sortExpression]);
            lvCustomers.DataBind();
        }

        protected void lvCustomers_Sorting(object sender, ListViewSortEventArgs e)
        {
            toggleSortDirection(e.SortExpression); // Toggle sorting direction for the clicked column

            ViewState["SortExpression"] = e.SortExpression; // used for retain the sorting

            // Re-bind the ListView with sorted data
            lvCustomers.DataSource = getCustomers(e.SortExpression, SortDirections[e.SortExpression]);
            lvCustomers.DataBind();
        }
    }
}