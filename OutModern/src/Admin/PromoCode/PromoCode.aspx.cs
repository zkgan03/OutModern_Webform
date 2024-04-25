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
            lvPromoCodes.DataSource = GetPromoCodes();
            lvPromoCodes.InsertItemPosition = InsertItemPosition.FirstItem;
            lvPromoCodes.EditIndex = -1;
            lvPromoCodes.DataBind();
        }

        protected void lvPromoCodes_PagePropertiesChanged(object sender, EventArgs e)
        {
            lvPromoCodes.InsertItemPosition = InsertItemPosition.None;
            lvPromoCodes.EditIndex = -1;
            lvPromoCodes.DataSource = GetPromoCodes();
            lvPromoCodes.DataBind();
        }

        protected void lvPromoCodes_ItemCommand(object sender, ListViewCommandEventArgs e)
        {

        }

        protected void lvPromoCodes_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            lvPromoCodes.DataSource = GetPromoCodes();
            lvPromoCodes.EditIndex = e.NewEditIndex;
            lvPromoCodes.InsertItemPosition = InsertItemPosition.None;
            lvPromoCodes.DataBind();
        }

        protected void lvPromoCodes_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            lvPromoCodes.DataSource = GetPromoCodes();
            lvPromoCodes.InsertItemPosition = InsertItemPosition.None;
            lvPromoCodes.EditIndex = -1;
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

            // Define an array of static promo codes
            string[] staticPromoCodes = new string[] { "SUMMER2024", "AUTUMNSALE", "HOLIDAYGIFT", "BACKTOSCHOOL", "FLASHDEAL10", "LOYALTYBONUS", "FREESHIP50", "WEEKEND25", "HAPPYHOUR", "NEWYEAR23" };

            // Generate 10 dummy promo codes (using a loop up to the length of the array)
            for (int i = 0; i < Math.Min(10, staticPromoCodes.Length); i++)
            {
                DataRow drPromoCode = dtPromoCodes.NewRow();
                drPromoCode["PromoId"] = i + 1; // Assuming PromoId starts from 1

                // Use promo codes from the array
                drPromoCode["PromoCode"] = staticPromoCodes[i];

                // Set fixed values (replace with your desired values)
                drPromoCode["DiscountRate"] = 0.1; // 10% discount
                drPromoCode["StartDate"] = DateTime.Now.AddDays(-3); // Start date 3 days ago
                drPromoCode["EndDate"] = DateTime.Now.AddDays(7); // End date 7 days from now
                drPromoCode["Quantity"] = 500; // Quantity of 500

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