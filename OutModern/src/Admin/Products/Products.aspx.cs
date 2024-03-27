using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using OutModern.src.Admin.Interfaces;


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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lvProducts.DataSource = GetProducts1();
                lvProducts.DataBind();
                Page.DataBind();

            }
        }

        //TEST
        public class Product
        {
            public int Id { get; set; }
            public string Path { get; set; }
            public string Name { get; set; }
            public string Category { get; set; }
            public string Colors { get; set; } // Replace "..." with actual data if needed
            public decimal Price { get; set; }
            public int Quantity { get; set; }
            public string Status { get; set; }
            public int Reviews { get; set; }
        }

        private DataTable GetProducts1()
        {
            DataTable products = new DataTable();
            products.Columns.Add("Id", typeof(int));
            products.Columns.Add("Name", typeof(string));
            products.Columns.Add("Path", typeof(string));
            products.Columns.Add("Category", typeof(string));
            products.Columns.Add("Price", typeof(double));
            products.Columns.Add("Quantity", typeof(int));
            products.Columns.Add("Status", typeof(string));
            products.Columns.Add("Reviews", typeof(int));

            products.Rows.Add(
                1,
                "Premium Hoodie",
                "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png",
                "Hoodies",
                99.99,
                44,
                "Unavailable",
                1
                );
            products.Rows.Add(
                2,
                "Premium Hoodie",
                "~/images/product-img/hoodies/black-Hoodie/unisex-champion-tie-dye-hoodie-black-front-2-6116819deddd3.png",
                "Hoodies",
                199.99,
                22,
                "In Stock",
                9
                );
            products.Rows.Add(
               3,
               "Premium Hoodie",
               "~/images/product-img/hoodies/black-Hoodie/unisex-champion-tie-dye-hoodie-black-front-2-6116819deddd3.png",
               "Hoodies",
               299.99,
               12,
               "In Stock",
               4
               );

            return products;
        }
        //TEST
        protected void lvProducts_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                // Retrieve the data item
                //Product rowView = (Product)e.Item.DataItem;
                DataRowView rowView = (DataRowView)e.Item.DataItem;

                // Find the span control
                HtmlGenericControl statusSpan = (HtmlGenericControl)e.Item.FindControl("productStatus");
                string status = rowView["Status"].ToString();

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
            lvProducts.DataSource = GetProducts1();
            lvProducts.DataBind();
        }

        protected void lvProducts_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
        }

        public void FilterListView(string searchTerm)
        {

            lvProducts.DataSource = FilterDataTable(GetProducts1(), searchTerm);
            dpBottomProducts.SetPageProperties(0, dpBottomProducts.MaximumRows, false);
            lvProducts.DataBind();
        }
        private DataTable FilterDataTable(DataTable dataTable, string searchTerm)
        {
            string safeSearchTerm = searchTerm.Replace("'", "''");

            // Build filter expression with product fields
            string expression = string.Format(
                "Convert(Id, 'System.String') LIKE '%{0}%' OR " +
                "Name LIKE '%{0}%' OR " +
                "Category LIKE '%{0}%' OR " +
                "Convert(Price, 'System.String') LIKE '%{0}%' OR " +
                "Convert(Quantity, 'System.String') LIKE '%{0}%' OR " +
                "Status LIKE '%{0}%' OR " +
                "Convert(Reviews, 'System.String') LIKE '%{0}%'",
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

    }
}