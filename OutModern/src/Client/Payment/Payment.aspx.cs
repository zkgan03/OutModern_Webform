using OutModern.src.Client.Shipping;
using System;
using System.Collections.Generic;
using System.Data;
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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                // Check if the selected address is stored in the session
                if (Session["SelectedAddressPayment"] != null)
                {
                    // Retrieve the selected address from the session
                    Address selectedAddress = Session["SelectedAddressPayment"] as Address;

                }

                // Retrieve the dummy data from the session variable
                DataTable dummyData = (DataTable)Session["DummyData"];

                // Retrieve the subtotal value from session
                //decimal subtotal = (decimal)Session["Subtotal"];
                //decimal delivery = 5;
                //if (subtotal > 100)
                //{
                //    delivery = 0;
                //    lblDeliveryCost.Text = "RM0.00";
                //}
                //decimal tax = (subtotal * 6 / 100);
                //decimal total = subtotal + tax + delivery;



                //lblItemPrice.Text = "RM" + subtotal.ToString("N2");
                //lblTax.Text = "RM" + (subtotal * 6 / 100).ToString("N2");
                //lblTotal.Text = "RM" + total.ToString("N2");

                // Bind the dummy data to the ListView control
                ProductListView.DataSource = dummyData;
                ProductListView.DataBind();
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
                string returnURL = "http://localhost:44338/src/Client/Home/Home.aspx?status=success";
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