using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Products
{
    public class Product
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public decimal UnitPrice { get; set; }
        public List<string> ImagePaths { get; set; }
        public int TotalReview { get; set; }
        public string productImageUrl1 { get; set; }
        public string productImageUrl2 { get; set; }
    }


    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ProductRepeater.DataSource = GetProducts();
                ProductRepeater.DataBind();
                lblTotalProducts.Text = ProductRepeater.Items.Count.ToString() + " Products Found";

            }
        }

        private List<Product> GetProducts()
        {
            List<Product> products = new List<Product>();

            // Establish connection to your database (assuming SQL Server)
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Write SQL query to select product information and image paths
                string query = @"
SELECT p.ProductId, p.ProductName, p.UnitPrice, pi.Path AS ImagePath,
       COUNT(r.ProductDetailId) AS TotalReview, pd.ColorId
FROM Product p
INNER JOIN ProductDetail pd ON p.ProductId = pd.ProductId
INNER JOIN ProductImage pi ON pd.ProductDetailId = pi.ProductDetailId
LEFT JOIN Review r ON pd.ProductDetailId = r.ProductDetailId
GROUP BY p.ProductId, p.ProductName, p.UnitPrice, pi.Path, pd.ColorId
ORDER BY pd.ColorId";


                // Create SqlCommand object with the query and connection
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    try
                    {
                        // Open the connection
                        connection.Open();

                        // Execute the query and fetch the result
                        SqlDataReader reader = command.ExecuteReader();

                        while (reader.Read())
                        {
                            // Check if product already exists in the list
                            Product existingProduct = products.FirstOrDefault(p => p.ProductId == (int)reader["ProductId"]);

                            if (existingProduct == null)
                            {
                                // Create new Product object
                                Product product = new Product
                                {
                                    ProductId = (int)reader["ProductId"],
                                    ProductName = reader["ProductName"].ToString(),
                                    UnitPrice = (decimal)reader["UnitPrice"],
                                    ImagePaths = new List<string>(),
                                    TotalReview = (int)reader["TotalReview"]
                                };

                                // Add image path to the list
                                product.ImagePaths.Add(reader["ImagePath"].ToString());

                                // Add product to the list
                                products.Add(product);
                            }
                            else
                            {
                                // Add additional image path to the existing product
                                existingProduct.ImagePaths.Add(reader["ImagePath"].ToString());
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle exception (e.g., log error, show message to user)
                        // You might want to throw or handle this exception according to your application's requirements
                        // For now, I'll just rethrow it
                    }
                }
            }


            // Assign the first two image paths to productImageUrl1 and productImageUrl2
            foreach (var product in products)
            {
                // Ensure there are at least two image paths
                while (product.ImagePaths.Count < 2)
                {
                    // If there's only one image path, duplicate it to have at least two paths
                    product.ImagePaths.Add(product.ImagePaths.First());
                }

                // Assign the first two image paths to properties
                product.productImageUrl1 = product.ImagePaths[0];
                product.productImageUrl2 = product.ImagePaths[1];
            }


            // Return the list of products
            return products;
        }



    }
}