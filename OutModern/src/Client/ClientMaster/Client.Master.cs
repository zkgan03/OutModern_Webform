using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.ClientMaster
{
    public partial class Client : System.Web.UI.MasterPage
    {
        protected string homeUrl = "~/src/Client/Home/Home.aspx";
        protected string aboutUrl = "#";
        protected string feedbackUrl = "#";
        protected string cartUrl = "#";

        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        private int customerId;

        protected void Page_Load(object sender, EventArgs e)
        {
            //For visibility of log out base on customer logged in or not
            //// Check for CustID cookie on every page load
            //HttpCookie custIDCookie = Request.Cookies["CustID"];
            //// Set HyperLink9 visibility based on cookie existence
            //HyperLink9.Visible = custIDCookie != null;
            //HyperLink5.Visible = custIDCookie != null;
            //HyperLink6.Visible = custIDCookie != null;


            //HyperLink7.Visible = custIDCookie == null;
            //HyperLink8.Visible = custIDCookie == null;

            if (!IsPostBack)
            {
                string currentUrl = Request.Url.PathAndQuery;

                if (currentUrl == homeUrl)
                {
                    hyperlinkHome.CssClass = hyperlinkHome.CssClass.Replace("top-nav-item", "top-nav-item-active");
                }
                else if (currentUrl == aboutUrl)
                {
                    hyperlinkAbout.CssClass = hyperlinkAbout.CssClass.Replace("top-nav-item", "top-nav-item-active");
                }


            }

            if (Session["CUSTID"] != null)
            {
                customerId = (int)Session["CUSTID"];
            }
            else
            {
                customerId = 0;
            }


            int cartItemCount = GetCartItemCount();
            numberLabel.Text = cartItemCount.ToString();


            Page.DataBind();
        }

        private int GetCartItemCount()
        {
            int count = 0;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM CartItem WHERE CartId = (SELECT CartId FROM Cart WHERE CustomerId = @CustomerId)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                con.Open();
                count = (int)cmd.ExecuteScalar();
            }

            return count;
        }

        protected void lBtnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void btnTest_Click(object sender, EventArgs e)
        {

        }

    }
}