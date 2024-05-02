using OutModern.src.Admin.PromoCode;
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
    public class PromoTable
    {
        public int PromoId { get; set; }
        public string PromoCode { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public int DiscountRate { get; set; }
        public int Quantity { get; set; }

        // Add any additional properties or methods if needed
    }

    public partial class Cart : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int customerId = 1; // REMEMBER TO CHANGE ID
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["PromoCode"] = null;
                
                
            }

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
                    decimal discountAmount = 0;
                    decimal subtotal = Convert.ToDecimal(result);
                    lblSubtotal.Text = $"RM{subtotal.ToString("N2")}";

                    decimal deliveryCost = decimal.Parse(lblDeliveryCost.Text.Replace("RM", ""));

                    PromoTable promoCode = Session["PromoCode"] as PromoTable;

                    if(promoCode  != null)
                    {
                        // Update the UI with the discount rate
                        lblDiscountRate.Text = $"({promoCode.DiscountRate}%)";

                        // Calculate the discount amount
                        discountAmount = subtotal * ((decimal)promoCode.DiscountRate / 100);

                        // Update the UI with the discount amount
                        lblDiscount.Text = $"RM{discountAmount.ToString("N2")}";
                    }
                    else
                    {
                        lblDiscountRate.Text = "(- 0%)";
                        lblDiscount.Text = "RM0.00";
                    }

                    decimal grandTotal = subtotal + deliveryCost - discountAmount;

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

                UpdateSubtotalandGrandTotalLabel();
                BindCartItems();
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

                UpdateSubtotalandGrandTotalLabel();
                BindCartItems();
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
                               "SET Subtotal = (SELECT COALESCE(SUM(P.UnitPrice * CI.Quantity), 0) " +
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
            string discountCode = txtDiscountCode.Text.Trim();

            // Retrieve the promo code details from the database
            PromoTable promoCode = GetPromoCode(discountCode);

            if (promoCode != null)
            {
                Session["PromoCode"] = promoCode;

                // Update the UI with the discount rate
                lblDiscountRate.Text = $"({promoCode.DiscountRate}%)";

                decimal subtotal = GetCartSubtotal(customerId);
                // Calculate the discount amount
                decimal discountAmount = subtotal * ((decimal)promoCode.DiscountRate / 100);

                // Update the UI with the discount amount
                lblDiscount.Text = $"RM{discountAmount.ToString("N2")}";
            }
            else
            {
                lblDiscountRate.Text = "(Invalid code)";
                // lblDiscount.Text = "RM0.00";
            }

            UpdateSubtotalandGrandTotalLabel();
        }

        private PromoTable GetPromoCode(string discountCode)
        {
            PromoTable promoCode = null;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM PromoCode WHERE PromoCode = @DiscountCode";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@DiscountCode", discountCode);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    promoCode = new PromoTable
                    {
                        PromoId = reader.GetInt32(reader.GetOrdinal("PromoId")),
                        PromoCode = reader.GetString(reader.GetOrdinal("PromoCode")),
                        StartDate = reader.GetDateTime(reader.GetOrdinal("StartDate")),
                        EndDate = reader.GetDateTime(reader.GetOrdinal("EndDate")),
                        DiscountRate = reader.GetInt32(reader.GetOrdinal("DiscountRate")),
                        Quantity = reader.GetInt32(reader.GetOrdinal("Quantity"))
                    };
                }

                reader.Close();
                con.Close();
            }

            return promoCode;
        }

        private decimal GetCartSubtotal(int customerId)
        {
            decimal subtotal = 0;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Subtotal FROM Cart WHERE CustomerId = @CustomerId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                con.Open();
                object result = cmd.ExecuteScalar();

                if (result != null && result != DBNull.Value)
                {
                    subtotal = Convert.ToDecimal(result);
                }

                con.Close();
            }

            return subtotal;
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            // Check if the cart is empty
            bool cartIsEmpty = IsCartEmpty(customerId);

            if (!cartIsEmpty)
            {
                // Redirect to the Shipping page
                Response.Redirect("~/src/Client/Shipping/Shipping.aspx");
            }
            else
            {
                // Cart is empty, disable the button
                btnCheckout.Enabled = false;
            }
        }

        private bool IsCartEmpty(int customerId)
        {
            bool cartIsEmpty = true;

            // Check if the cart has any items
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM CartItem WHERE CartId = (SELECT CartId FROM Cart WHERE CustomerId = @CustomerId)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                con.Open();
                int itemCount = (int)cmd.ExecuteScalar();
                con.Close();

                // If item count is greater than 0, cart is not empty
                if (itemCount > 0)
                {
                    cartIsEmpty = false;
                }
            }

            return cartIsEmpty;
        }


    }


}