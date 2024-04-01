using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
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
                // Retrieve the dummy data from the session variable
                DataTable dummyData = (DataTable)Session["DummyData"];

                // Retrieve the subtotal value from session
                decimal subtotal = (decimal)Session["Subtotal"];
                decimal delivery = 5;
                if (subtotal > 100)
                {
                    delivery = 0;
                    lblDeliveryCost.Text = "RM0.00";
                }
                decimal tax = (subtotal * 6 / 100);
                decimal total = subtotal + tax + delivery;



                lblItemPrice.Text = "RM" + subtotal.ToString("N2");
                lblTax.Text = "RM" + (subtotal * 6 / 100).ToString("N2");
                lblTotal.Text = "RM" + total.ToString("N2");

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
            Response.Redirect("~/src/Client/Home/Home.aspx");
        }

        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {
            // Prevent the default form submission behavior
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

    }
}