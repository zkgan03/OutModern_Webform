using System;
using System.Collections.Generic;
using System.Data;
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

        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { CustomerDetails , "~/src/Admin/CustomerDetails/CustomerDetails.aspx" },
            { CustomerEdit, "~/src/Admin/CustomerEdit/CustomerEdit.aspx"}
        };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lvCustomers.DataSource = GetCustomers();
                lvCustomers.DataBind();
            }
        }

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
            lvCustomers.DataSource = GetCustomers();
            lvCustomers.DataBind();
        }

        //Dummy data
        protected DataTable GetCustomers()
        {
            DataTable dtCustomers = new DataTable();
            dtCustomers.Columns.AddRange(new DataColumn[] {
                new DataColumn("CustomerId", typeof(int)),
                new DataColumn("CustomerName", typeof(string)),
                new DataColumn("CustomerUsername", typeof(string)),
                new DataColumn("CustomerEmail", typeof(string)),
                new DataColumn("CustomerPhoneNumber", typeof(string)),
                new DataColumn("UserStatusName", typeof(string))
              });

            // Generate 10 dummy customers with random statuses
            string[] statuses = { "Activated", "Deleted", "Locked" };
            Random random = new Random();

            for (int i = 0; i < 10; i++)
            {
                DataRow drCustomer = dtCustomers.NewRow();
                drCustomer["CustomerId"] = i + 1; // Assuming CustomerId starts from 1
                drCustomer["CustomerName"] = $"Customer {i + 1}";
                drCustomer["CustomerUsername"] = $"username{i + 1}";
                drCustomer["CustomerEmail"] = $"customer{i + 1}@example.com";
                drCustomer["CustomerPhoneNumber"] = $"0123-456-78{i}";
                drCustomer["UserStatusName"] = statuses[random.Next(statuses.Length)];

                dtCustomers.Rows.Add(drCustomer);
            }

            return dtCustomers;
        }
    }
}