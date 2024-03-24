using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.Staffs
{
    public partial class Staffs : System.Web.UI.Page
    {

        protected static readonly string StaffEdit = "StaffEdit";
        protected static readonly string StaffAdd = "StaffAdd";
        protected static readonly string StaffDetails = "StaffDetails";

        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { StaffEdit , "~/src/Admin/StaffEdit/StaffEdit.aspx" },
            { StaffAdd , "~/src/Admin/StaffAdd/StaffAdd.aspx" },
            { StaffDetails , "~/src/Admin/StaffDetails/StaffDetails.aspx" },
        };

        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                lvStaffs.DataSource = GetStaffs();
                lvStaffs.DataBind();

                Page.DataBind();
            }
        }

        private DataTable GetStaffs()
        {
            DataTable data = new DataTable();
            data.Columns.Add("AdminId", typeof(int));
            data.Columns.Add("AdminName", typeof(string));
            data.Columns.Add("AdminRole", typeof(string));
            data.Columns.Add("AdminStatus", typeof(string));

            data.Rows.Add(
                1,
                "Gan Zhi Ken",
                "Manager",
                "Active"
            );
            data.Rows.Add(
                2,
                "Ching Wei Hong",
                "ano",
                "Active"
            );
            data.Rows.Add(
               3,
               "Jian",
               "test",
                "Deleted"
            );

            return data;
        }

        protected void lvStaffs_PagePropertiesChanged(object sender, EventArgs e)
        {
            lvStaffs.DataSource = GetStaffs();
            lvStaffs.DataBind();
        }
    }
}