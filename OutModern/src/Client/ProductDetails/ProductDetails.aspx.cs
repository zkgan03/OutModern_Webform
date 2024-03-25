using OutModern.src.Client.Products;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.NewFolder1
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Retrieve product ID from query string
                if (Request.QueryString["productId"] != null)
                {
                    int productId = Convert.ToInt32(Request.QueryString["productId"]);

                    
                }
            }
        }

        private DataTable GetDummyData()
        {
            DataTable dummyData = new DataTable();

            // Add columns to match your GridView's DataFields
            dummyData.Columns.Add("productID", typeof(string));
            dummyData.Columns.Add("productName", typeof(string));
            dummyData.Columns.Add("productImageUrl1", typeof(string));
            dummyData.Columns.Add("productImageUrl2", typeof(string));
            dummyData.Columns.Add("productImageUrl3", typeof(string));
            dummyData.Columns.Add("price", typeof(decimal));
            dummyData.Columns.Add("stockLevel", typeof(int));
            dummyData.Columns.Add("totalReview", typeof(int));
            // Add rows with dummy data
            dummyData.Rows.Add("P001", "Premium Hoodie", "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png",
                "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-zoomed-in-61167de6440a2.png", "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de644282.png",
                50.00, 100, 170);
            dummyData.Rows.Add("P002", "Logo Hoodie", "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-60e7150a8381a.png",
                "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-60e7150a8364f.png", "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-2-60e7150a8377c.png",
                99.99, 120, 66);
            dummyData.Rows.Add("P003", "Classic Hoodie", "~/images/product-img/hoodies/white-Hoodie/unisex-premium-hoodie-white-front-61167fab1babf.png",
               "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-60e7150a8364f.png", "~/images/product-img/hoodies/white-Hoodie/unisex-premium-hoodie-white-front-61167fab1b96e.png",
               188.88, 130, 20);

            // Add more rows as needed for testing
            return dummyData;
        }

        protected void radioColor_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton radioButton = (RadioButton) sender;
            string color = radioButton.Attributes["value"];
            lblColor.Text = color.ToString();
            lblColor.Visible = true;

        }
        protected void radioSize_CheckedChanged(object sender, EventArgs e)
        {
            RadioButton radioButton = (RadioButton)sender;
            string size = radioButton.Attributes["value"];
            lblSize.Text = size.ToString();
            lblSize.Visible = true;
        }
    }
}