using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.Staffs
{
    public partial class Staffs : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Identi
            if (User.IsInRole("BUILTIN\\Administrators"))
                Response.Write("You are an Admin");
            else if (User.IsInRole("BUILTIN\\Users"))
                Response.Write("You are a User");
            else
                Response.Write("Invalid user");
        }
    }
}