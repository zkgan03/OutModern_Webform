using System;
using System.Collections.Generic;
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

        protected void Page_Load(object sender, EventArgs e)
        {
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

            Page.DataBind();
        }

        protected void lBtnSearch_Click(object sender, EventArgs e)
        {

        }

        protected void btnTest_Click(object sender, EventArgs e)
        {

        }
    }
}