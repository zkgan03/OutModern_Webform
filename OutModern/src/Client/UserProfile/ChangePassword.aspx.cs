using StringUtil;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.UserProfile
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_reset_password_Click(object sender, EventArgs e)
        {
            //Reset message
            lblMessage.Text = "";

            string conn = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            int custID = int.Parse(Request.Cookies["CustID"].Value);

            String newPassword = txt_new_password.Text;
            String retypePassword = txt_reenter_new_password.Text;
            if (newPassword == retypePassword)
            {
                try
                {
                    using (SqlConnection sqlConnection = new SqlConnection(conn))
                    {
                        sqlConnection.Open();

                        string updatePasswd = "UPDATE Customer SET CustomerPassword = @Password WHERE CustomerId = @CustId";

                        using (SqlCommand updateCommand = new SqlCommand(updatePasswd, sqlConnection))
                        {
                            String hashedPassword = PasswordUtil.HashPassword(newPassword);

                            updateCommand.Parameters.AddWithValue("@Password", hashedPassword);
                            updateCommand.Parameters.AddWithValue("@CustId", custID);

                            int rowsAffected = updateCommand.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                // Password updated successfully
                                lblMessage.Text = "Password updated successfully";
                                //for show pop up message in log in
                                Session["PasswordChanged"] = true;
                                Response.Redirect("UserProfile.aspx");
                            }
                            else
                            {
                                lblMessage.Text = "Failed to update password";
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "An error occurred: " + ex.Message;
                }
            }
            else
            {
                lblMessage.Text = "New Password and Re-enter New Password are not same";
            }

        }
    }
}