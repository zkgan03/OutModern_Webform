using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Net;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.ProductDetails
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected static readonly string ProductEdit = "ProductEdit";
        protected static readonly string ProductReviewReply = "ProductReviewReply";

        private string ConnectionStirng = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { ProductEdit , "~/src/Admin/ProductEdit/ProductEdit.aspx" },
            { ProductReviewReply , "~/src/Admin/ProductReviewReply/ProductReviewReply.aspx" }

        };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string productId = Request.QueryString["ProductId"];
                if (productId == null)
                {
                    Response.StatusCode = 404;
                    return;
                }

                loadProductDetails(productId);

                lvReviews.DataSource = GetReviewList();
                lvReviews.DataBind();

                Page.DataBind();
            }
            repeaterColors.DataSource = GetColor();
            repeaterColors.DataBind();

            repeaterImg.DataSource = GetBeigeImg();
            repeaterImg.DataBind();
        }

        private void loadProductDetails(string productId)
        {
            //Select the productInfo
            //Select ProductId, ProductCategory, UnitPrice, ProductStatusName
            //FROM Product
            //Join ProductStatus on Product.ProductStatusId = ProductStatus.ProductStatusId
            //WHERE ProductId = 1;

            //Select Quantity Based on size and color
            //Select quantity
            //FROM Product
            //Join ProductDetail on Product.ProductId = ProductDetail.ProductId
            //Join ProductStatus on Product.ProductStatusId = ProductStatus.ProductStatusId
            //WHERE SizeId = 1 and ColorId = 1 and Product.ProductId = 1;
        }

        private DataTable GetReviewList()
        {
            DataTable reviewDataTable = new DataTable();
            reviewDataTable.Columns.Add("CustomerName", typeof(string));
            reviewDataTable.Columns.Add("ReviewTime", typeof(string));
            reviewDataTable.Columns.Add("ReviewRating", typeof(double));
            reviewDataTable.Columns.Add("ReviewColor", typeof(string));
            reviewDataTable.Columns.Add("ReviewQuantity", typeof(int));
            reviewDataTable.Columns.Add("ReviewText", typeof(string));
            reviewDataTable.Columns.Add("Replies", typeof(DataTable));

            // Add rows to the DataTable
            reviewDataTable.Rows.Add("Customer A", DateTime.Now.ToString("yyyy-MM-dd HH:mm"), 3.0, "white", 1, "This has problems!", GenerateDummyRepliesData());
            reviewDataTable.Rows.Add("Customer B", DateTime.Now.ToString("yyyy-MM-dd HH:mm"), 4.0, "black", 3, "This is amazing!", GenerateDummyRepliesData());
            reviewDataTable.Rows.Add("Customer C", DateTime.Now.ToString("yyyy-MM-dd HH:mm"), 3.0, "white", 1, "This is review 3", GenerateDummyRepliesData());
            reviewDataTable.Rows.Add("Customer D", DateTime.Now.ToString("yyyy-MM-dd HH:mm"), 4.0, "black", 3, "Test Review", GenerateDummyRepliesData());



            return reviewDataTable;
        }

        private DataTable GenerateDummyRepliesData()
        {
            // Create a new DataTable to hold the dummy data
            DataTable dataTable = new DataTable();

            // Add columns to the DataTable
            dataTable.Columns.Add("AdminName", typeof(string));
            dataTable.Columns.Add("AdminRole", typeof(string));
            dataTable.Columns.Add("ReplyTime", typeof(DateTime));
            dataTable.Columns.Add("ReplyText", typeof(string));

            // Add some dummy data rows to the DataTable
            dataTable.Rows.Add("John Doe", "Admin", DateTime.Now.AddDays(-1), "Lorem ipsum dolor sit amet, consectetur adipiscing elit.");
            dataTable.Rows.Add("Jane Smith", "Moderator", DateTime.Now.AddDays(-2), "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.");
            dataTable.Rows.Add("Alice Johnson", "User", DateTime.Now.AddDays(-3), "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.");

            return dataTable;
        }

        private DataTable GetBeigeImg()
        {
            DataTable beigeImgDataTable = new DataTable();
            beigeImgDataTable.Columns.Add("ImageId", typeof(string));
            beigeImgDataTable.Columns.Add("path", typeof(string));

            // Add rows to the DataTable
            beigeImgDataTable.Rows.Add("123", "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png");
            beigeImgDataTable.Rows.Add("123", "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de644282.png");
            beigeImgDataTable.Rows.Add("123", "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-zoomed-in-61167de6440a2.png");

            return beigeImgDataTable;
        }

        private DataTable GetBlackImg()
        {
            DataTable blackImgDataTable = new DataTable();
            blackImgDataTable.Columns.Add("ImageId", typeof(string));
            blackImgDataTable.Columns.Add("path", typeof(string));

            // Add rows to the DataTable
            blackImgDataTable.Rows.Add("123", "~/images/product-img/hoodies/black-Hoodie/all-over-print-unisex-hoodie-white-front-611679bab7dfd.png");
            blackImgDataTable.Rows.Add("123", "~/images/product-img/hoodies/black-Hoodie/all-over-print-unisex-hoodie-white-front-611679bab7dfd.png");
            blackImgDataTable.Rows.Add("123", "~/images/product-img/hoodies/black-Hoodie/all-over-print-unisex-hoodie-white-front-611679bab7dfd.png");

            return blackImgDataTable;
        }

        private DataTable GetColor()
        {
            DataTable colorDataTable = new DataTable();
            colorDataTable.Columns.Add("Color", typeof(string));

            // Add rows to the DataTable
            colorDataTable.Rows.Add("Beige");
            colorDataTable.Rows.Add("White");
            colorDataTable.Rows.Add("Black");

            return colorDataTable;
        }

        protected void lvReviews_PagePropertiesChanged(object sender, EventArgs e)
        {
            bindData();
        }

        private void bindData()
        {
            lvReviews.DataSource = GetReviewList();
            lvReviews.DataBind();

            repeaterColors.DataSource = GetColor();
            repeaterColors.DataBind();

            repeaterImg.DataSource = GetBeigeImg();
            repeaterImg.DataBind();
        }

        protected void repeaterColors_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ChangeColor")
            {
                // Remove active class
                foreach (RepeaterItem item in repeaterColors.Items)
                {
                    var button = item.FindControl("btnColor") as Button; // Replace with your button ID
                    if (button != null)
                    {
                        button.CssClass = button.CssClass.Replace(" active", ""); // Remove "active"
                    }
                }

                Button btn = (Button)e.CommandSource;
                btn.CssClass += " active";

                if (e.CommandArgument.ToString() == "Black")
                {
                    repeaterImg.DataSource = GetBlackImg();
                }
                else if (e.CommandArgument.ToString() == "Beige")
                {
                    repeaterImg.DataSource = GetBeigeImg();

                }
            }
            repeaterImg.DataBind();

        }



        protected void repeaterColors_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
        }

        protected void ddlSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblQuantity.Text = "222";
        }
    }
}

