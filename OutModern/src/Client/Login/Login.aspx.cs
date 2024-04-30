using StringUtil;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Login
{
    public partial class Login2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //// Check if the authentication token exists in the cookie
            //if (!IsPostBack && Request.Cookies["KeepMeLogIn"] != null)
            //{
            //    // Automatically log in the user using the authentication token
            //    // Here, you might retrieve user details based on the token and set the session accordingly
            //    Session["LoggedIn"] = true;
            //    // Redirect the user to the home page or any other authenticated page
            //    Response.Redirect("~/src/Client/Home/Home.aspx");
            //}
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
                            string query = "SELECT * FROM [Customer] WHERE CustomerEmail = @email";
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
                                string hashedPassword = reader["CustomerPassword"].ToString();
                                //compare password
                                if (!PasswordUtil.VerifyPassword(passwd, hashedPassword))
                                {
                                    err = "Invalid email or password.";

                                }
                                else
                                {
                                    Session["LoggedIn"] = true;
                                    Session["email"] = email;


                                    Response.Redirect("~/src/Client/Home/Home.aspx");
                                }
                            }
                            conn.Close();
                        }
                    }
                    catch (Exception ex)
                    {
                        //Err
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