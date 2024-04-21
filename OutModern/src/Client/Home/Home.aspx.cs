using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Home
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the status parameter indicates success
                string status = Request.QueryString["status"];
                if (status == "success")
                {
                    // Perform the database operation to insert data
                    InsertDataIntoDatabase();
                }
            }
        }

        private void InsertDataIntoDatabase()
        {
            // Your logic to insert data into the database
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