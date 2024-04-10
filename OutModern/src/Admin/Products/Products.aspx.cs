using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.InteropServices;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using OutModern.src.Admin.Interfaces;
using OutModern.src.Admin.Staffs;


namespace OutModern.src.Admin.Products
{
    public partial class Products : System.Web.UI.Page, IFilter
    {
        protected static readonly string ProductEdit = "ProductEdit";
        protected static readonly string ProductAdd = "ProductAdd";
        protected static readonly string ProductDetails = "ProductDetails";

        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { ProductEdit , "~/src/Admin/ProductEdit/ProductEdit.aspx" },
            { ProductAdd , "~/src/Admin/ProductAdd/ProductAdd.aspx" },
            { ProductDetails , "~/src/Admin/ProductDetails/ProductDetails.aspx" },
        };

        private string ConnectionStirng = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lvProducts.DataSource = GetProducts();
                lvProducts.DataBind();
                Page.DataBind();

            }
        }
        //store each column sorting state into viewstate
        private Dictionary<string, string> SortDirections
        {
            get
            {
                if (ViewState["SortDirections"] == null)
                {
                    ViewState["SortDirections"] = new Dictionary<string, string>();
                }
                return (Dictionary<string, string>)ViewState["SortDirections"];
            }
            set
            {
                ViewState["SortDirections"] = value;
            }
        }

        // Toggle Sorting
        private void toggleSortDirection(string columnName)
        {
            if (!SortDirections.ContainsKey(columnName))
            {
                SortDirections[columnName] = "ASC";
            }
            else
            {
                SortDirections[columnName] = SortDirections[columnName] == "ASC" ? "DESC" : "ASC";
            }
        }

        private DataTable GetProducts(string sortExpression = null, string sortDirection = "ASC")
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                connection.Open();
                string sqlQuery =
                    "SELECT ProductId, [Path], ProductName, ProductCategory, UnitPrice, ProductStatusName " +
                    "FROM ( " +
                            "SELECT p.ProductId, [Path], ProductName, ProductCategory, UnitPrice, ProductStatusName, " +
                            "ROW_NUMBER() OVER (PARTITION BY p.ProductId ORDER BY p.ProductId ) AS RowNumber " +
                            "FROM Product p " +
                            "INNER JOIN ProductDetail ON p.ProductId = ProductDetail.ProductId " +
                            "INNER JOIN ( " +
                                "SELECT ProductDetail.ProductId, [Path] " +
                                "FROM ProductImage " +
                                "INNER JOIN ProductDetail ON ProductImage.ProductDetailId = ProductDetail.ProductDetailId " +
                            ") t ON t.ProductId = p.ProductId " +
                            "INNER JOIN ProductStatus ON p.ProductStatusId = ProductStatus.ProductStatusId " +
                    ") AS Subquery " +
                    "WHERE RowNumber = 1 ";

                if (!string.IsNullOrEmpty(sortExpression))
                {
                    sqlQuery += "ORDER BY " + sortExpression + " " + sortDirection;
                }


                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    data.Load(command.ExecuteReader());
                }
            }

            data.Columns.Add("Colors", typeof(DataTable));
            foreach (DataRow row in data.Rows)
            {
                row["Colors"] = getColors(row["productId"].ToString());
            }

            return data;
        }

        private DataTable getColors(string productId)
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                connection.Open();

                string sqlQuery =
                    "Select Distinct c.HexColor as color " +
                    "From Product p, Color c, ProductDetail pd " +
                    "Where p.ProductId = @productId AND pd.ColorId = c.ColorId " +
                    "AND p.ProductId = pd.ProductId AND isDeleted = 0";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@productId", productId);

                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }

        protected void lvProducts_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                // Retrieve the data item
                //Product rowView = (Product)e.Item.DataItem;
                DataRowView rowView = (DataRowView)e.Item.DataItem;

                // Find the span control
                HtmlGenericControl statusSpan = (HtmlGenericControl)e.Item.FindControl("productStatus");
                string status = rowView["ProductStatusName"].ToString();

                // Add CSS class based on status
                if (status == "In Stock")
                {
                    statusSpan.Attributes["class"] += " in-stock";
                }
                else if (status == "Out of Stock")
                {
                    statusSpan.Attributes["class"] += " out-of-stock";
                }
                else if (status == "Unavailable")
                {
                    statusSpan.Attributes["class"] += " temp-unavailable";
                }
            }

        }


        protected void lvProducts_PagePropertiesChanged(object sender, EventArgs e)
        {
            string sortExpression = ViewState["SortExpression"]?.ToString();
            lvProducts.DataSource = sortExpression == null ? GetProducts() : GetProducts(sortExpression, SortDirections[sortExpression]);
            lvProducts.DataBind();
        }

        protected void lvProducts_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        public void FilterListView(string searchTerm)
        {
            lvProducts.DataSource = FilterDataTable(GetProducts(), searchTerm);
            dpBottomProducts.SetPageProperties(0, dpBottomProducts.MaximumRows, false);
            lvProducts.DataBind();
        }
        private DataTable FilterDataTable(DataTable dataTable, string searchTerm)
        {
            string safeSearchTerm = searchTerm.Replace("'", "''");

            // Build filter expression with product fields
            string expression = string.Format(
                "Convert(ProductId, 'System.String') LIKE '%{0}%' OR " +
                "ProductName LIKE '%{0}%' OR " +
                "ProductCategory LIKE '%{0}%' OR " +
                "Convert(UnitPrice, 'System.String') LIKE '%{0}%' OR " +
                "Status LIKE '%{0}%' OR " +
                safeSearchTerm);

            // Filter the rows
            DataRow[] filteredRows = dataTable.Select(expression);

            // Create a new DataTable for the filtered results
            DataTable filteredDataTable = dataTable.Clone();

            // Import the filtered rows
            foreach (DataRow row in filteredRows)
            {
                filteredDataTable.ImportRow(row);
            }

            return filteredDataTable;
        }

        protected void lvProducts_Sorting(object sender, ListViewSortEventArgs e)
        {
            toggleSortDirection(e.SortExpression); // Toggle sorting direction for the clicked column


            ViewState["SortExpression"] = e.SortExpression; // used for retain the sorting

            // Re-bind the ListView with sorted data
            lvProducts.DataSource = GetProducts(e.SortExpression, SortDirections[e.SortExpression]);
            lvProducts.DataBind();
        }
    }
}