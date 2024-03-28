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

                // Bind the dummy data to the ListView control
                ProductListView.DataSource = dummyData;
                ProductListView.DataBind();
            }
        }

        protected void TogglePaymentMethod(object sender, EventArgs e)
        {
            pnlPaymentDetails.Visible = !pnlPaymentDetails.Visible;
        }

        protected void ToggleBillingAddress(object sender, EventArgs e)
        {
            pnlBillingDetails.Visible = !pnlBillingDetails.Visible;
        }
    }
}