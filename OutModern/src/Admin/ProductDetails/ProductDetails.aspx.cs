using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
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

        private string ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected string productId;


        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { ProductEdit , "~/src/Admin/ProductEdit/ProductEdit.aspx" },
            { ProductReviewReply , "~/src/Admin/ProductReviewReply/ProductReviewReply.aspx" }

        };
        protected void Page_Load(object sender, EventArgs e)
        {
            productId = Request.QueryString["ProductId"];
            if (productId == null)
            {
                Response.Redirect("~/src/ErrorPages/404.aspx");
            }

            if (!IsPostBack)
            {
                initProductInfo();

                // bind ddl of size
                ddlSize.DataSource = getSizes();
                ddlSize.DataValueField = "sizeId";
                ddlSize.DataTextField = "sizeName";
                ddlSize.DataBind();

                // bind repeater for color
                repeaterColors.DataSource = getColors();
                repeaterColors.DataBind();

                // int initQuantity
                setQuantity();

                // init images
                repeaterImg.DataSource = ViewState["ColorId"] != null ?
                    getImages(ViewState["ColorId"].ToString()) :
                    new DataTable();
                repeaterImg.DataBind();

                //init reviews
                lvReviews.DataSource = getReviewList();
                lvReviews.DataBind();

                Page.DataBind();
            }


        }

        private void initProductInfo()
        {
            DataTable productData = getProductInfo();
            if (productData.Rows.Count == 0)
            {
                Response.Redirect("~/src/ErrorPages/404.aspx");
            }
            DataRow data = productData.Rows[0];

            lblProductId.Text = data["ProductId"].ToString();
            lblTitleProductName.Text = data["ProductName"].ToString();
            lblCategory.Text = data["ProductCategory"].ToString();
            lblPrice.Text = data["UnitPrice"].ToString();
            lblStatus.Text = data["ProductStatusName"].ToString();
            lblProductDesription.Text = data["ProductDescription"].ToString();
        }

        // Get the products info
        private DataTable getProductInfo()
        {
            DataTable data = new DataTable();
            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();

                string sqlQuery =
                    "Select ProductId, ProductName,ProductDescription, ProductCategory, UnitPrice, ProductStatusName " +
                    "FROM Product " +
                    "Join ProductStatus on Product.ProductStatusId = ProductStatus.ProductStatusId " +
                    "WHERE ProductId = @productId;";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@productId", productId);
                    data.Load(command.ExecuteReader());
                }
            }
            return data;
        }

        // return all Sized available for the specific product
        private DataTable getSizes()
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();

                string sqlQuery =
                    "Select Distinct s.sizeId, s.sizeName " +
                    "From Product p, ProductDetail pd, Size s " +
                    "Where p.ProductId = @productId AND pd.productId = p.productId AND s.sizeId = pd.sizeId";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@productId", productId);

                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }

        // return all colors available
        private DataTable getColors()
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();

                string sqlQuery =
                    "Select distinct pd.ColorId, c.HexColor color " +
                    "From Product p, Color c, ProductDetail pd " +
                    "Where p.ProductId = @productId AND pd.ColorId = c.ColorId " +
                    "AND p.ProductId = pd.ProductId AND isDeleted = 0";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@productId", productId);

                    data.Load(command.ExecuteReader());
                }
            }

            if (ViewState["ColorId"] == null && data.Rows.Count > 0)
            {
                ViewState["ColorId"] = data.Rows[0]["ColorId"].ToString();
            }

            return data;
        }

        //get Quantity based on color and size (return 0 if color not available)
        private int getQuantity(string sizeId, string colorId)
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();

                string sqlQuery =
                    "select quantity " +
                    "From ProductDetail " +
                    "Where ProductId = @productId " +
                    "AND SizeId = @sizeId " +
                    "AND ColorId = @colorId; ";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@productId", productId);
                    command.Parameters.AddWithValue("@sizeId", sizeId);
                    command.Parameters.AddWithValue("@colorId", colorId);

                    data.Load(command.ExecuteReader());
                }
            }

            return data.Rows.Count == 0 ? 0 : (int)data.Rows[0]["quantity"];
        }

        //get images based on color
        private DataTable getImages(string colorId)
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();

                string sqlQuery =
                    "select distinct [path] " +
                    "From Product, ProductDetail, ProductImage " +
                    "WHERE Product.ProductId = ProductDetail.ProductId " +
                    "AND ProductDetail.ProductDetailId = ProductImage.ProductDetailId " +
                    "AND ProductDetail.ColorId = @colorId " +
                    "AND Product.ProductId = @productId";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@colorId", colorId);
                    command.Parameters.AddWithValue("@productId", productId);

                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }

        //get all Reviews
        private DataTable getReviewList()
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string sqlQuery =
                     "Select ReviewId, CustomerFullname as CustomerName, ReviewDateTime as ReviewTime, Rating as ReviewRating, ColorName as ReviewColor, Quantity as ReviewQuantity, ReviewDescription as ReviewText " +
                     "From Review r, Customer c, ProductDetail pd, Product p, Color co, Size s " +
                     "Where r.CustomerId = c.CustomerId AND pd.ProductDetailId = r.ProductDetailId " +
                     "AND pd.ColorId = co.ColorId AND pd.ProductId = p.ProductId AND s.SizeId = pd.SizeId " +
                     "AND p.ProductId = @productId;";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@productId", productId);
                    data.Load(command.ExecuteReader());
                }
            }

            data.Columns.Add("Replies", typeof(DataTable));
            foreach (DataRow row in data.Rows)
            {
                row["Replies"] = getReviewReplies(row["ReviewId"].ToString());
            }

            return data;
        }

        //get replies for particular id
        private DataTable getReviewReplies(string reviewId)
        {
            // Create a new DataTable to hold the dummy data
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                //ReplyTextReplyTimeAdminRoleAdminName
                connection.Open();
                string sqlQuery =
                    "Select AdminFullName as AdminName, AdminRoleName as AdminRole, Reply as ReplyText, DateTime as ReplyTime " +
                    "From [Admin] a, ReviewReply rr, Review r, AdminRole ar " +
                    "Where a.AdminId = rr.AdminId AND r.ReviewId = rr.ReviewId AND a.AdminRoleId = ar.AdminRoleId " +
                    "AND r.ReviewId = @reviewId;";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("reviewId", reviewId);

                    data.Load(command.ExecuteReader());
                }

            }

            return data;
        }

        private void setQuantity()
        {
            if (ViewState["ColorId"] == null) return;

            string sizeId = ddlSize.SelectedValue.ToString();
            string colorId = ViewState["ColorId"].ToString();

            int quantity = getQuantity(sizeId, colorId);
            lblQuantity.Text = quantity.ToString();
        }

        protected void lvReviews_PagePropertiesChanged(object sender, EventArgs e)
        {
            lvReviews.DataSource = getReviewList();
            lvReviews.DataBind();
        }



        protected void repeaterColors_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ChangeColor")
            {
                string colorId = e.CommandArgument.ToString();
                ViewState["ColorId"] = colorId;

                selectColor(colorId);
                setQuantity();
            }

        }

        private void selectColor(string colorId)
        {
            // Remove active class
            foreach (RepeaterItem item in repeaterColors.Items)
            {
                LinkButton lbColor = item.FindControl("lbColor") as LinkButton; // Replace with your button ID
                if (lbColor != null)
                {
                    lbColor.CssClass = lbColor.CssClass.Replace(" active", ""); // Remove "active"
                    if (lbColor.Attributes["data-colorId"] == colorId)
                    {
                        lbColor.CssClass += " active";
                    }
                }
            }
            repeaterImg.DataSource = getImages(ViewState["ColorId"].ToString());
            repeaterImg.DataBind();
        }

        protected void ddlSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            setQuantity();
        }


    }
}

