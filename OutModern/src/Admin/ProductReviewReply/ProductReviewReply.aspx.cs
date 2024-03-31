using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.ProductReviewReply
{
    public partial class ProductReviewReply : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                repeaterReviewReplies.DataSource = GetReplies();
                repeaterReviewReplies.DataBind();
            }
        }

        private DataTable GetReplies()
        {
            DataTable replies = new DataTable();

            replies.Columns.Add("AdminName", typeof(string));
            replies.Columns.Add("AdminRole", typeof(string));
            replies.Columns.Add("ReviewReplyDateTime", typeof(DateTime));
            replies.Columns.Add("ReviewReply", typeof(string));

            replies.Rows.Add("Gan", "Admin", DateTime.Now, "Hi, please edit your question...");
            replies.Rows.Add("Su", "Associate", DateTime.Now, "This should not be a problem");


            return replies;
        }
    }
}