using OutModern.src.Client.Shipping;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Payment
{
    public class CartItem
    {
        public int ProductDetailId { get; set; }
        public int Quantity { get; set; }
    }

    public partial class Success : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int customerId = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the status parameter indicates success
                string status = Request.QueryString["status"];
                if (status == "success")
                {
                    // Retrieve the selected address from the session
                    Address selectedAddress = Session["SelectedAddressPayment"] as Address;
                    PaymentInfo paymentInfo = Session["PaymentInfo"] as PaymentInfo;

                    // Perform the database operation to insert data
                    InsertDataIntoDatabase(selectedAddress, paymentInfo);
                }
            }

        }

        private void InsertDataIntoDatabase(Address selectedAddress, PaymentInfo paymentInfo)
        {
            List<CartItem> cartItems = GetCartItems(customerId);

            if (cartItems != null && cartItems.Count > 0)
            {
                // Create a new order
                int orderId = CreateOrder(selectedAddress.AddressId, GetPaymentMethodId(paymentInfo));

                // Add cart items to order items
                foreach (var cartItem in cartItems)
                {
                    AddOrderItem(orderId, cartItem.ProductDetailId, cartItem.Quantity);
                    UpdateProductDetailQuantity(cartItem.ProductDetailId, cartItem.Quantity);
                }

                UpdateOrderSubtotal();

                // Clear the cart (optional)
                ClearCart(customerId);
            }

        }

        private void UpdateOrderSubtotal()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE [dbo].[Order] " +
                               "SET Subtotal = (SELECT SUM(P.UnitPrice * OI.Quantity) " +
                                              "FROM OrderItem OI " +
                                              "INNER JOIN ProductDetail PD ON OI.ProductDetailId = PD.ProductDetailId " +
                                              "INNER JOIN Product P ON PD.ProductId = P.ProductId " +
                                              "WHERE OI.OrderId = [Order].OrderId) " +
                               "WHERE CustomerId = @CustomerId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        private int GetPaymentMethodId(PaymentInfo paymentInfo)
        {
            int paymentMethodId = 0;

            // Insert data into the PaymentMethod table and retrieve the generated PaymentMethodId
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO [dbo].[PaymentMethod] (PaymentMethodName, CardNumber, Cvv, ExpDate) OUTPUT INSERTED.PaymentMethodId VALUES (@PaymentMethodName, @CardNumber, @Cvv, @ExpDate)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@PaymentMethodName", paymentInfo.PaymentMethod);
                // Add CardNumber parameter, handling null value
                if (paymentInfo.CardNumber != null)
                {
                    command.Parameters.AddWithValue("@CardNumber", paymentInfo.CardNumber);
                }
                else
                {
                    command.Parameters.AddWithValue("@CardNumber", DBNull.Value);
                }

                // Add CVV parameter, handling null value
                if (paymentInfo.CVV != null)
                {
                    command.Parameters.AddWithValue("@Cvv", paymentInfo.CVV);
                }
                else
                {
                    command.Parameters.AddWithValue("@Cvv", DBNull.Value);
                }

                // Add ExpirationDate parameter, handling null value
                if (paymentInfo.ExpirationDate != null)
                {
                    command.Parameters.AddWithValue("@ExpDate", paymentInfo.ExpirationDate);
                }
                else
                {
                    command.Parameters.AddWithValue("@ExpDate", DBNull.Value);
                }

                connection.Open();
                paymentMethodId = Convert.ToInt32(command.ExecuteScalar());
            }

            return paymentMethodId;
        }



        private List<CartItem> GetCartItems(int customerId)
        {
            List<CartItem> cartItems = new List<CartItem>();

            // Query the database to retrieve cart items for the customer
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM CartItem WHERE CartId IN (SELECT CartId FROM Cart WHERE CustomerId = @CustomerId)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CustomerId", customerId);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    CartItem item = new CartItem();
                    item.ProductDetailId = Convert.ToInt32(reader["ProductDetailId"]);
                    item.Quantity = Convert.ToInt32(reader["quantity"]);
                    // You might need to retrieve more details about the product here
                    cartItems.Add(item);
                }
            }

            return cartItems;
        }

        private int CreateOrder(int addressId, int paymentMethodId)
        {
            int orderId = 0;

            // Insert data into the Order table
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO [dbo].[Order] (CustomerId, AddressId, PaymentMethodId, PromoId, PaymentDatetime, OrderDatetime, Subtotal, OrderStatusId) VALUES (@CustomerId, @AddressId, @PaymentMethodId, @PromoId, @PaymentDatetime, @OrderDatetime, @Subtotal, @OrderStatusId); SELECT SCOPE_IDENTITY();";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@CustomerId", customerId);
                command.Parameters.AddWithValue("@AddressId", addressId);
                command.Parameters.AddWithValue("@PaymentMethodId", paymentMethodId);
                command.Parameters.AddWithValue("@PromoId", DBNull.Value); // Provide the value for PromoId
                command.Parameters.AddWithValue("@PaymentDatetime", DateTime.Now);
                command.Parameters.AddWithValue("@OrderDatetime", DateTime.Now);
                command.Parameters.AddWithValue("@Subtotal", 0); // You might need to calculate subtotal here
                command.Parameters.AddWithValue("@OrderStatusId", 1); // Replace 1 with the actual OrderStatusId

                connection.Open();
                orderId = Convert.ToInt32(command.ExecuteScalar());
            }

            return orderId;
        }

        private void AddOrderItem(int orderId, int productDetailId, int quantity)
        {
            // Insert data into the OrderItem table
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO [dbo].[OrderItem] (OrderId, ProductDetailId, quantity) VALUES (@OrderId, @ProductDetailId, @quantity)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@OrderId", orderId);
                command.Parameters.AddWithValue("@ProductDetailId", productDetailId);
                command.Parameters.AddWithValue("@quantity", quantity);

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();

            }
        }

        private void UpdateProductDetailQuantity(int productDetailId, int quantity)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {

                // Update the quantity of ProductDetail in the database
                string query = "UPDATE [dbo].[ProductDetail] SET Quantity = Quantity - @Quantity WHERE ProductDetailId = @ProductDetailId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Quantity", quantity);
                command.Parameters.AddWithValue("@ProductDetailId", productDetailId);

                connection.Open();
                command.ExecuteNonQuery();
                connection.Close();
            }
        }

        private void ClearCart(int customerId)
        {



            // Implement logic to clear the cart based on customerId
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM CartItem " +
                               "WHERE CartId = (SELECT CartId FROM Cart WHERE CustomerId = @CustomerId)";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE Cart " +
                               "SET Subtotal = 0 " + // Set subtotal to 0
                               "WHERE CustomerId = @CustomerId";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@CustomerId", customerId);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }

        }


        protected void Page_Unload(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Remove("PaymentInfo");
                Session.Remove("SelectedAddressPayment");
            }

        }

        protected void BtnViewOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/src/Client/UserProfile/ToShip.aspx");
        }

        protected void ButtonHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/src/Client/Home/Home.aspx");
        }

    }
}