using OutModern.src.Admin.Products;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
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
        public int ratings { get; set; }
        public string productImageUrl1 { get; set; }
        public string productImageUrl2 { get; set; }
    }

    public partial class Products : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindProducts(GetProductsInfo());
                CategoryRepeater.DataBind();
                lblTotalProducts.Text = ProductRepeater.Items.Count.ToString() + " Products Found";
            }
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
                string sqlQuery = "SELECT p.ProductId, p.ProductName, p.UnitPrice, p.ProductCategory, COUNT(r.ReviewId) AS TotalReview FROM Product p LEFT JOIN ProductDetail pd ON p.ProductId = pd.ProductId LEFT JOIN Review r ON pd.ProductDetailId = r.ProductDetailId GROUP BY p.ProductId, p.ProductName, p.UnitPrice, p.ProductCategory;";
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

        protected void ddlSort_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sortExpression = ddlSort.SelectedValue;    
            List<Product> sortedProducts = SortProducts(GetProductsInfo(), sortExpression);
            BindProducts(sortedProducts);
        }
    }

}