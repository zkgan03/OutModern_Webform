using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.ProductAdd
{
    public partial class ProductAdd : System.Web.UI.Page
    {
        protected static readonly string ProductDetails = "ProductDetails";
        protected static readonly string Products = "Products";

        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { ProductDetails , "~/src/Admin/ProductDetails/ProductDetails.aspx" },
            { Products , "~/src/Admin/Products/Products.aspx" }

        };
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void lbDiscard_Click(object sender, EventArgs e)
        {
            Response.Redirect(urls[Products]);
        }

        protected void lbAdd_Click(object sender, EventArgs e)
        {
            var id = lblProdId.Text;
            //TODO : Add logic into db
            Response.Redirect(urls[ProductDetails] + "?id=" + id);
        }
    }
}