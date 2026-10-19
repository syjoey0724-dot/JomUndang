using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JomUndang
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Dynamic Menu based on Role
            if (Session["Role"] != null)
            {
                Label lblDashboardLink = (Label)LoginView1.FindControl("lblDashboardLink");

                if (lblDashboardLink != null)
                {
                    if (Session["Role"].ToString() == "Customer")
                    {
                        lblDashboardLink.Text = "<a href='CustomerProfile.aspx'>My Dashboard</a>";
                    }
                    else if (Session["Role"].ToString() == "Admin")
                    {
                        // Hide dashboard link for Admin on frontend
                        lblDashboardLink.Text = "";
                    }
                }
            }
        }

        // Logout Action
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            FormsAuthentication.SignOut();
            Response.Redirect("~/Login.aspx");
        }
    }
}