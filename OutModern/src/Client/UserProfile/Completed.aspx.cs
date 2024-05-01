using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.UserProfile
{
    public partial class Completed : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btn_togo_my_order_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("ToShip.aspx");
        }

        protected void btn_to_ship_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("ToShip.aspx");
        }

        protected void btn_to_receive_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("ToReceive.aspx");
        }

        protected void btn_completed_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("Completed.aspx");
        }

        protected void btn_cancelled_Click(object sender, EventArgs e)
        {
            // Redirect to Edit User Profile page
            Response.Redirect("Cancelled.aspx");
        }

        protected void btn_togo_profile_Click(object sender, EventArgs e)
        {
            // Redirect to User Profile page
            Response.Redirect("UserProfile.aspx");
        }

        protected void btnComment_Click(object sender, EventArgs e)
        {
            string productDetailId = "1"; // Replace "123" with the actual ProductDetailId value

            // Construct the URL with the query string parameter
            string url = $"~/src/Client/Comment/Comment.aspx?ProductDetailId={productDetailId}";

            Response.Redirect(url);
        }
    }
}