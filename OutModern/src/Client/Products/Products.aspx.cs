using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Products
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProductRepeater.DataSource = GetDummyData();
                ProductRepeater.DataBind();
                lblTotalProducts.Text = ProductRepeater.Items.Count.ToString() + " Products Found"; 

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
                49.99, 100,170);
            dummyData.Rows.Add("P002", "Logo Hoodie", "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-60e7150a8381a.png",
                "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-60e7150a8364f.png", "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-2-60e7150a8377c.png",
                99.99, 120,66);
            dummyData.Rows.Add("P003", "Classic Hoodie", "~/images/product-img/hoodies/white-Hoodie/unisex-premium-hoodie-white-front-61167fab1babf.png",
               "~/images/product-img/hoodies/white-Hoodie/unisex-essential-eco-hoodie-white-front-60e7150a8364f.png", "~/images/product-img/hoodies/white-Hoodie/unisex-premium-hoodie-white-front-61167fab1b96e.png",
               188.88, 130,20);
            dummyData.Rows.Add("P004", "Classic Sweater", "~/images/product-img/sweater/white-sweater/mens-long-sleeve-shirt-white-front-60e812b79c7a6.png",
                "~/images/product-img/sweater/white-sweater/mens-long-sleeve-shirt-white-front-60e812b79d9ea.png", "~/images/product-img/sweater/white-sweater/mens-long-sleeve-shirt-white-front-60e812b79dd0f.png",
                69.99, 100, 170);
            dummyData.Rows.Add("P005", "Family Sweater", "~/images/product-img/sweater/white-sweater/unisex-fleece-sweatshirt-white-front-6117dbba91161.png",
                "~/images/product-img/sweater/white-sweater/unisex-fleece-sweatshirt-white-front-2-6117dbba913f6.png", "~/images/product-img/sweater/white-sweater/unisex-fleece-sweatshirt-white-front-2-6117dbba912b4.png",
                89.99, 120, 66);
            dummyData.Rows.Add("P006", "Logo Sweater", "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6f9d1.png",
               "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6fb89.png", "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6ef27.png",
               288.88, 130, 20);
            dummyData.Rows.Add("P008", "Special Sweater 2", "~/images/product-img/sweater/white-sweater/all-over-print-unisex-sweatshirt-white-right-front-6117db4cccf2d.png",
                "~/images/product-img/sweater/white-sweater/all-over-print-unisex-sweatshirt-white-right-front-6117db4ccd002.png", "~/images/product-img/sweater/white-Sweater/all-over-print-unisex-sweatshirt-white-back-6117db4ccce12.png",
                389.99, 120, 56);
            dummyData.Rows.Add("P009", "Classic T-Shirt", "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-60e814c22d7df.png",
               "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-2-60e814c22d433.png", "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-60e814c22d568.png",
               18.88, 130, 30);
            dummyData.Rows.Add("P0010", "Logo T-Shirt", "~/images/product-img/teeShirt/white-Tee/mens-classic-t-shirt-white-front-6107e5efd1661.png",
               "~/images/product-img/teeShirt/white-Tee/mens-classic-t-shirt-white-front-6107e5efd17ce.png", "~/images/product-img/teeShirt/white-Tee/mens-classic-t-shirt-white-front-6107e5efd18c9.png",
               78.88, 130, 23);
            dummyData.Rows.Add("P0011", "Pocket T-Shirt", "~/images/product-img/teeShirt/white-Tee/unisex-pocket-t-shirt-white-front-610c034560867.png",
               "~/images/product-img/teeShirt/white-Tee/unisex-pocket-t-shirt-white-front-610c034560b3f.png", "~/images/product-img/teeShirt/white-Tee/unisex-pocket-t-shirt-white-front-610c034560c0f.pngg",
               77.77, 130, 21);
            dummyData.Rows.Add("P0012", "Classic Tee", "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-60e814c22d7df.png",
               "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-2-60e814c22d433.png", "~/images/product-img/teeShirt/white-Tee/adult-quality-tee-white-front-60e814c22d568.png",
               66.66, 130, 22);
            dummyData.Rows.Add("P013", "Logo Sweater", "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6f9d1.png",
               "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6fb89.png", "~/images/product-img/sweater/white-sweater/unisex-crew-neck-sweatshirt-white-front-60e80cba6ef27.png",
               288.88, 130, 20);

            // Add more rows as needed for testing
            return dummyData;
        }



    }
}