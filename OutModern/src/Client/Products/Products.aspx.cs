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
        public string productImageUrl1 { get; set; }
        public string productImageUrl2 { get; set; }
    }

    public partial class Products : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        private List<Product> productList = new List<Product>();   
        private List<string> selectedCategories = new List<string>();
        private string selectedRating;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                selectedRating = string.Empty;
                selectedCategories.Clear();
                productList = GetProductsInfo();
                BindProducts(productList);
                FilterProducts();
            }
            productList = GetProductsInfo();
            selectedRating = rbRatings.SelectedValue;
            updateCategoryList();
        }
        private void BindProducts(List<Product> products)
        {
            ProductRepeater.DataSource = products;
            ProductRepeater.DataBind();
            lblTotalProducts.Text = ProductRepeater.Items.Count.ToString() + " Products Found";
        }

        private List<Product> GetProductsInfo()
        {
            List<Product> products = new List<Product>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string sqlQuery = "SELECT p.ProductId, p.ProductName, p.UnitPrice, p.ProductCategory, COUNT(r.ReviewId) AS TotalReview, SUM(r.Rating) AS TotalRating FROM Product p LEFT JOIN ProductDetail pd ON p.ProductId = pd.ProductId LEFT JOIN Review r ON pd.ProductDetailId = r.ProductDetailId GROUP BY p.ProductId, p.ProductName, p.UnitPrice, p.ProductCategory;";
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
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
                            product.OverallRatings = product.TotalReview != 0 ? totalRating / (decimal)product.TotalReview : 0;
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

        private List<Product> SortProducts(List<Product> products, string sortExpression)
        {
            switch (sortExpression)
            {
                case "ProductName":
                    return products.OrderBy(p => p.ProductName).ToList();
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

            filteredProducts = SortProducts(filteredProducts, rbSortByPrice.SelectedValue);
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
            rating = Math.Round(rating, 1);
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

        protected void rbSortBy_SelectedIndexChanged(object sender, EventArgs e)
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
            rbSortByPrice.SelectedIndex = 0;
            FilterProducts();
        }
    }
}