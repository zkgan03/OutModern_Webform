using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.ProductDetails
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected static readonly string ProductEdit = "ProductEdit";


        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { ProductEdit , "~/src/Admin/ProductEdit/ProductEdit.aspx" },
        };
        protected void Page_Load(object sender, EventArgs e)
        {
            Page.DataBind();
        }
    }
}