using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.StaffDetails
{
    public partial class StaffDetails : System.Web.UI.Page
    {
        protected static readonly string StaffEdit = "StaffEdit";

        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { StaffEdit , "~/src/Admin/StaffEdit/StaffEdit.aspx" }
        };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.DataBind();
            }
        }
    }
}