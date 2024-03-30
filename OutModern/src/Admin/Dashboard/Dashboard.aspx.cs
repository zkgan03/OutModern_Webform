using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.Dashboard
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected string lineData;
        protected void Page_Load(object sender, EventArgs e)
        {
                PopulateSalesChart();  
        }

        private void PopulateSalesChart()
        {
            DataTable data = new DataTable();
            data.Columns.Add("Date", typeof(long)); // Change to long for milliseconds since epoch
            data.Columns.Add("Sales", typeof(decimal));

            Random random = new Random();
            DateTime endDate = DateTime.Now; // Today
            DateTime startDate = endDate.AddMonths(-11); // Start date 12 months ago

            for (DateTime date = startDate; date.CompareTo(endDate) <= 0; date = date.AddMonths(1))
            {
                long timestamp = (long)date.ToUniversalTime().Subtract(new DateTime(1970, 1, 1)).TotalMilliseconds; // Convert to milliseconds since epoch
                decimal sales = random.Next(100, 1000) + (decimal)random.NextDouble();
                data.Rows.Add(timestamp, sales);
            }

            lineData = "[";
            foreach (DataRow row in data.Rows)
            {
                lineData += "[" + row["Date"] + "," + row["Sales"] + "],";
            }
            lineData = lineData.Remove(lineData.Length - 1) + "]";
        }
    }
}