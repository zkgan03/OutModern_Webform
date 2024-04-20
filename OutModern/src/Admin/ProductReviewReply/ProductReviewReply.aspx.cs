﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.ProductReviewReply
{
    public partial class ProductReviewReply : System.Web.UI.Page
    {
        private string reviewId;
        private string ConnectionStirng = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            reviewId = Request.QueryString["ReviewId"];

            if (!IsPostBack)
            {
                initReview();
                Page.DataBind();
            }
        }

        private void initReview()
        {
            DataTable data = getReview();
            DataRow row = data.Rows[0];

            lblColor.Text = row["ReviewColor"].ToString();
            lblCustomerName.Text = row["CustomerName"].ToString();
            lblCustomerReview.Text = row["ReviewText"].ToString();
            lblCustomerReviewDateTime.Text = row["ReviewTime"].ToString();
            lblQuantity.Text = row["ReviewQuantity"].ToString();
            lblRating.Text = row["ReviewRating"].ToString();

            repeaterReviewReplies.DataSource = getReviewReplies();
            repeaterReviewReplies.DataBind();
        }

        //
        // DB operation
        //
        //get all Reviews
        private DataTable getReview()
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                connection.Open();
                string sqlQuery =
                     "Select CustomerFullname as CustomerName, ReviewDateTime as ReviewTime, Rating as ReviewRating, ColorName as ReviewColor, Quantity as ReviewQuantity, ReviewDescription as ReviewText " +
                     "From Review r, Customer c, ProductDetail pd, Product p, Color co, Size s " +
                     "Where r.CustomerId = c.CustomerId AND pd.ProductDetailId = r.ProductDetailId " +
                     "AND pd.ColorId = co.ColorId AND pd.ProductId = p.ProductId AND s.SizeId = pd.SizeId " +
                     "AND r.ReviewId = @reviewId";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@reviewId", reviewId);
                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }

        //get replies for particular id
        private DataTable getReviewReplies()
        {
            // Create a new DataTable to hold the dummy data
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                //ReplyTextReplyTimeAdminRoleAdminName
                connection.Open();
                string sqlQuery =
                    "Select AdminFullName as AdminName, AdminRoleName as AdminRole, Reply as ReplyText, DateTime as ReplyTime " +
                    "From [Admin] a, ReviewReply rr, Review r, AdminRole ar " +
                    "Where a.AdminId = rr.AdminId AND r.ReviewId = rr.ReviewId AND a.AdminRoleId = ar.AdminRoleId " +
                    "AND r.ReviewId = @reviewId;";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("reviewId", reviewId);

                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }

        // insert reply given in db
        private int upsertReply(string replyTextGiven, string adminId)
        {
            int affectedRow = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                connection.Open();

                int replynum = 0;
                string checkPreviousReply =
                    "Select * from " +
                    "ReviewReply " +
                    "WHERE ReviewId = @reviewId AND AdminId = @adminId";

                using (SqlCommand command = new SqlCommand(checkPreviousReply, connection))
                {
                    command.Parameters.AddWithValue("@reviewId", reviewId);
                    command.Parameters.AddWithValue("@adminId", adminId);

                    replynum = int.Parse(command.ExecuteScalar().ToString());
                }

                if (replynum > 0)
                {
                    string sqlQuery =
                        "Update ReviewReply " +
                        "SET DateTime = GETDATE(), Reply = @replyTextGiven " +
                        "WHERE ReviewId = @reviewId AND AdminId = @adminId;";

                    using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                    {
                        command.Parameters.AddWithValue("@reviewId", reviewId);
                        command.Parameters.AddWithValue("@adminId", adminId);
                        command.Parameters.AddWithValue("@replyTextGiven", replyTextGiven);

                        affectedRow = command.ExecuteNonQuery();
                    }

                }
                else
                {
                    string sqlQuery =
                        "INSERT into ReviewReply " +
                        "(ReviewId, AdminId, DateTime, Reply) " +
                        "values (@reviewId, @adminId, GETDATE(), @replyTextGiven);";

                    using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                    {
                        command.Parameters.AddWithValue("@reviewId", reviewId);
                        command.Parameters.AddWithValue("@adminId", adminId);
                        command.Parameters.AddWithValue("@replyTextGiven", replyTextGiven);

                        affectedRow = command.ExecuteNonQuery();
                    }
                }

            }

            return affectedRow;
        }

        //
        //Page event
        //
        protected void btnReplySend_Click(object sender, EventArgs e)
        {
            // TODO:  validation, no trim(), check no empty
            string replyTextGiven = txtReply.Text.Trim();
            string adminId = "1"; // dummy data

            if (replyTextGiven == "")
            {
                lblSendStatus.Text = "*Please Enter Some Text...";
            }

            int affectedRow = upsertReply(replyTextGiven, adminId);
            if (affectedRow > 0)
            {
                lblSendStatus.Text = "*Send Successfully";
                txtReply.Text = "";

                repeaterReviewReplies.DataSource = getReviewReplies();
                repeaterReviewReplies.DataBind();
            }
        }
    }
}