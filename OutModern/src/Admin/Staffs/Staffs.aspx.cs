using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using OutModern.src.Admin.Interfaces;


namespace OutModern.src.Admin.Staffs
{
    public partial class Staffs : System.Web.UI.Page, IFilter
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

        private string ConnectionStirng = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lvStaffs.DataSource = GetStaffs();
                lvStaffs.DataBind();

                Page.DataBind();
            }
        }

        // Get Staffs
        private DataTable GetStaffs(string sortExpression = null, string sortDirection = "ASC")
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                connection.Open();
                string sqlQuery =
                    "SELECT Admin.AdminId, Admin.AdminFullName AS AdminName, Admin.AdminUsername, Admin.AdminEmail, Admin.AdminPhoneNo, UserStatus.UserStatusName AS AdminStatus, AdminRole.AdminRoleName AS AdminRole " +
                    "FROM Admin " +
                    "INNER JOIN UserStatus ON Admin.AdminStatusId = UserStatus.UserStatusId " +
                    "INNER JOIN AdminRole ON Admin.AdminRoleId = AdminRole.AdminRoleId ";

                if (!string.IsNullOrEmpty(sortExpression))
                {
                    sqlQuery += "ORDER BY " + sortExpression + " " + sortDirection;
                }

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }

        //store each column sorting state into viewstate
        private Dictionary<string, string> SortDirections
        {
            get
            {
                if (ViewState["SortDirections"] == null)
                {
                    ViewState["SortDirections"] = new Dictionary<string, string>();
                }
                return (Dictionary<string, string>)ViewState["SortDirections"];
            }
            set
            {
                ViewState["SortDirections"] = value;
            }
        }

        // Toggle Sorting
        private void toggleSortDirection(string columnName)
        {
            if (!SortDirections.ContainsKey(columnName))
            {
                SortDirections[columnName] = "DESC";
            }
            else
            {
                SortDirections[columnName] = SortDirections[columnName] == "ASC" ? "DESC" : "ASC";
            }
        }


        //update staff
        private int updateStaff(
            string adminId,
            string adminName,
            string adminUsername,
            string adminRole,
            string adminEmail,
            string adminPhoneNo,
            string adminStatus)
        {
            int numberRowEffected = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {

                connection.Open();

                string sqlQuery =
                    "UPDATE Admin " +

                    "SET AdminFullName = @adminName, " +
                    "AdminUsername = @adminUsername, " +
                    "AdminEmail = @adminEmail, " +
                    "AdminPhoneNo = @adminPhoneNo, " +
                    "AdminStatusId = @adminStatus, " +
                    "AdminRoleId = @adminRole " +

                    "WHERE AdminId = @adminId";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@adminName", adminName);
                    command.Parameters.AddWithValue("@adminUsername", adminUsername);
                    command.Parameters.AddWithValue("@adminEmail", adminEmail);
                    command.Parameters.AddWithValue("@adminPhoneNo", adminPhoneNo);
                    command.Parameters.AddWithValue("@adminStatus", adminStatus);
                    command.Parameters.AddWithValue("@adminRole", adminRole);
                    command.Parameters.AddWithValue("@adminId", adminId);

                    numberRowEffected = command.ExecuteNonQuery();
                }
            }

            return numberRowEffected;
        }


        //insert staff
        private int insertStaff(string adminName,
            string adminUsername,
            string adminRole,
            string adminEmail,
            string adminPhoneNo,
            string adminStatus)
        {
            int numberRowEffected = 0;

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {

                connection.Open();

                string sqlQuery =
                    "INSERT INTO Admin (AdminFullName, AdminUsername, AdminEmail, AdminPhoneNo, AdminStatusId, AdminRoleId) " +
                    "VALUES (@adminName, @adminUsername, @adminEmail, @adminPhoneNo, @adminStatus, @adminRole)";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    command.Parameters.AddWithValue("@adminName", adminName);
                    command.Parameters.AddWithValue("@adminUsername", adminUsername);
                    command.Parameters.AddWithValue("@adminEmail", adminEmail);
                    command.Parameters.AddWithValue("@adminPhoneNo", adminPhoneNo);
                    command.Parameters.AddWithValue("@adminStatus", adminStatus);
                    command.Parameters.AddWithValue("@adminRole", adminRole);

                    numberRowEffected = command.ExecuteNonQuery();
                }
            }

            return numberRowEffected;
        }


        //get all admin role for ddl
        private DataTable GetAdminRoles()
        {
            DataTable data = new DataTable();


            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                connection.Open();
                string sqlQuery =
                    "SELECT AdminRoleId, AdminRoleName " +
                    "FROM AdminRole";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }


        //get all admin status (user status) for ddl
        private DataTable GetStatus()
        {
            DataTable data = new DataTable();

            using (SqlConnection connection = new SqlConnection(ConnectionStirng))
            {
                connection.Open();
                string sqlQuery =
                    "SELECT UserStatusId, UserStatusName " +
                    "FROM UserStatus " +
                    "WHERE UserStatusName != 'Locked'";

                using (SqlCommand command = new SqlCommand(sqlQuery, connection))
                {
                    data.Load(command.ExecuteReader());
                }
            }

            return data;
        }


        //Search Bar Method
        public void FilterListView(string searchTerm)
        {
            lvStaffs.DataSource = FilterDataTable(GetStaffs(), searchTerm);
            lvStaffs.DataBind();
        }

        private DataTable FilterDataTable(DataTable dataTable, string searchTerm)
        {
            // Escape single quotes for safety
            string safeSearchTerm = searchTerm.Replace("'", "''");

            // Build the filter expression with all relevant fields
            string expression = string.Format(
                "Convert(AdminId, 'System.String') LIKE '%{0}%' OR " +
                "AdminName LIKE '%{0}%' OR " +
                "AdminUsername LIKE '%{0}%' OR " +
                "AdminRole LIKE '%{0}%' OR " +
                "AdminEmail LIKE '%{0}%' OR " +
                "AdminPhoneNo LIKE '%{0}%' OR " +
                "AdminStatus LIKE '%{0}%'",
                safeSearchTerm);

            // Filter the rows
            DataRow[] filteredRows = dataTable.Select(expression);

            // Create a new DataTable for the filtered results
            DataTable filteredDataTable = dataTable.Clone();

            // Import the filtered rows
            foreach (DataRow row in filteredRows)
            {
                filteredDataTable.ImportRow(row);
            }

            return filteredDataTable;
        }


        //
        // Events in page
        protected void lvStaffs_PagePropertiesChanged(object sender, EventArgs e)
        {
            lvStaffs.InsertItemPosition = InsertItemPosition.None;
            lvStaffs.EditIndex = -1;

            string sortExpression = ViewState["SortExpression"]?.ToString();
            lvStaffs.DataSource =
                sortExpression == null ?
                GetStaffs() :
                GetStaffs(sortExpression, SortDirections[sortExpression]);
            lvStaffs.DataBind();
        }

        protected void lbAddStaff_Click(object sender, EventArgs e)
        {
            lvStaffs.EditIndex = -1;
            lvStaffs.InsertItemPosition = InsertItemPosition.FirstItem;

            string sortExpression = ViewState["SortExpression"].ToString();
            lvStaffs.DataSource = GetStaffs(sortExpression, SortDirections[sortExpression]);
            lvStaffs.DataBind();

            // bind data source for Role ddl
            DropDownList ddlAddRole = lvStaffs.InsertItem.FindControl("ddlAddRole") as DropDownList;
            ddlAddRole.DataSource = GetAdminRoles();
            ddlAddRole.DataValueField = "AdminRoleId";
            ddlAddRole.DataTextField = "AdminRoleName";
            ddlAddRole.DataBind();

            // bind data source for Status ddl
            DropDownList ddlAddStatus = lvStaffs.InsertItem.FindControl("ddlAddStatus") as DropDownList;
            ddlAddStatus.DataSource = GetStatus();
            ddlAddStatus.DataValueField = "UserStatusId";
            ddlAddStatus.DataTextField = "UserStatusName";
            ddlAddStatus.DataBind();
        }

        protected void lvStaffs_ItemCanceling(object sender, ListViewCancelEventArgs e)
        {
            lvStaffs.InsertItemPosition = InsertItemPosition.None;
            lvStaffs.EditIndex = -1;
            string sortExpression = ViewState["SortExpression"].ToString();
            lvStaffs.DataSource = GetStaffs(sortExpression, SortDirections[sortExpression]);
            lvStaffs.DataBind();
        }

        protected void lvStaffs_ItemEditing(object sender, ListViewEditEventArgs e)
        {
            DataTable staffs = GetStaffs();

            int currentRowIndex = e.NewEditIndex + dpBottomStaffs.StartRowIndex;
            DataRow oriRow = staffs.Rows[currentRowIndex]; // get ori value to show as default value in ddl

            lvStaffs.DataSource = staffs;
            lvStaffs.InsertItemPosition = InsertItemPosition.None;
            lvStaffs.EditIndex = e.NewEditIndex;
            lvStaffs.DataBind();

            // bind data source for Role ddl
            DropDownList ddlEditRole = lvStaffs.Items[e.NewEditIndex].FindControl("ddlEditRole") as DropDownList;
            ddlEditRole.DataSource = GetAdminRoles();
            ddlEditRole.DataValueField = "AdminRoleId";
            ddlEditRole.DataTextField = "AdminRoleName";
            ddlEditRole.DataBind();

            // bind default value of admin role in ddl
            string defaultRole = oriRow["AdminRole"].ToString();
            ListItem roleItem = ddlEditRole.Items.FindByText(defaultRole);
            if (roleItem != null) roleItem.Selected = true;

            // bind data source for Status ddl
            DropDownList ddlEditStatus = lvStaffs.Items[e.NewEditIndex].FindControl("ddlEditStatus") as DropDownList;
            ddlEditStatus.DataSource = GetStatus();
            ddlEditStatus.DataValueField = "UserStatusId";
            ddlEditStatus.DataTextField = "UserStatusName";
            ddlEditStatus.DataBind();

            // bind default value of admin status in ddl
            string defaultStatus = oriRow["AdminStatus"].ToString();
            ListItem statusItem = ddlEditStatus.Items.FindByText(defaultStatus);
            if (statusItem != null) statusItem.Selected = true;

        }

        protected void lvStaffs_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            ListViewItem item = e.Item;

            // Find the TextBox controls within the item template
            TextBox txtAddAdminName = (TextBox)item.FindControl("txtAddAdminName");
            TextBox txtAddAdminUsername = (TextBox)item.FindControl("txtAddAdminUsername");
            DropDownList ddlAddRole = (DropDownList)item.FindControl("ddlAddRole");
            TextBox txtAddAdminEmail = (TextBox)item.FindControl("txtAddAdminEmail");
            TextBox txtAddAdminPhoneNo = (TextBox)item.FindControl("txtAddAdminPhoneNo");
            DropDownList ddlAddStatus = (DropDownList)item.FindControl("ddlAddStatus");

            // Get the values from the controls
            string addAdminName = txtAddAdminName.Text;
            string addAdminUsername = txtAddAdminUsername.Text;
            string addRole = ddlAddRole.SelectedValue;
            string addAdminEmail = txtAddAdminEmail.Text;
            string addAdminPhoneNo = txtAddAdminPhoneNo.Text;
            string addStatus = ddlAddStatus.SelectedValue;

            int noOfRowAffected = insertStaff(addAdminName, addAdminUsername, addRole, addAdminEmail, addAdminPhoneNo, addStatus);

            if (noOfRowAffected > 0)
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "alert",
                    $"document.addEventListener('DOMContentLoaded', ()=> alert('You has added Staff >> Name: {addAdminName}'))",
                    true);

                lvStaffs.InsertItemPosition = InsertItemPosition.None;
                lvStaffs.DataSource = GetStaffs();
                lvStaffs.DataBind();
            }
        }

        protected void lvStaffs_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            // Get the ListViewItem
            ListViewItem item = lvStaffs.Items[e.ItemIndex];
            if (item == null) return;

            // Find the TextBox controls within the edit item template
            Label lblAdminId = (Label)item.FindControl("lblAdminId");
            TextBox txtEditAdminName = (TextBox)item.FindControl("txtEditAdminName");
            TextBox txtEditAdminUsername = (TextBox)item.FindControl("txtEditAdminUsername");
            DropDownList ddlEditRole = (DropDownList)item.FindControl("ddlEditRole");
            TextBox txtEditAdminEmail = (TextBox)item.FindControl("txtEditAdminEmail");
            TextBox txtEditAdminPhoneNo = (TextBox)item.FindControl("txtEditAdminPhoneNo");
            DropDownList ddlEditStatus = (DropDownList)item.FindControl("ddlEditStatus");

            // Get the updated values from the controls
            string adminId = lblAdminId.Text;
            string updatedAdminName = txtEditAdminName.Text;
            string updatedAdminUsername = txtEditAdminUsername.Text;
            string updatedRole = ddlEditRole.SelectedValue;
            string updatedAdminEmail = txtEditAdminEmail.Text;
            string updatedAdminPhoneNo = txtEditAdminPhoneNo.Text;
            string updatedStatus = ddlEditStatus.SelectedValue;

            int noOfRowAffected = updateStaff(adminId, updatedAdminName, updatedAdminUsername, updatedRole, updatedAdminEmail, updatedAdminPhoneNo, updatedStatus);

            if (noOfRowAffected > 0)
            {
                Page.ClientScript.RegisterStartupScript(GetType(), "alert",
                    $"document.addEventListener('DOMContentLoaded', ()=> alert('You had updated Staff >> ID: {adminId}, Name: {updatedAdminName}'))",
                    true);

                lvStaffs.EditIndex = -1;
                lvStaffs.DataSource = GetStaffs();
                lvStaffs.DataBind();
            }
        }

        protected void lvStaffs_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType != ListViewItemType.DataItem) return;

            DataRowView rowView = (DataRowView)e.Item.DataItem;

            // Change the Status color based on txt
            HtmlGenericControl statusSpan = (HtmlGenericControl)e.Item.FindControl("userStatus");
            if (statusSpan != null)
            {
                string status = rowView["AdminStatus"].ToString();
                switch (status)
                {
                    case "Activated":
                        statusSpan.Attributes["class"] += " activated";
                        break;
                    case "Locked":
                        statusSpan.Attributes["class"] += " locked";
                        break;
                    case "Deleted":
                        statusSpan.Attributes["class"] += " deleted";
                        break;
                    default:
                        break;
                }
            }




        }

        protected void lvStaffs_Sorting(object sender, ListViewSortEventArgs e)
        {
            toggleSortDirection(e.SortExpression); // Toggle sorting direction for the clicked column


            ViewState["SortExpression"] = e.SortExpression; // used for retain the sorting

            // Re-bind the ListView with sorted data
            lvStaffs.DataSource = GetStaffs(e.SortExpression, SortDirections[e.SortExpression]);
            lvStaffs.DataBind();
        }

        protected void lvStaffs_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
        }
    }
}