using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Profile
{
    public partial class UserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_edit_profile_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("EditUserProfile.aspx");
        }

        protected void btn_togo_my_order_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("ToShip.aspx");
        }

        protected void btn_togo_profile_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("UserProfile.aspx");
        }

        protected void btn_dlt_acc_Click(object sender, EventArgs e)
        {
            // Get CustID from the cookie
            int custID = int.Parse(Request.Cookies["CustID"].Value);

            // Connection string
            //string connectionString = "ConnectionString";

            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                // Update customer status to 3 (deleted)
                string updateSql = "UPDATE Customer SET CustomerStatusId = (SELECT UserStatusId FROM UserStatus WHERE UserStatusName = 'Deleted') WHERE CustomerId = @CustID";
                SqlCommand updateCommand = new SqlCommand(updateSql, conn);
                updateCommand.Parameters.AddWithValue("@CustID", custID);

                conn.Open();
                updateCommand.ExecuteNonQuery();
                conn.Close();
            }

            // Invalidate any existing session cookies
            Session.Abandon();

            // Redirect to login page
            Response.Redirect("~/src/Client/Login/Login.aspx");
        }
    }
}