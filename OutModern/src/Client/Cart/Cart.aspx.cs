using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Cart
{
    public partial class Cart : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int customerId = 1; // REMEMBER TO CHANGE ID
        protected void Page_Load(object sender, EventArgs e)
        {

            UpdateSubtotalandGrandTotalLabel();
            BindCartItems();

        }

        private void UpdateSubtotalandGrandTotalLabel()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Subtotal FROM Cart WHERE CustomerId = @CustomerId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                con.Open();
                object result = cmd.ExecuteScalar();
                con.Close();

                // Check if the result is not null
                if (result != null)
                {
                    decimal subtotal = Convert.ToDecimal(result);
                    lblSubtotal.Text = $"RM{subtotal.ToString("N2")}";

                    decimal deliveryCost = decimal.Parse(lblDeliveryCost.Text.Replace("RM", ""));
                    decimal grandTotal = subtotal + deliveryCost;

                    lblGrandTotal.Text = $"RM{grandTotal.ToString("N2")}";
                }
                else
                {
                    // If subtotal is null, display 0.00
                    lblSubtotal.Text = "RM0.00";
                }
            }
        }

        private void BindCartItems()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT CI.ProductDetailId, CI.Quantity, PD.ColorId, PD.SizeId, PD.ProductId, " +
                               "P.ProductName, P.UnitPrice, (CI.Quantity * P.UnitPrice) AS Subtotal, " +
                               "(SELECT TOP 1 PI.Path FROM ProductImage PI WHERE PI.ProductDetailId = PD.ProductDetailId) AS ProductImageUrl, " +
                               "S.SizeName, C.ColorName " +
                               "FROM CartItem CI " +
                               "INNER JOIN ProductDetail PD ON CI.ProductDetailId = PD.ProductDetailId " +
                               "INNER JOIN Product P ON PD.ProductId = P.ProductId " +
                               "INNER JOIN Size S ON PD.SizeId = S.SizeId " +
                               "INNER JOIN Color C ON PD.ColorId = C.ColorId " +
                               "WHERE CI.CartId = (SELECT CartId FROM Cart WHERE CustomerId = @CustomerId)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                con.Open();
                da.Fill(dt);
                con.Close();

                ProductListView.DataSource = dt;
                ProductListView.DataBind();
            }
        }





        protected void btnDecrement_Click(object sender, EventArgs e)
        {
            LinkButton btnDecrement = (LinkButton)sender;
            ListViewItem item = (ListViewItem)btnDecrement.NamingContainer;


            HiddenField hidProductDetailId = (HiddenField)item.FindControl("hidProductDetailId");
            int productDetailId = int.Parse(hidProductDetailId.Value);
            // Retrieve the current quantity from the ListView item
            TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");
            int currentQuantity = int.Parse(txtQuantity.Text);

            // Ensure the quantity doesn't go below 1
            if (currentQuantity > 1)
            {
                // Decrement the quantity by 1
                currentQuantity--;

                // Update the quantity in the UI
                txtQuantity.Text = currentQuantity.ToString();


                UpdateQuantityInDatabase(productDetailId, currentQuantity, customerId);

                Response.Redirect(Request.RawUrl);

            }
            else
            {
                btnDecrement.Enabled = false;
            }
        }

        protected void btnIncrement_Click(object sender, EventArgs e)
        {
            LinkButton btnIncrement = (LinkButton)sender;
            ListViewItem item = (ListViewItem)btnIncrement.NamingContainer;

            // Retrieve the current quantity from the ListView item
            TextBox txtQuantity = (TextBox)item.FindControl("txtQuantity");
            int currentQuantity = int.Parse(txtQuantity.Text);


            HiddenField hidProductDetailId = (HiddenField)item.FindControl("hidProductDetailId");
            int productDetailId = int.Parse(hidProductDetailId.Value);
            // Retrieve the maximum available stock for the product (you can retrieve this from the database)
            int maxStock = GetMaxStock(productDetailId);

            // Ensure the quantity doesn't exceed the available stock
            if (currentQuantity < maxStock)
            {
                // Increment the quantity by 1
                currentQuantity++;

                // Update the quantity in the UI
                txtQuantity.Text = currentQuantity.ToString();


                UpdateQuantityInDatabase(productDetailId, currentQuantity, customerId);

                Response.Redirect(Request.RawUrl);
            }
            else
            {
                btnIncrement.Enabled = false;
            }
        }

        private void UpdateQuantityInDatabase(int productDetailId, int newQuantity, int customerId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE CartItem " +
                               "SET Quantity = @NewQuantity " +
                               "WHERE CartId = (SELECT CartId FROM Cart WHERE CustomerId = @CustomerId) " +
                               "AND ProductDetailId = @ProductDetailId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@NewQuantity", newQuantity);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);
                cmd.Parameters.AddWithValue("@ProductDetailId", productDetailId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                // Recalculate and update the subtotal in the Cart table
                UpdateCartSubtotal(customerId);
            }
        }



        private int GetMaxStock(int productDetailId)
        {
            int maxStock = 0;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Quantity AS MaxStock FROM ProductDetail WHERE ProductDetailId = @ProductDetailId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductDetailId", productDetailId);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    // Check if the MaxStock value is not DBNull
                    if (!reader.IsDBNull(reader.GetOrdinal("MaxStock")))
                    {
                        maxStock = reader.GetInt32(reader.GetOrdinal("MaxStock"));
                    }
                }

                reader.Close();
                con.Close();
            }

            return maxStock;
        }


        protected void btnDelete_Click(object sender, EventArgs e)
        {
            LinkButton btnDelete = (LinkButton)sender;
            ListViewItem item = (ListViewItem)btnDelete.NamingContainer;

            // Extracting the ProductDetailId from the ListView item
            HiddenField hidProductDetailId = (HiddenField)item.FindControl("hidProductDetailId");
            int productDetailId = Convert.ToInt32(hidProductDetailId.Value);

            DeleteCartItem(productDetailId, customerId);

            // Rebind the cart items to reflect the changes
            BindCartItems();

            Response.Redirect(Request.RawUrl);
        }


        private void DeleteCartItem(int productDetailId, int customerId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM CartItem " +
                               "WHERE ProductDetailId = @ProductDetailId " +
                               "AND CartId = (SELECT CartId FROM Cart WHERE CustomerId = @CustomerId)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@ProductDetailId", productDetailId);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();

                // Recalculate and update the subtotal in the Cart table
                UpdateCartSubtotal(customerId);
            }
        }

        private void UpdateCartSubtotal(int customerId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE Cart " +
                               "SET Subtotal = (SELECT SUM(P.UnitPrice * CI.Quantity) " +
                                              "FROM CartItem CI " +
                                              "INNER JOIN ProductDetail PD ON CI.ProductDetailId = PD.ProductDetailId " +
                                              "INNER JOIN Product P ON PD.ProductId = P.ProductId " +
                                              "WHERE CI.CartId = Cart.CartId) " +
                               "WHERE CustomerId = @CustomerId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void btnApply_Click(object sender, EventArgs e)
        {

        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {

            if (true)
            {


                // Redirect to the Shipping page
                Response.Redirect("~/src/Client/Shipping/Shipping.aspx");
            }
            else
            {
                // Cart is empty, disable the button
                btnCheckout.Enabled = false;

                // Optionally, you can also display a message to the user
                // lblEmptyCart.Visible = true;
            }
        }

    }


}