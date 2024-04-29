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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                productList = GetProductsInfo();
                BindProducts(productList);
                lblTotalProducts.Text = ProductRepeater.Items.Count.ToString() + " Products Found";
            }
            productList = GetProductsInfo();
        }
        private void BindProducts(List<Product> products)
        {
            ProductRepeater.DataSource = products;
            ProductRepeater.DataBind();
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
                            product.ImagePaths = GetProductImages(product.ProductId);
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
                case "Price":
                    return products.OrderBy(p => p.UnitPrice).ToList();
                default:
                    return products; // Return the original list if the sort expression is not recognized
            }
        }

        private void FilterProducts()
        {
            List<Product> filteredProducts;

            if (selectedCategories.Count == 0)
            {
                filteredProducts = productList;
            }
            else
            {
                filteredProducts = productList.Where(p => selectedCategories.Contains(p.ProductCategory)).ToList();
            }
            BindProducts(filteredProducts);
        }

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sortExpression = ddlSort.SelectedValue;    
            List<Product> sortedProducts = SortProducts(productList, sortExpression);
            BindProducts(sortedProducts);
        }

        protected void CategoryCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox categoryCheckBox = (CheckBox)sender;
            string category = categoryCheckBox.Attributes["data-category"];
            if (categoryCheckBox.Checked)
            {
                selectedCategories.Add(category);
            }
            else
            {
                selectedCategories.Remove(category);
            }
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
    }
}