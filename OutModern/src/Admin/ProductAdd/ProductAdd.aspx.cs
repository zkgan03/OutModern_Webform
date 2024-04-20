using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Configuration;

namespace OutModern.src.Admin.ProductAdd
{
    public partial class ProductAdd : System.Web.UI.Page
    {
        protected static readonly string ProductDetails = "ProductDetails";
        protected static readonly string Products = "Products";
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { ProductDetails , "~/src/Admin/ProductDetails/ProductDetails.aspx" },
            { Products , "~/src/Admin/Products/Products.aspx" }

        };

        private string ConnectionStirng = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlCategory.DataSource = getProductCategory();
                ddlCategory.DataValueField = "ProductCategory";
                ddlCategory.DataTextField = "ProductCategory";
                ddlCategory.DataBind();

                ddlStatus.DataSource = getProductStatus();
                ddlStatus.DataValueField = "ProductStatusId";
                ddlStatus.DataTextField = "ProductStatusName";
                ddlStatus.DataBind();
            }
        }

        //
        //db operation
        //

        //Get All Product Status Available
        private DataTable getProductStatus()
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                connection.Open();
                string sqlQuery =
                    "Select ProductStatusId, ProductStatusName " +
                    "From ProductStatus;";
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }

        //Get Categories
        private DataTable getProductCategory()
        {
            DataTable data = new DataTable();
            data.Columns.Add("ProductCategory");

            // Add product categories to the table
            data.Rows.Add("Hoodies");
            data.Rows.Add("Tee Shirts");
            data.Rows.Add("Sweaters");
            data.Rows.Add("Shorts and Pants");
            data.Rows.Add("Trousers");
            data.Rows.Add("Accessories");

            return data;
        }

        private int insertProduct(string productName, string productDescription, string category, string unitPrice, string statusId)
        {
            int prodId = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                connection.Open();
                string sqlQuery =
                    "INSERT into Product (ProductName, ProductDescription, ProductCategory, UnitPrice, ProductStatusId) " +
                    "OUTPUT INSERTED.ProductId " +
                    "values (@productName, @productDescription, @category, @unitPrice, @statusId)";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {

                    command.Parameters.AddWithValue("@productName", productName);
                    command.Parameters.AddWithValue("@productDescription", productDescription);
                    command.Parameters.AddWithValue("@category", category);
                    command.Parameters.AddWithValue("@unitPrice", unitPrice);
                    command.Parameters.AddWithValue("@statusId", statusId);

                    prodId = int.Parse(command.ExecuteScalar().ToString());
                }

            }

            return prodId;
        }

        //
        // Page Events
        //
        protected void lbAdd_Click(object sender, EventArgs e)
        {
            string productName = txtProdName.Text;
            string productDescription = txtProdDescription.Text;
            string category = ddlCategory.SelectedValue;
            string price = txtPrice.Text;
            string statusId = ddlStatus.SelectedValue;

            // TODO : validation

            int id = insertProduct(productName, productDescription, category, price, statusId);

            if (id > 0)
            {
                Response.Redirect($"~/src/Admin/ProductEdit/ProductEdit.aspx?ProductId={id}");
            }
        }

    }
}