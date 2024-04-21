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

            // Step 1: Calculate total amount (you need to implement this logic)
            decimal totalAmount = 50;

            // Step 2: Set up the PayPal payment request
            string returnURL = "http://localhost:44338/src/Client/Home/Home.aspx?status=success"; 
            string cancelURL = "http://localhost:44338/src/Client/Cart/Cart.aspx"; 
            string currency = "MYR";
            string paypalSandboxEmail = "sb-olaow30210165@business.example.com";

            string paypalSandboxURL = $"https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_xclick&business={paypalSandboxEmail}&currency_code={currency}&amount={totalAmount}&return={returnURL}&cancel_return={cancelURL}";

            // Redirect the user to PayPal
            Response.Redirect(paypalSandboxURL);
        }

        protected void LabelContainer_Click(object sender, EventArgs e)
        {
            // Get the label container that triggered the click event
            Label clickedLabelContainer = (Label)sender;

            // Remove 'selected' class from all label containers
            lblCreditCardContainer.CssClass = lblCreditCardContainer.CssClass.Replace(" selected", "");
            lblPaypalContainer.CssClass = lblPaypalContainer.CssClass.Replace(" selected", "");

            // Add 'selected' class to the clicked label container
            clickedLabelContainer.CssClass += " selected";

            // Trigger the CheckedChanged event for the corresponding radio button
            if (clickedLabelContainer == lblCreditCardContainer)
            {
                creditCard.Checked = true;
                paypal.Checked = false;
                PaymentMethod_CheckedChanged(creditCard, EventArgs.Empty);
            }
            else if (clickedLabelContainer == lblPaypalContainer)
            {
                paypal.Checked = true;
                creditCard.Checked = false;
                PaymentMethod_CheckedChanged(paypal, EventArgs.Empty);
            }
        }

        protected void PaymentMethod_CheckedChanged(object sender, EventArgs e)
        {
            // Handle the CheckedChanged event as before
            if (creditCard.Checked)
            {
                // Show credit card payment details
                paymentDetails.Style["display"] = "block";

            }
            else if (paypal.Checked)
            {
                // Hide payment details for Paypal
                paymentDetails.Style["display"] = "none";

            }
        }



    }
}