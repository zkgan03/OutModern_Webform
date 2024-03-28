using OutModern.src.Admin.Interfaces;
using OutModern.src.Admin.Staffs;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.PromoCode
{
    public partial class PromoCode : System.Web.UI.Page, IFilter
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lvPromoCodes.DataSource = GetPromoCodes();
                lvPromoCodes.DataBind();
            }
        }

        protected void lbAddPromoCode_Click(object sender, EventArgs e)
        {
            lvPromoCodes.InsertItemPosition = InsertItemPosition.FirstItem;
            lvPromoCodes.DataBind();
        }

        protected void lvPromoCodes_PagePropertiesChanged(object sender, EventArgs e)
        {
            lvPromoCodes.DataSource = GetPromoCodes();
            lvPromoCodes.DataBind();
        }

        protected void lvPromoCodes_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void lvPromoCodes_ItemEditing(object sender, ListViewEditEventArgs e)
        {

        }

        protected void lvPromoCodes_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            lvPromoCodes.DataSource = GetPromoCodes();
            lvPromoCodes.InsertItemPosition = InsertItemPosition.None;
            lvPromoCodes.DataBind();
        }

        protected void lvPromoCodes_ItemInserting(object sender, ListViewInsertEventArgs e)
        {

        }

        //Dummy data
        protected DataTable GetPromoCodes()
        {
            DataTable dtPromoCodes = new DataTable();
            dtPromoCodes.Columns.AddRange(new DataColumn[] {
                new DataColumn("PromoId", typeof(int)),
                new DataColumn("PromoCode", typeof(string)),
                new DataColumn("DiscountRate", typeof(double)),
                new DataColumn("StartDate", typeof(DateTime)),
                new DataColumn("EndDate", typeof(DateTime)),
                new DataColumn("Quantity", typeof(int))
              });

            // Generate 10 dummy promo codes
            Random random = new Random();
            for (int i = 0; i < 10; i++)
            {
                DataRow drPromoCode = dtPromoCodes.NewRow();
                drPromoCode["PromoId"] = i + 1; // Assuming PromoId starts from 1
                drPromoCode["PromoCode"] = $"PROMO{i + 1:000}"; // Generate 3-digit codes
                drPromoCode["DiscountRate"] = random.NextDouble() * 0.5 + 0.05; // Random discount rate between 5% and 55%
                drPromoCode["StartDate"] = DateTime.Now.AddDays(-random.Next(7)); // Start date within the last week
                drPromoCode["EndDate"] = (DateTime)drPromoCode["StartDate"] + TimeSpan.FromDays(random.Next(14));
                drPromoCode["Quantity"] = random.Next(100, 1001); // Quantity between 100 and 1000

                dtPromoCodes.Rows.Add(drPromoCode);
            }

            return dtPromoCodes;
        }

        public void FilterListView(string searchTerm)
        {
            lvPromoCodes.DataSource = FilterDataTable(GetPromoCodes(), searchTerm);
            lvPromoCodes.DataBind();
        }

        private DataTable FilterDataTable(DataTable dataTable, string searchTerm)
        {
            // Escape single quotes for safety
            string safeSearchTerm = searchTerm.Replace("'", "''");

            // Build the filter expression with relevant fields
            string expression = string.Format(
                "Convert(PromoId, 'System.String') LIKE '%{0}%' OR " +
                "PromoCode LIKE '%{0}%' OR " +
                "Convert(DiscountRate, 'System.String') LIKE '%{0}%' OR " +
                "Convert(StartDate, 'System.String') LIKE '%{0}%' OR " +
                "Convert(EndDate, 'System.String') LIKE '%{0}%' OR " +
                "Convert(Quantity, 'System.String') LIKE '%{0}%' ",
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