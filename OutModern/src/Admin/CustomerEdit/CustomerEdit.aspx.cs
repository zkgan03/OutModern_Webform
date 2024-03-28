using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.CustomerEdit
{
    public partial class CustomerEdit : System.Web.UI.Page
    {
        protected static readonly string CustomerDetails = "CustomerDetails";

        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { CustomerDetails , "~/src/Admin/CustomerDetails/CustomerDetails.aspx" },
        };
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbUpdate_Click(object sender, EventArgs e)
        {
            Response.Redirect(urls[CustomerDetails] + "?id=" + "123");
        }

        protected void lbDiscard_Click(object sender, EventArgs e)
        {
            Response.Redirect(urls[CustomerDetails] + "?id=" + "123");
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            Response.Redirect(urls[CustomerDetails] + "?id=" + "123");
        }
    }
}