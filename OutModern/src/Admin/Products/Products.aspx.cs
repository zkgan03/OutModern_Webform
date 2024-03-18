using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.Products
{
    public partial class Products : System.Web.UI.Page
    {

        protected static readonly string ProductAdd = "ProductAdd";
        protected static readonly string ProductDetails = "ProductDetails";


        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { ProductAdd , "~/src/Admin/ProductAdd/ProductAdd.aspx" },
            { ProductDetails , "~/src/Admin/ProductDetails/ProductDetails.aspx" },
        };
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.DataBind();
        }
    }
}