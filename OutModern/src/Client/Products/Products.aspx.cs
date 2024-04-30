using OutModern.src.Admin.Products;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static OutModern.src.Admin.Products.Products;


namespace OutModern.src.Client.Products
{
    public class Product
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public decimal UnitPrice { get; set; }
        public string ProductCategory { get; set; }
        public List<string> ImagePaths { get; set; }
        public int TotalReview { get; set; }
        public decimal OverallRatings { get; set; }
        public int TotalSold { get; set; }
        public List<string> AvailableColors { get; set; }
        public string productImageUrl1 { get; set; }
        public string productImageUrl2 { get; set; }
    }

    public partial class Products : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        private List<Product> productList = new List<Product>();   
        private List<string> selectedCategories = new List<string>();
        private List<string> selectedColors = new List<string>();
        private string selectedRating;
        private decimal? minPrice;
        private decimal? maxPrice;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string searchQuery = Session["SearchQuery"] as string;
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    List<Product> searchResults = GetProductsInfo(searchQuery);
                    BindProducts(searchResults);
                    Session["SearchQuery"] = null; // Clear the search query from session
                } else
                {
                    selectedRating = string.Empty;
                    selectedCategories.Clear();
                    selectedColors.Clear();
                    productList = GetProductsInfo();
                    BindProducts(productList);
                    chkColorSelection.DataBind();
                    chkColorSelection.ClearSelection();
                }             
            } else
            {
                productList = GetProductsInfo();
                selectedRating = rbRatings.SelectedValue;
                updateCategoryList();
                updateMinAndMaxPrice();
                updateColorList();
            }
        }

     
        private void BindProducts(List<Product> products)
        {
            ProductRepeater.DataSource = products;
            ProductRepeater.DataBind();
            lblTotalProducts.Text = ProductRepeater.Items.Count.ToString() + " Products Found";
        }

        private List<Product> GetProductsInfo(string searchQuery = "")
        {
            List<Product> products = new List<Product>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sqlQuery = "SELECT p.ProductId, p.ProductName, p.UnitPrice, p.ProductCategory, COUNT(r.ReviewId) AS TotalReview, SUM(r.Rating) AS TotalRating FROM Product p INNER JOIN ProductDetail pd ON p.ProductId = pd.ProductId LEFT JOIN Review r ON pd.ProductDetailId = r.ProductDetailId";

                // Adjust the query if a search query is provided
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    sqlQuery += " WHERE p.ProductName LIKE '%' + @SearchQuery + '%' OR p.ProductCategory LIKE '%' + @SearchQuery + '%'";
                }

                sqlQuery += " GROUP BY p.ProductId, p.ProductName, p.UnitPrice, p.ProductCategory;";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    // Add search query parameter if provided
                    if (!string.IsNullOrEmpty(searchQuery))
                    {
                        command.Parameters.AddWithValue("@SearchQuery", searchQuery);
                    }

                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Product product = new Product();
                            product.ProductId = (int)reader["ProductId"];
                            product.ProductName = reader["ProductName"].ToString();
                            product.UnitPrice = (decimal)reader["UnitPrice"];
                            product.ProductCategory = reader["ProductCategory"].ToString();
                            product.TotalReview = (int)reader["TotalReview"];
                            decimal totalRating = (decimal)reader["TotalRating"];
                            product.OverallRatings = product.TotalReview != 0 ? Math.Round((totalRating / (decimal)product.TotalReview), 1) : 0;
                            product.TotalSold = GetTotalSold(product.ProductId);
                            product.AvailableColors = GetAvailableColors(product.ProductId);
                            List<string> imagePaths = GetProductImages(product.ProductId);
                            // Check if imagePaths is null or empty
                            if (imagePaths == null || imagePaths.Count == 0)
                            {
                                // Skip this product as it doesn't have image paths
                                continue;
                            }
                            product.ImagePaths = imagePaths;
                            product.productImageUrl1 = imagePaths.FirstOrDefault();
                            product.productImageUrl2 = imagePaths.Skip(1).FirstOrDefault();
                            products.Add(product);
                        }
                    }
                }
            }
            return products;
        }


        private int GetTotalSold(int productId)
        {
            int totalSold = 0;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sqlQuery = "SELECT SUM(Quantity) AS TotalSold FROM OrderItem WHERE ProductDetailId IN (SELECT ProductDetailId FROM ProductDetail WHERE ProductId = @ProductId)";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@ProductId", productId);
                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != DBNull.Value)
                    {
                        totalSold = Convert.ToInt32(result);
                    }
                }
            }

            return totalSold;
        }

        private List<string> GetProductImages(int productId)
        {
            List<string> imagePaths = new List<string>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string imageQuery = @"SELECT DISTINCT Path FROM ProductImage WHERE ProductDetailId IN (SELECT ProductDetailId FROM ProductDetail WHERE ProductId = @ProductId)";

                using (SqlCommand command = new SqlCommand(imageQuery, connection))
                {
                    command.Parameters.AddWithValue("@ProductId", productId);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string imagePath = reader["Path"].ToString();
                            imagePaths.Add(imagePath);
                        }
                    }
                }
            }
            return imagePaths;
        }

        protected List<string> GetAvailableColors(int productId)
        {
            List<string> availableColors = new List<string>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sqlQuery = @"SELECT DISTINCT c.ColorId, c.HexColor
                            FROM ProductDetail pd
                            INNER JOIN Color c ON pd.ColorId = c.ColorId
                            WHERE pd.ProductId = @ProductId ORDER BY c.ColorId";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@ProductId", productId);
                    connection.Open();

                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            string hexColor = reader["HexColor"].ToString();
                            availableColors.Add(hexColor);
                        }
                    }
                }
            }
            return availableColors;
        }

        private List<Product> SortProducts(List<Product> products, string sortExpression)
        {
            switch (sortExpression)
            {
                case "TotalSold":
                    return products.OrderByDescending(p => p.TotalSold).ToList();
                case "Customer Ratings":
                    return products.OrderByDescending(p => p.OverallRatings).ToList();
                case "LowestPrice":
                    return products.OrderBy(p => p.UnitPrice).ToList();
                case "HighestPrice":
                    return products.OrderByDescending(p => p.UnitPrice).ToList();
                default:
                    return products; // Return the original list if the sort expression is not recognized
            }
        }

        private void FilterProducts()
        {
            List<Product> filteredProducts;

            if (string.IsNullOrEmpty(selectedRating))
            {
                filteredProducts = productList;
            }
            else
            {
                int selectedRatingValue = int.Parse(selectedRating.Substring(0, 1));
                filteredProducts = productList.Where(p => p.OverallRatings >= selectedRatingValue).ToList();
            }

            if (selectedCategories.Count > 0)
            {
                filteredProducts = filteredProducts.Where(p => selectedCategories.Contains(p.ProductCategory)).ToList();
            }

            if (selectedColors.Count > 0)
            {
                filteredProducts = filteredProducts.Where(p => p.AvailableColors.Any(c => selectedColors.Contains(c))).ToList();
            }

            if (minPrice.HasValue || maxPrice.HasValue)
            {
                filteredProducts = filteredProducts.Where(p => (!minPrice.HasValue || p.UnitPrice >= minPrice.Value) && (!maxPrice.HasValue || p.UnitPrice <= maxPrice.Value)).ToList();
            }

            filteredProducts = SortProducts(filteredProducts, ddlSort.SelectedValue);
            BindProducts(filteredProducts);
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            FilterProducts();
        }

        protected void CategoryCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            FilterProducts();
        }

        protected string GenerateStars(double rating)
        {
            int fullStars = (int)rating;
            double remainder = rating - fullStars;
            int grayStars = 5 - fullStars - (remainder >= 0.5 ? 1 : 0);
            StringBuilder stars = new StringBuilder();
            for (int i = 0; i < fullStars; i++)
            {
                stars.Append("<i class='fas fa-star text-yellow-400 text-lg'></i>");
            }
            if (remainder >= 0.5)
            {
                stars.Append("<i class='fas fa-star-half-alt text-yellow-400 text-lg'></i>");
            }
            for (int i = 0; i < grayStars; i++)
            {
                stars.Append("<i class='far fa-star text-gray-400 text-lg'></i>");
            }
            return stars.ToString();
        }

        protected void rbRatings_SelectedIndexChanged(object sender, EventArgs e)
        {
            FilterProducts();
        }

        protected void CategoryCheckBoxList_SelectedIndexChanged(object sender, EventArgs e)
        {
            updateCategoryList();
            FilterProducts();
        }

        private void updateCategoryList()
        {
            selectedCategories.Clear(); // Clear the existing selected categories
            foreach (ListItem item in CategoryCheckBoxList.Items)
            {
                if (item.Selected)
                {
                    selectedCategories.Add(item.Value);
                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            selectedRating = string.Empty;
            selectedCategories.Clear();
            CategoryCheckBoxList.ClearSelection();
            ddlSort.SelectedIndex = 0;
            rbRatings.ClearSelection();
            selectedColors.Clear();
            chkColorSelection.ClearSelection();
            txtMinPrice.Text = "";
            txtMaxPrice.Text = "";
            minPrice = null;
            maxPrice = null;
            FilterProducts();
        }

        protected void btnPriceFilter_Click(object sender, EventArgs e)
        {
            updateMinAndMaxPrice();
            FilterProducts();
        }

        private void updateMinAndMaxPrice()
        {
            decimal minPriceValue, maxPriceValue;

            if (decimal.TryParse(txtMinPrice.Text, out minPriceValue))
            {
                minPrice = minPriceValue;
            }
            else
            {
                minPrice = null;
            }

            if (decimal.TryParse(txtMaxPrice.Text, out maxPriceValue))
            {
                maxPrice = maxPriceValue;
            }
            else
            {
                maxPrice = null;
            }
        }

        protected void chkColorSelection_SelectedIndexChanged(object sender, EventArgs e)
        {
            updateColorList();
            FilterProducts();  
        }

        private void updateColorList()
        {
            selectedColors.Clear(); // Clear the existing selected categories
            foreach (ListItem item in chkColorSelection.Items)
            {
                if (item.Selected)
                {
                    selectedColors.Add(item.Value);
                }
            }
        }

        protected void ProductRepeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Product product = (Product)e.Item.DataItem;
                Repeater colorRepeater = (Repeater)e.Item.FindControl("ColorRepeater");

                if (product.AvailableColors != null && product.AvailableColors.Count > 0)
                {
                    colorRepeater.DataSource = product.AvailableColors;
                    colorRepeater.DataBind();
                }
            }
        }
    }
}