using StringUtil;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Login
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Delete specific cookies on login page load
            string[] cookieNamesToDelete = new string[] { "LoggedIn", "AdmID", "AdmStatus" };

            foreach (string cookieName in cookieNamesToDelete)
            {
                HttpCookie cookieToDelete = Request.Cookies[cookieName];
                if (cookieToDelete != null)
                {
                    cookieToDelete.Expires = DateTime.Now.AddDays(-1); // Set expiration to past date
                    Response.Cookies.Add(cookieToDelete); // Re-add cookie with expired date
                }
            }
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            string err = "";
            string email = txt_email.Text;
            string passwd = txt_password.Text;

            if (email == null || passwd == null || email == "" || passwd == null)
            {
                err = "Email and Password cannot be left empty.";
            }
            else
            {
                //email validation
                if (!IsValidEmail(email))
                {
                    err = "Invalid Email Format.";
                }

                if (err == "")
                {
                    try
                    {

                        using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                        {
                            conn.Open();
                            //use parameterized query to prevent sql injection
                            string query = "SELECT * FROM [Admin] WHERE AdminEmail = @email";
                            SqlCommand cmd = new SqlCommand(query, conn);
                            cmd.Parameters.AddWithValue("@email", email);
                            SqlDataReader reader = cmd.ExecuteReader();
                            if (!reader.HasRows)
                            {
                                err = "Invalid email or password.";

                            }
                            else
                            {
                                //get password from reader
                                reader.Read();
                                string hashedPassword = reader["AdminPassword"].ToString();
                                int adminID = (int)reader["AdminId"];
                                int adminStatus = (int)reader["AdminStatusId"];

                                //compare password
                                //if (!PasswordUtil.VerifyPassword(passwd, hashedPassword))  //if have hash password then use this
                                if(passwd != hashedPassword)    //not hash password(in database) use this
                                {
                                    err = "Invalid email or password.";

                                }
                                else
                                {
                                    //not activated customer cannot log in
                                    if (adminStatus != 1)
                                    {
                                        err = "Admin is not activated";
                                    }
                                    else
                                    {
                                        HttpCookie loggedInCookie = new HttpCookie("LoggedIn", "true");
                                        loggedInCookie.Expires = DateTime.Now.AddDays(30); // Set cookie expiration
                                        Response.Cookies.Add(loggedInCookie);

                                        HttpCookie admIDCookie = new HttpCookie("AdmID", adminID.ToString());
                                        admIDCookie.Expires = DateTime.Now.AddDays(30);
                                        Response.Cookies.Add(admIDCookie);

                                        HttpCookie adminStatusCookie = new HttpCookie("AdmStatus", adminStatus.ToString());
                                        adminStatusCookie.Expires = DateTime.Now.AddDays(30);
                                        Response.Cookies.Add(adminStatusCookie);

                                        Response.Redirect("~/src/Admin/Dashboard/Dashboard.aspx");
                                    }
                                }
                                conn.Close();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        err = "An error occurred during login. Please try again.";
                        Response.Write(ex.Message);
                    }
                }
            }
            ErrMsg.Text = err;

        }

        protected bool IsValidEmail(string email)
        {
            var trimmedEmail = email.Trim();

            if (trimmedEmail.EndsWith("."))
            {
                return false;
            }
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == trimmedEmail;
            }
            catch
            {
                return false;
            }
        }
    }
}