using OutModern.src.Admin.Customers;
using OutModern.src.Client.Shipping;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Payment
{
    public class PaymentInfo
    {
        public string PaymentMethod { get; set; }
        public string CardNumber { get; set; }
        public string ExpirationDate { get; set; }
        public string CVV { get; set; }
    }

    public partial class Payment : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        int customerId = 1; // REMEMBER TO CHANGE ID

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                // Check if the selected address is stored in the session
                if (Session["SelectedAddressPayment"] != null)
                {
                    // Retrieve the selected address from the session
                    Address selectedAddress = Session["SelectedAddressPayment"] as Address;

                    Session.Remove("SelectedAddressPayment");

                }


            }

            BindCartItems();
            UpdateSubtotalandGrandTotalLabel();
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
                    lblItemPrice.Text = $"RM{subtotal.ToString("N2")}";

                    decimal deliveryCost = decimal.Parse(lblDeliveryCost.Text.Replace("RM", ""));
                    decimal grandTotal = subtotal + deliveryCost;

                    lblTotal.Text = $"RM{grandTotal.ToString("N2")}";
                }
                else
                {
                    // If subtotal is null, display 0.00
                    lblTotal.Text = "RM0.00";
                }
            }
        }

        protected void ButtonHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/src/Client/Home/Home.aspx");
        }

        protected void BtnViewOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/src/Client/UserProfile/ToShip.aspx");
        }

        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {
            string paymentMethod;

            if (paypal.Checked)
            {

                paymentMethod = "Paypal";
                // total;
                decimal totalAmount = 50;

                //payment request
                string returnURL = "http://localhost:44338/src/Client/Payment/Success.aspx?status=success";
                string cancelURL = "http://localhost:44338/src/Client/Cart/Cart.aspx";
                string currency = "MYR";
                string paypalSandboxEmail = "sb-olaow30210165@business.example.com";

                string paypalSandboxURL = $"https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_xclick&business={paypalSandboxEmail}&currency_code={currency}&amount={totalAmount}&return={returnURL}&cancel_return={cancelURL}";

                PaymentInfo creditCardInfo = new PaymentInfo
                {
                    PaymentMethod = paymentMethod,
                };
                Session["PaymentInfo"] = creditCardInfo;
                // Redirect the user to PayPal
                Response.Redirect(paypalSandboxURL);

            }
            else
            {
                //creditcard

                // Retrieve credit card information from form fields
                paymentMethod = "Credit Card";
                string cardNumber = txtCardNumber.Text.Trim();
                string expirationDate = txtExpirationDate.Text.Trim();
                string cvv = txtCvv.Text.Trim();

                // Create an instance of CreditCardInfo and store the card information
                PaymentInfo creditCardInfo = new PaymentInfo
                {
                    PaymentMethod = paymentMethod,
                    CardNumber = cardNumber,
                    ExpirationDate = expirationDate,
                    CVV = cvv
                };

                // Store credit card information into session variable
                Session["PaymentInfo"] = creditCardInfo;

                // Redirect or perform any other action after storing the payment information
                Response.Redirect("PaymentConfirmationPage.aspx");

            }
        }

        protected void PaymentMethod_CheckedChanged(object sender, EventArgs e)
        {

            lblCreditCardContainer.CssClass = lblCreditCardContainer.CssClass.Replace(" selected", "");
            lblPaypalContainer.CssClass = lblPaypalContainer.CssClass.Replace(" selected", "");

            // Handle the CheckedChanged event as before
            if (creditCard.Checked)
            {
                // Show credit card payment details
                paymentDetails.Style["display"] = "block";
                lblCreditCardContainer.CssClass += " selected";
            }
            else
            {
                // Hide payment details for Paypal
                paymentDetails.Style["display"] = "none";
                lblPaypalContainer.CssClass += " selected";
            }
        }




    }
}