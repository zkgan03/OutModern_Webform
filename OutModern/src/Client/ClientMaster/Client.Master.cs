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
            string searchQuery = txtSearch.Text.Trim();
            if (DetectSQLInjection(searchQuery))
            {
            }

            if (DetectXSS(searchQuery))
            {
            }

            Session["SearchQuery"] = searchQuery;  // Pass the search query to content pages
            Response.Redirect("~/src/Client/Products/Products.aspx");
        }

        private bool DetectSQLInjection(string input)
        {
            // List of suspicious SQL keywords
            string[] sqlKeywords = { "SELECT", "INSERT", "UPDATE", "DELETE", "DROP", "ALTER", "TRUNCATE" };

            // Check if the input contains any of the suspicious SQL keywords
            foreach (string keyword in sqlKeywords)
            {
                if (input.IndexOf(keyword, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    // SQL injection attempt detected
                    return true;
                }
            }

            // No suspicious SQL keywords found
            return false;
        }

        private bool DetectXSS(string input)
        {
            // List of suspicious HTML tags and attributes
            string[] htmlTags = { "<script>", "<iframe>", "<object>", "onload=", "onerror=" };

            // Check if the input contains any of the suspicious HTML tags or attributes
            foreach (string tag in htmlTags)
            {
                if (input.IndexOf(tag, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    // XSS attempt detected
                    return true;
                }
            }

            // No suspicious HTML tags or attributes found
            return false;
        }

        protected void btnTest_Click(object sender, EventArgs e)
        {

        }

    }
}