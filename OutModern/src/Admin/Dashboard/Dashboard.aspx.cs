using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.Dashboard
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected string lineData;
        private string ConnectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

            initPageData();
        }

        private void initPageData()
        {
            string formatIntegerString = "# ##0";

            lblTotalCustomer.Text = getTotalCustomer().ToString(formatIntegerString);
            lblMonthOrders.Text = getMonthOrders().ToString(formatIntegerString);
            lblNewOrders.Text = getTodayOrders().ToString(formatIntegerString);
            lblMonthCancelled.Text = getMonthCancelled().ToString(formatIntegerString);
            lblTodayCancelled.Text = getTodayCancelled().ToString(formatIntegerString);
            lblTodayCancelled.Text = getTodayCancelled().ToString(formatIntegerString);
            lblTodayReviews.Text = getTodayReviews().ToString(formatIntegerString);

            lblOverallRating.Text = getOverallRating().ToString("0.0");

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

        //
        //db operation
        //

        //get total customer registered
        private int getTotalCustomer()
        {
            int total = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {

                connection.Open();
                string sqlQuery =
                    "Select COUNT(CustomerId) as Total " +
                    "FROM Customer ";
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    total = int.Parse(command.ExecuteScalar().ToString());
                }

            }

            return total;
        }

        // get this month orders, and it is not cancelled 
        private int getMonthOrders()
        {
            int total = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string sqlQuery =
                    "Select COUNT(OrderId) as Total " +
                    "FROM [Order], OrderStatus " +
                    "WHERE MONTH(OrderDatetime) = MONTH(GETDATE()) " +
                    "AND YEAR(OrderDatetime) = YEAR(GETDATE()) " +
                    "AND OrderStatus.OrderStatusId = [Order].OrderStatusId " +
                    "AND OrderStatusName != 'Cancelled' ";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    total = int.Parse(command.ExecuteScalar().ToString());
                }

            }

            return total;
        }

        // get today orders, and it is not cancelled 
        private int getTodayOrders()
        {
            int total = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string sqlQuery =
                    "Select COUNT(OrderId) as Total " +
                    "FROM [Order], OrderStatus " +
                    "WHERE CONVERT(date, OrderDateTime) = CONVERT(date, GETDATE()) " +
                    "AND OrderStatus.OrderStatusId = [Order].OrderStatusId " +
                    "AND OrderStatusName != 'Cancelled' ";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    total = int.Parse(command.ExecuteScalar().ToString());
                }
            }

            return total;
        }

        // get this month orders which is cancelled 
        private int getMonthCancelled()
        {
            int total = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string sqlQuery =
                    "Select COUNT(OrderId) as Total " +
                    "FROM [Order], OrderStatus " +
                    "WHERE MONTH(OrderDatetime) = MONTH(GETDATE()) " +
                    "AND YEAR(OrderDatetime) = YEAR(GETDATE()) " +
                    "AND OrderStatus.OrderStatusId = [Order].OrderStatusId " +
                    "AND OrderStatusName = 'Cancelled' ";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    total = int.Parse(command.ExecuteScalar().ToString());
                }

            }

            return total;
        }

        // get today orders which is cancelled 
        private int getTodayCancelled()
        {
            int total = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string sqlQuery =
                    "Select COUNT(OrderId) as Total " +
                    "FROM [Order], OrderStatus " +
                    "WHERE CONVERT(date, OrderDateTime) = CONVERT(date, GETDATE()) " +
                    "AND OrderStatus.OrderStatusId = [Order].OrderStatusId " +
                    "AND OrderStatusName != 'Cancelled' ";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    total = int.Parse(command.ExecuteScalar().ToString());
                }
            }

            return total;
        }

        //get total reviews given to all product
        private int getTodayReviews()
        {
            int total = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {

                connection.Open();
                string sqlQuery =
                    "Select COUNT(ReviewId) as Total " +
                    "FROM Review ";
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    total = int.Parse(command.ExecuteScalar().ToString());
                }

            }

            return total;
        }

        //get and calculate overall rating for all products
        private double getOverallRating()
        {
            double average = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                connection.Open();
                string sqlQuery =
                    "Select AVG(Rating) as Average " +
                    "FROM Review ";
                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    average = double.Parse(command.ExecuteScalar().ToString());
                }
            }

            return average;
        }

    }
}