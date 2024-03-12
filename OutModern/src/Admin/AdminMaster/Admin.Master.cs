using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.AdminMaster
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        // Side menu urls
        protected string dashboardUrl = "#";
        protected string staffUrl = "#";
        protected string marketUrl = "#";
        protected string ordersUrl = "#";
        protected string customerUrl = "#";
        protected string promoUrl = "#";
        protected string feedbackUrl = "#";

        protected string settingUrl = "#";
        protected string notificationUrl = "#";


        protected void Page_Load(object sender, EventArgs e)
        {
            Page.DataBind();
        }
    }
}