using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Client.Comment
{
    public partial class Comment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmitComment_Click(object sender, EventArgs e)
        {
            string selectedRating = ddlRating.SelectedValue;
            string commentText = txtComment.Text;
        }
    }
}