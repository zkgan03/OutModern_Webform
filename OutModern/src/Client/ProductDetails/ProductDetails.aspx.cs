using OutModern.src.Client.Cart;
using OutModern.src.Client.Products;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace OutModern.src.Client.ProductDetails
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int customerId = 1; // REMEMBER TO CHANGE ID

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetProductInfo();
                ColorRepeater.DataBind();
                SizeRepeater.DataBind();
                initColorSize();
                ReviewListView.DataBind();
                calculateOverallRating();
            }
        }

        private DataTable getReviewList()
        {
            string productId = Request.QueryString["ProductId"];
            DataTable data = new DataTable();
            using (SqlConnection connection = new SqlConnection(connectionString))
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
            return data;
        }

        private void calculateOverallRating()
        {
            DataTable reviewsTable = getReviewList();
            int totalReview = 0;
            double totalRating = 0;
            double avgRating = 0.0;
            int oneStar = 0, twoStar = 0, threeStar = 0, fourStar = 0, fiveStar = 0;
            double onePer = 0, twoPer = 0, threePer = 0, fourPer = 0, fivePer = 0;
            foreach (DataRow row in reviewsTable.Rows)
            {
                double rating;
                if (double.TryParse(row["ReviewRating"].ToString(), out rating))
                {
                    totalRating += rating;
                    totalReview++;
                    switch (rating)
                    {
                        case 1.0:
                            oneStar++;
                            break;
                        case 2.0:
                            twoStar++;
                            break;
                        case 3.0:
                            threeStar++;
                            break;
                        case 4.0:
                            fourStar++;
                            break;
                        case 5.0:
                            fiveStar++;
                            break;
                    }
                    avgRating = totalRating / (double)totalReview;
                    onePer = oneStar / (double)totalReview * 100;
                    twoPer = twoStar / (double)totalReview * 100;
                    threePer = threeStar / (double)totalReview * 100;
                    fourPer = fourStar / (double)totalReview * 100;
                    fivePer = fiveStar / (double)totalReview * 100;
                }
            }
            if (totalReview > 0)
            {
                avgRating = totalRating / totalReview;
            }
            starBar1.Attributes["style"] = "width: calc((" + onePer + ") / 100 * 100%)";
            starBar2.Attributes["style"] = "width: calc((" + twoPer + ") / 100 * 100%)";
            starBar3.Attributes["style"] = "width: calc((" + threePer + ") / 100 * 100%)";
            starBar4.Attributes["style"] = "width: calc((" + fourPer + ") / 100 * 100%)";
            starBar5.Attributes["style"] = "width: calc((" + fivePer + ") / 100 * 100%)";
            lbl1star.Text = onePer.ToString("F0");
            lbl2star.Text = twoPer.ToString("F0");
            lbl3star.Text = threePer.ToString("F0");
            lbl4star.Text = fourPer.ToString("F0");
            lbl5star.Text = fivePer.ToString("F0");
            avgRating = Math.Round(avgRating, 1);
            lblAvgRatings.Text = avgRating.ToString("F1");
            lblReviews.Text = "(" + totalReview.ToString() + " Reviews)";
            lblTotalReview.Text = totalReview.ToString();
            int fullStars = (int)avgRating;
            double remainder = avgRating - fullStars;
            int grayStars = 5 - fullStars - (remainder >= 0.5 ? 1 : 0);
            StringBuilder stars = new StringBuilder();
            StringBuilder stars1 = new StringBuilder();
            for (int i = 0; i < fullStars; i++)
            {
                stars.Append("<i class='fas fa-star text-yellow-400 text-lg'></i>");
                stars1.Append("<i class='fas fa-star rounded-lg bg-black p-2 text-lg text-yellow-300'></i>");
            }
            if (remainder >= 0.5)
            {
                stars.Append("<i class='fas fa-star-half-alt text-yellow-400 text-lg'></i>");
                stars1.Append("<i class='fas fa-star-half-alt rounded-lg bg-black p-2 text-lg text-yellow-300'></i>");
            }
            for (int i = 0; i < grayStars; i++)
            {
                stars.Append("<i class='far fa-star text-gray-400 text-lg'></i>");
                stars1.Append("<i class='far fa-star rounded-lg bg-black p-2 text-lg text-yellow-300'></i>");
            }
            ratingStar2.InnerHtml = stars1.ToString();
            ratingStars.InnerHtml = stars.ToString();
        }

        private void initColorSize()
        {
            bool quantityGreaterThanZero = false;
            foreach (RepeaterItem colorItem in ColorRepeater.Items)
            {
                LinkButton colorBtn = colorItem.FindControl("lbtnColor") as LinkButton;
                string colorId = colorBtn.Attributes["data-colorId"];
                ViewState["ColorId"] = colorId;
                foreach (RepeaterItem sizeItem in SizeRepeater.Items)
                {
                    LinkButton sizeBtn = sizeItem.FindControl("lbtnSize") as LinkButton;
                    string sizeId = sizeBtn.Attributes["data-sizeId"];
                    ViewState["SizeId"] = sizeId;
                    if (GetQuantity() > 0)
                    {
                        quantityGreaterThanZero = true;
                        break;
                    }
                }
                if (quantityGreaterThanZero)
                {
                    break;
                }
            }
            GetImages(ViewState["ColorId"].ToString());
        }

        protected string FormatReplies(object replyDescriptionObj)
        {
            string replyDescription = replyDescriptionObj.ToString();
            if (!string.IsNullOrEmpty(replyDescription))
            {
                string[] replies = replyDescription.Split(new string[] { "NextReviewReply " }, StringSplitOptions.RemoveEmptyEntries);
                StringBuilder sb = new StringBuilder();

                foreach (string reply in replies)
                {
                    sb.Append("<div class='overflow-hidden rounded-lg mb-4 bg-white shadow-lg'>");
                    sb.Append("<div class='px-6 py-4'>");
                    sb.Append($"<p class='font-bold text-black'>Seller's Response:</p>");
                    sb.Append($"<div class='mt-2 text-gray-700'>");
                    sb.Append($"<p>{reply}</p>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</div>");
                }

                return sb.ToString();
            }
            return string.Empty;
        }

        protected string GenerateStars(int rating)
        {
            StringBuilder stars = new StringBuilder();

            for (int i = 1; i <= 5; i++)
            {
                if (i <= rating)
                {
                    stars.Append("<i class='fas fa-star text-yellow-400 text-sm'></i>");
                }
                else
                {
                    stars.Append("<i class='far fa-star text-gray-400 text-sm'></i>");
                }
            }
            return stars.ToString();
        }

        private int GetQuantity()
        {
            int quantity = 0;
            string productId = Request.QueryString["ProductId"];
            string colorId = ViewState["ColorId"] as string;
            string sizeId = ViewState["SizeId"] as string;
            if (colorId != null && sizeId != null)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string sqlQuery = "SELECT Quantity AS TotalQuantity FROM ProductDetail WHERE ProductId = @productId AND SizeId = @sizeId AND ColorId = @colorId";

                    using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                    {
                        command.Parameters.AddWithValue("@productId", productId);  // Replace with your ProductId
                        command.Parameters.AddWithValue("@sizeId", sizeId);
                        command.Parameters.AddWithValue("@colorId", colorId);
                        connection.Open();

                        using (SqlDataReader reader = command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                if (reader["TotalQuantity"] != DBNull.Value)
                                {
                                    lblQuantity.Text = reader["TotalQuantity"].ToString() + " pieces available";
                                    quantity = Convert.ToInt32(reader["TotalQuantity"]);
                                    txtQuantity.Attributes["Max"] = quantity.ToString();
                                }
                            }
                        }

                        connection.Close();
                    }
                }
            }
            return quantity;
        }

        protected void GetImages(string colorId)
        {
            string productId = Request.QueryString["ProductId"];
            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                string sqlQuery = "SELECT DISTINCT Path " +
    "FROM Product " +
    "INNER JOIN ProductDetail ON Product.ProductId = ProductDetail.ProductId " +
    "INNER JOIN ProductImage ON ProductDetail.ProductDetailId = ProductImage.ProductDetailId " +
    "WHERE ProductDetail.ColorId = @colorId AND Product.ProductId = @productId";
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@colorId", colorId);  // Replace with your ColorId
                    command.Parameters.AddWithValue("@productId", productId);  // Replace with your ProductId
                    connection.Open();
                    List<string> imageUrls = new List<string>();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string imageUrl = reader["Path"].ToString();
                            imageUrls.Add(imageUrl);

                        }
                    }
                    if (imageUrls.Count >= 1)
                    {
                        mainImage1.ImageUrl = imageUrls[0];
                        Image1.ImageUrl = imageUrls[0];
                    }
                    if (imageUrls.Count >= 2)
                    {
                        mainImage2.ImageUrl = imageUrls[1];
                        Image2.ImageUrl = imageUrls[1];
                    }
                    if (imageUrls.Count >= 3)
                    {
                        mainImage3.ImageUrl = imageUrls[2];
                        Image3.ImageUrl = imageUrls[2];
                    }
                    connection.Close();
                }
            }

        }

        private void GetProductInfo()
        {
            string productId = Request.QueryString["ProductId"];
            if (productId != null)
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "Select ProductId, ProductName, ProductDescription, ProductCategory, UnitPrice " +
                    "FROM Product " +
                    "WHERE ProductId = @ProductId;";
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@ProductId", productId);
                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();
                        if (reader.Read())
                        {
                            lblProdName.Text = reader["ProductName"].ToString();
                            lblDescription.Text = reader["ProductDescription"].ToString();
                            lblPrice.Text = "RM " + reader["UnitPrice"].ToString();
                        }
                        connection.Close();
                    }
                }
            }
        }
        private void selectColor(string colorId)
        {
            foreach (RepeaterItem item in ColorRepeater.Items)
            {
                LinkButton colorBtn = item.FindControl("lbtnColor") as LinkButton; // Replace with your button ID
                if (colorBtn != null)
                {
                    colorBtn.CssClass.Replace(" selectedColor", "");
                    if (colorBtn.Attributes["data-colorId"] == colorId)
                    {
                        colorBtn.CssClass += " selectedColor";
                        lblColor.Text = colorBtn.Attributes["value"].ToString();
                        lblColor.Visible = true;
                    }
                }
            }
            GetImages(colorId);
            resetInputQuantity();
        }

        protected void ColorRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectColor")
            {
                string previousColorId = ViewState["ColorId"] as string;
                string newColorId = e.CommandArgument.ToString();

                // Remove the 'selectedColor' class from the previously selected color button
                foreach (RepeaterItem item in ColorRepeater.Items)
                {
                    LinkButton colorBtn = item.FindControl("lbtnColor") as LinkButton;
                    if (colorBtn != null && colorBtn.Attributes["data-colorId"] == previousColorId)
                    {
                        colorBtn.CssClass = colorBtn.CssClass.Replace(" selectedColor", "").Trim();
                        break;
                    }
                }

                ViewState["ColorId"] = newColorId;
                selectColor(newColorId);

                string sizeId = ViewState["SizeId"] as string;
                if (sizeId != null)
                {
                    selectSize(sizeId);
                }
            }

        }

        private void selectSize(string sizeId)
        {
            foreach (RepeaterItem item in SizeRepeater.Items)
            {
                LinkButton sizeBtn = item.FindControl("lbtnSize") as LinkButton; // Replace with your button ID
                if (sizeBtn != null)
                {
                    sizeBtn.CssClass.Replace(" selectedSize", "").Trim(); ;
                    if (sizeBtn.Attributes["data-sizeId"] == sizeId)
                    {
                        sizeBtn.CssClass += " selectedSize";
                        lblSize.Text = sizeBtn.Attributes["value"].ToString();
                        lblSize.Visible = true;
                    }
                }
            }
            GetQuantity();
            resetInputQuantity();
        }

        private void resetInputQuantity()
        {
            txtQuantity.Text = "1";
        }

        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            int quantity = Convert.ToInt32(txtQuantity.Text);
            if (quantity > 1)  // Ensure quantity doesn't go negative
            {
                quantity--;
                txtQuantity.Text = quantity.ToString();
            }
        }

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            int quantity = Convert.ToInt32(txtQuantity.Text);
            int totalQuantity = GetQuantity();
            if (quantity < totalQuantity)
            {
                quantity++;
                txtQuantity.Text = quantity.ToString();
            }
        }

        protected void SizeRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectSize")
            {
                string previousSizeId = ViewState["SizeId"] as string;
                string newSizeId = e.CommandArgument.ToString();

                // Remove the 'selectedSize' class from the previously selected size button
                foreach (RepeaterItem item in SizeRepeater.Items)
                {
                    LinkButton sizeBtn = item.FindControl("lbtnSize") as LinkButton;
                    if (sizeBtn != null && sizeBtn.Attributes["data-sizeId"] == previousSizeId)
                    {
                        sizeBtn.CssClass = sizeBtn.CssClass.Replace(" selectedSize", "").Trim();
                        break;
                    }
                }

                ViewState["SizeId"] = newSizeId;
                selectSize(newSizeId);

                string colorId = ViewState["ColorId"] as string;
                if (colorId != null)
                {
                    selectColor(colorId);
                }
            }
        }

        protected void SizeRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton sizeBtn = e.Item.FindControl("lbtnSize") as LinkButton;
                if (sizeBtn != null)
                {
                    string sizeId = sizeBtn.Attributes["data-sizeId"];
                    string selectedSizeId = ViewState["SizeId"] as string;
                    sizeBtn.CssClass.Replace(" selectedSize", "").Trim();
                    if (sizeId == selectedSizeId)
                    {
                        sizeBtn.CssClass += " selectedSize";
                        lblSize.Text = sizeBtn.Attributes["value"].ToString();
                        lblSize.Visible = true;
                    }
                }
            }
        }

        protected void ColorRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                LinkButton colorBtn = e.Item.FindControl("lbtnColor") as LinkButton;
                if (colorBtn != null)
                {
                    string colorId = colorBtn.Attributes["data-colorId"];
                    string selectedColorId = ViewState["ColorId"] as string;
                    colorBtn.CssClass = colorBtn.CssClass.Replace(" selectedColor", "").Trim();
                    if (colorId == selectedColorId)
                    {
                        colorBtn.CssClass += " selectedColor";
                        lblColor.Text = colorBtn.Attributes["value"].ToString();
                        lblColor.Visible = true;
                    }

                }
            }
        }

        protected void AddToCart_Click(object sender, EventArgs e)
        {
            // Get the selected product details
            int productId = Convert.ToInt32(Request.QueryString["ProductId"]);
            int colorId = Convert.ToInt32(ViewState["ColorId"]);
            int sizeId = Convert.ToInt32(ViewState["SizeId"]);
            int quantity = Convert.ToInt32(txtQuantity.Text);


            // Check if the customer ID is valid
            if (customerId > 0)
            {
                // Check if the cart item already exists for the same customer and product details
                int existingCartItemQuantity = GetExistingCartItemQuantity(customerId, productId, colorId, sizeId);

                if (existingCartItemQuantity > 0)
                {
                    // Update the quantity for the existing cart item
                    UpdateCartItemQuantity(customerId, productId, colorId, sizeId, existingCartItemQuantity + quantity);
                }
                else
                {
                    // Insert the data into the CartItem table
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        string sqlQuery = "INSERT INTO CartItem (CartId, ProductDetailId, Quantity) VALUES (@CartId, @ProductDetailId, @Quantity)";
                        using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                        {
                            connection.Open();
                            command.Parameters.AddWithValue("@CartId", GetCartId(customerId)); // You need to implement this method to retrieve the cart ID based on the customer ID
                            command.Parameters.AddWithValue("@ProductDetailId", GetProductDetailId(productId, colorId, sizeId)); // You need to implement this method to retrieve the ProductDetailId based on the product ID, color ID, and size ID
                            command.Parameters.AddWithValue("@Quantity", quantity);
                            command.ExecuteNonQuery();

                            UpdateCartSubtotal(customerId);
                        }
                    }
                }

                Response.Redirect(Request.RawUrl);
            }
            else
            {
                Response.Redirect("~/src/Client/Login/Login.aspx");
            }
        }

        private void UpdateCartSubtotal(int customerId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE Cart " +
                               "SET Subtotal = (SELECT SUM(P.UnitPrice * CI.Quantity) " +
                                              "FROM CartItem CI " +
                                              "INNER JOIN ProductDetail PD ON CI.ProductDetailId = PD.ProductDetailId " +
                                              "INNER JOIN Product P ON PD.ProductId = P.ProductId " +
                                              "WHERE CI.CartId = Cart.CartId) " +
                               "WHERE CustomerId = @CustomerId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        private int GetExistingCartItemQuantity(int customerId, int productId, int colorId, int sizeId)
        {
            int existingQuantity = 0;

            // Query to check if the cart item already exists for the provided customer ID and product details
            string query = "SELECT Quantity FROM CartItem WHERE CartId = @CartId AND ProductDetailId = @ProductDetailId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@CartId", GetCartId(customerId));
                    command.Parameters.AddWithValue("@ProductDetailId", GetProductDetailId(productId, colorId, sizeId));

                    connection.Open();
                    object result = command.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                    {
                        existingQuantity = Convert.ToInt32(result);
                    }
                }
            }

            return existingQuantity;
        }

        private void UpdateCartItemQuantity(int customerId, int productId, int colorId, int sizeId, int newQuantity)
        {
            // Query to update the quantity of the existing cart item
            string query = "UPDATE CartItem SET Quantity = @Quantity WHERE CartId = @CartId AND ProductDetailId = @ProductDetailId";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Quantity", newQuantity);
                    command.Parameters.AddWithValue("@CartId", GetCartId(customerId));
                    command.Parameters.AddWithValue("@ProductDetailId", GetProductDetailId(productId, colorId, sizeId));

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }


        private int GetCartId(int customerId)
        {
            int cartId = 0; // Initialize cartId to 0
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sqlQuery = "SELECT CartId FROM Cart WHERE CustomerId = @CustomerId";
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@CustomerId", customerId);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        cartId = Convert.ToInt32(result);
                    }
                }
            }
            return cartId;
        }

        private int GetProductDetailId(int productId, int colorId, int sizeId)
        {
            int productDetailId = 0; // Initialize productDetailId to 0
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sqlQuery = "SELECT ProductDetailId FROM ProductDetail WHERE ProductId = @ProductId AND ColorId = @ColorId AND SizeId = @SizeId";
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@ProductId", productId);
                    command.Parameters.AddWithValue("@ColorId", colorId);
                    command.Parameters.AddWithValue("@SizeId", sizeId);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        productDetailId = Convert.ToInt32(result);
                    }
                }
            }
            return productDetailId;
        }


    }
}