using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Home
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.Cookies["AuthToken"] != null)
            {
                // Automatically log in the user using the authentication token
                // Here, you might retrieve user details based on the token and set the session accordingly
                Session["LoggedIn"] = true;
            }

            // Check if user is not logged in
            if (Session["LoggedIn"] == null || !(bool)Session["LoggedIn"])
            {
                // Redirect to Login.aspx
                Response.Redirect("~/src/Client/Login/Login.aspx");
            }
        }
    }
}