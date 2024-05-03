using OutModern.src.Admin.Orders;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.UserProfile
{
    public partial class Comment : System.Web.UI.Page
    {
        private string ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        private string productDetailId;
        protected void Page_Load(object sender, EventArgs e)
        {
            productDetailId = Request.QueryString["ProductDetailId"];
            if (productDetailId == null)
            {
                Response.Redirect("~/src/ErrorPages/404.aspx");
            }
            if (!IsPostBack)
            {

            }
        }
    }
}