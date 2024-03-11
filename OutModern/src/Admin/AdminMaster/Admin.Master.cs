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

        protected string settingUrl = "#";
        protected string notificationUrl = "#";

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.DataBind();
        }
    }
}