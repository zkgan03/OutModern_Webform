using OutModern.src.Client.Products;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.ProductDetails
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string productId = Request.QueryString["productID"];
                if (!string.IsNullOrEmpty(productId))
                {
                    var product = GetProducts(productId);
                    if (product != null)
                    {
                        lblProdName.Text = product["productName"].ToString();
                        lblPrice.Text = "RM" + product["price"].ToString();
                        lblReviews.Text = " (" + product["totalReview"].ToString() + " Reviews)";
                        mainImage1.ImageUrl = product["productImageUrl1"].ToString();
                        mainImage2.ImageUrl = product["productImageUrl2"].ToString();
                        mainImage3.ImageUrl = product["productImageUrl3"].ToString();
                        Image1.ImageUrl = product["productImageUrl1"].ToString();
                        Image2.ImageUrl = product["productImageUrl2"].ToString();
                        Image3.ImageUrl = product["productImageUrl3"].ToString();

                    }
                    else
                    {
                        lblProdName.Text = "Product not found.";
                    }
                }

            }
        }

        private dynamic GetProducts(string productId)
        {
            var dummyData = GetDummyData();
            DataRow[] rows = dummyData.Select($"productID = '{productId}'");
            if (rows.Length > 0)
            {
                return rows[0];
            }
            else
            {
                return null;
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
            dummyData.Columns.Add("productCategory", typeof(string));
            // Add rows with dummy data
            dummyData.Rows.Add("P001", "Premium Hoodie", "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png",
                "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-zoomed-in-61167de6440a2.png", "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de644282.png",
                49.99, 100, 170,"Hoodie");
            dummyData.Rows.Add("P002", "Logo Hoodie", "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-60e7150a8381a.png",
                "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-60e7150a8364f.png", "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-2-60e7150a8377c.png",
                99.99, 120, 66,"Hoodie");
            dummyData.Rows.Add("P003", "Classic Hoodie", "~/images/product-img/hoodies/white-Hoodie/unisex-premium-hoodie-white-front-61167fab1babf.png",
               "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-60e7150a8364f.png", "~/images/product-img/hoodies/white-Hoodie/unisex-premium-hoodie-white-front-61167fab1b96e.png",
               188.88, 130, 20, "Hoodie");
            dummyData.Rows.Add("P004", "Classic Sweater", "~/images/product-img/sweater/white-sweater/mens-long-sleeve-shirt-white-front-60e812b79c7a6.png",
                "~/images/product-img/sweater/white-sweater/mens-long-sleeve-shirt-white-front-60e812b79d9ea.png", "~/images/product-img/sweater/white-sweater/mens-long-sleeve-shirt-white-front-60e812b79dd0f.png",
                69.99, 100, 170, "Sweater");
            dummyData.Rows.Add("P005", "Family Sweater", "~/images/product-img/sweater/white-sweater/unisex-fleece-sweatshirt-white-front-6117dbba91161.png",
                "~/images/product-img/sweater/white-sweater/unisex-fleece-sweatshirt-white-front-2-6117dbba913f6.png", "~/images/product-img/sweater/white-sweater/unisex-fleece-sweatshirt-white-front-2-6117dbba912b4.png",
                89.99, 120, 26, "Sweater");
            dummyData.Rows.Add("P006", "Logo Sweater", "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6f9d1.png",
               "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6fb89.png", "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6ef27.png",
               288.88, 130, 29, "Sweater");
            dummyData.Rows.Add("P007", "Special Sweater 1", "~/images/product-img/sweater/navy-Sweater/all-over-print-unisex-sweatshirt-white-left-front-6117db31d3cb6.png",
               "~/images/product-img/sweater/navy-Sweater/all-over-print-unisex-sweatshirt-white-front-6117db31d382e.png", "~/images/product-img/sweater/navy-Sweater/all-over-print-unisex-sweatshirt-white-back-6117db31d3a79.png",
               39.99, 100, 120, "Sweater");
            dummyData.Rows.Add("P008", "Special Sweater 2", "~/images/product-img/sweater/white-sweater/all-over-print-unisex-sweatshirt-white-right-front-6117db4cccf2d.png",
                "~/images/product-img/sweater/white-sweater/all-over-print-unisex-sweatshirt-white-right-front-6117db4ccd002.png", "~/images/product-img/sweater/white-Sweater/all-over-print-unisex-sweatshirt-white-back-6117db4ccce12.png",
                389.99, 120, 56, "Sweater");
            dummyData.Rows.Add("P009", "Classic T-Shirt", "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-60e814c22d7df.png",
               "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-2-60e814c22d433.png", "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-60e814c22d568.png",
               18.88, 130, 30, "Tee Shirt");
            dummyData.Rows.Add("P0010", "Logo T-Shirt", "~/images/product-img/teeShirt/white-Tee/mens-classic-t-shirt-white-front-6107e5efd1661.png",
               "~/images/product-img/teeShirt/white-Tee/mens-classic-t-shirt-white-front-6107e5efd17ce.png", "~/images/product-img/teeShirt/white-Tee/mens-classic-t-shirt-white-front-6107e5efd18c9.png",
               78.88, 130, 23, "Tee Shirt");
            dummyData.Rows.Add("P0011", "Pocket T-Shirt", "~/images/product-img/teeShirt/white-Tee/unisex-pocket-t-shirt-white-front-610c034560867.png",
               "~/images/product-img/teeShirt/white-Tee/unisex-pocket-t-shirt-white-front-610c034560b3f.png", "~/images/product-img/teeShirt/white-Tee/unisex-pocket-t-shirt-white-front-610c034560c0f.pngg",
               77.77, 130, 21, "Tee Shirt");
            dummyData.Rows.Add("P0012", "Classic Tee", "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-60e814c22d7df.png",
               "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-2-60e814c22d433.png", "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-60e814c22d568.png",
               66.66, 130, 22, "Tee Shirt");
            dummyData.Rows.Add("P013", "Logo Sweater", "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6f9d1.png",
               "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6fb89.png", "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6ef27.png",
               288.88, 130, 20,"Sweater");



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