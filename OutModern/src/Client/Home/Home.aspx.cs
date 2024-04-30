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
            if (Request.Cookies["LoggedIn"] != null)
            {
                bool loggedIn = bool.Parse(Request.Cookies["LoggedIn"].Value);
                int custID = int.Parse(Request.Cookies["CustID"].Value);
                int custStatus = int.Parse(Request.Cookies["CustStatus"].Value);

                if (loggedIn && custStatus == 1) // Check for active customer
                {
                    Session["LoggedIn"] = loggedIn;
                    Session["CustID"] = custID;
                    Session["CustStatus"] = custStatus;

                    //pop out message show CustID and CustStatus
                    lblCustInfo.Text = $"Hi {custID}!";
                    lblCustInfo.Visible = true;
                }
                else
                {
                    // Clear cookies if login failed or customer inactive
                    Response.Cookies["LoggedIn"].Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies["CustID"].Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies["CustStatus"].Expires = DateTime.Now.AddDays(-1);

                    Response.Redirect("~/src/Client/Login/Login.aspx");
                }
            }
        }
    }
}