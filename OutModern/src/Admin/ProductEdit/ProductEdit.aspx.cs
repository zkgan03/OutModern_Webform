using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.ProductEdit
{
    public partial class ProductEdit : System.Web.UI.Page
    {
        protected static readonly string ProductDetails = "ProductDetails";
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { ProductDetails , "~/src/Admin/ProductDetails/ProductDetails.aspx" }
        };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.DataBind();
            }
        }

        protected void lbDiscard_Click(object sender, EventArgs e)
        {
            Response.Redirect(urls[ProductDetails] + "?id=" + Request.QueryString["id"]);
        }

        protected void lbUpdate_Click(object sender, EventArgs e)
        {
            //TODO : update logic into db
            Response.Redirect(urls[ProductDetails] + "?id=" + Request.QueryString["id"]);
        }
    }
}