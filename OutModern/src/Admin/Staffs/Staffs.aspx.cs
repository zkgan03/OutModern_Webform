using System;
using System.Collections;
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
            data.Columns.Add("AdminUsername", typeof(string));
            data.Columns.Add("AdminRole", typeof(string));
            data.Columns.Add("AdminEmail", typeof(string));
            data.Columns.Add("AdminPhoneNo", typeof(string));
            data.Columns.Add("AdminStatus", typeof(string));

            data.Rows.Add(
                1,
                "Gan Zhi Ken",
                "zhikengan",
                "Manager",
                "trest@mail.com",
                "0123456789",
                "Active"
            );
            data.Rows.Add(
                2,
                "Ching Wei Hong",
                "veo123",
                "ano",
                "trest@mail.com",
                "0123456789",
                "Active"
            );
            data.Rows.Add(
               3,
               "Jian",
               "jiannnnnn",
               "test",
               "trest@mail.com",
                "0123456789",
                "Deleted"
            );

            return data;
        }

        protected void lvStaffs_PagePropertiesChanged(object sender, EventArgs e)
        {
            lvStaffs.DataSource = GetStaffs();
            lvStaffs.DataBind();
        }

        protected void lbAddStaff_Click(object sender, EventArgs e)
        {
            lvStaffs.InsertItemPosition = InsertItemPosition.FirstItem;
            lvStaffs.DataBind();
        }

        protected void lvStaffs_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                Response.Write("Edit");
                lvStaffs.EditIndex = e.Item.DisplayIndex;
                lvStaffs.DataBind(); // Rebind ListView to display edit template
            }

        }

        protected void lvStaffs_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            Response.Write("Cancelled");
            lvStaffs.InsertItemPosition = InsertItemPosition.None;
            lvStaffs.EditIndex = -1;
            lvStaffs.DataSource = GetStaffs();
            lvStaffs.DataBind();
        }

        protected void lvStaffs_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            Response.Write("Editing");
        }

        protected void lvStaffs_ItemInserting(object sender, ListViewInsertEventArgs e)
        {

        }

        protected void lbEdit_Click(object sender, EventArgs e)
        {

            Response.Write("Clicked");
        }
    }
}