using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OutModern.src.Admin.Interfaces;

namespace OutModern.src.Admin.AdminMaster
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected static readonly string Dashboard = "Dashboard";
        protected static readonly string Staffs = "Staffs";
        protected static readonly string Products = "Products";
        protected static readonly string Orders = "Orders";
        protected static readonly string Customers = "Customers";
        protected static readonly string PromoCode = "PromoCode";
        protected static readonly string Setting = "Setting";

        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { Dashboard , "~/src/Admin/Dashboard/Dashboard.aspx" },
            { Staffs , "~/src/Admin/Staffs/Staffs.aspx" },
            { Products , "~/src/Admin/Products/Products.aspx" },
            { Orders , "~/src/Admin/Orders/Orders.aspx" },
            { Customers , "~/src/Admin/Customers/Customers.aspx" },
            { PromoCode , "~/src/Admin/PromoCode/PromoCode.aspx" },
            { Setting , "~/src/Admin/Setting/Setting.aspx" },
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                setMenuActive();
                Page.DataBind(); // data bind
            }
        }

        private void setMenuActive()
        {
            // set which item in side bar to be lighten up
            string currentPath = Path.GetFileName(Request.Url.GetLeftPart(UriPartial.Path));
            string pageName = currentPath.Split('.')[0]; //get only page name without extension

            foreach (var item in urls)
            {
                if (item.Key == pageName)
                {
                    // Get the hyperlink control by ID dynamically using FindControl method
                    HyperLink hyperlink = FindControl("hyperlink" + item.Key) as HyperLink;
                    if (hyperlink != null)
                    {
                        hyperlink.CssClass = hyperlink.CssClass + " active";
                        break; // Exit loop once active hyperlink is found
                    }
                }
            }
        }

        protected void lBtnSearch_Click(object sender, EventArgs e)
        {
            var searchTerm = txtSearch.Text;
            var currentContent = Page as IFilter;

            if (currentContent != null)
            {
                currentContent.FilterListView(searchTerm);
            }
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            lblServerTime.Text = DateTime.Now.ToString();
        }

        // add query string to the sitemap url dynamically
        protected void sitemapAdmin_ItemDataBound(object sender, SiteMapNodeItemEventArgs e)
        {
            // Check if the current node is a SiteMapNode
            if (e.Item.ItemType == SiteMapNodeItemType.PathSeparator ||
                e.Item.ItemType == SiteMapNodeItemType.Current)
            {
                return;
            }

            // Retrieve the current page's query string
            string currentPageQueryString = HttpContext.Current.Request.QueryString.ToString();

            // If the current page has a query string
            if (!string.IsNullOrEmpty(currentPageQueryString))
            {
                // Generate the dynamic query string for the next page
                string dynamicQueryString = currentPageQueryString;

                // Find the hyperlink control in the current item and modify its NavigateUrl
                HyperLink link = (HyperLink)e.Item.Controls[0]; // Assuming the hyperlink control is the first control in the item
                link.NavigateUrl += "?" + dynamicQueryString;
            }
        }
    }
}