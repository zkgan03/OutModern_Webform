using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Login
{
    public partial class SignUp1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_sign_up_Click(object sender, EventArgs e)
        {
            // Redirect to Login page
            Response.Redirect("Login.aspx");
        }
    }
}