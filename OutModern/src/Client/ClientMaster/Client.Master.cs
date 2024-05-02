using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.ClientMaster
{
    public partial class Client : System.Web.UI.MasterPage
    {
        protected string homeUrl = "~/src/Client/Home/Home.aspx";
        protected string aboutUrl = "#";
        protected string feedbackUrl = "#";
        protected string cartUrl = "#";
        int customerId = 1;
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string currentUrl = Request.Url.PathAndQuery;

                if (currentUrl == homeUrl)
                {
                    hyperlinkHome.CssClass = hyperlinkHome.CssClass.Replace("top-nav-item", "top-nav-item-active");
                }
                else if (currentUrl == aboutUrl)
                {
                    hyperlinkAbout.CssClass = hyperlinkAbout.CssClass.Replace("top-nav-item", "top-nav-item-active");
                }
            }

            Page.DataBind();
        }

        protected void lBtnSearch_Click(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Text.Trim();
            if (DetectSQLInjection(searchQuery) || DetectXSS(searchQuery) )
            {
                LockUserAccount(); // if detected update user status to "Locked" and clear the login session
                return;
            }
            // Construct the URL with the search query as a query string parameter
            string redirectUrl = $"~/src/Client/Products/Products.aspx?search={searchQuery}";

            // Redirect to the Products page with the search query
            Response.Redirect(redirectUrl, false);

        }

        private void LockUserAccount()
        {
            // Define the update query
            string updateQuery = "UPDATE Customer SET CustomerStatusId = 2 WHERE CustomerId = @customerId;";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(updateQuery, connection))
                {
                    command.Parameters.AddWithValue("@customerId", customerId);
                    connection.Open();
                    int rowsAffected = command.ExecuteNonQuery();
                    if (rowsAffected > 0) // Customer status updated successfully
                    {
                        HttpContext.Current.Session.Clear(); // Remove session and redirect to home page
                        HttpContext.Current.Session.Abandon();
                        HttpContext.Current.Response.Redirect("~/src/Client/Home/Home.aspx", true);                 
                    }
                }
            }
        }

        private bool DetectSQLInjection(string input)
        {
            // List of suspicious SQL keywords
            string[] sqlKeywords = { "SELECT", "INSERT", "UPDATE", "DELETE", "DROP", "ALTER", "TRUNCATE" };

            // Check if the input contains any of the suspicious SQL keywords
            foreach (string keyword in sqlKeywords)
            {
                if (input.IndexOf(keyword, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    // SQL injection attempt detected
                    return true;
                }
            }

            // No suspicious SQL keywords found
            return false;
        }

        private bool DetectXSS(string input)
        {
            // List of suspicious HTML tags and attributes
            string[] htmlTags = { "<script>", "<iframe>", "<object>", "onload=", "onerror=" };

            // Check if the input contains any of the suspicious HTML tags or attributes
            foreach (string tag in htmlTags)
            {
                if (input.IndexOf(tag, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    // XSS attempt detected
                    return true;
                }
            }

            // No suspicious HTML tags or attributes found
            return false;
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {

        }

    }
}