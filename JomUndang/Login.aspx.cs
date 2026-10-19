using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;

namespace JomUndang
{
    public partial class Login : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["JomUndangDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Login action
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = ddlRole.SelectedValue;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT UserID, FullName FROM Users WHERE Email = @Email AND Password = @Password";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        // Save session
                        Session["UserID"] = reader["UserID"].ToString();
                        Session["FullName"] = reader["FullName"].ToString();
                        Session["Role"] = role;

                        FormsAuthentication.SetAuthCookie(email, false);

                        // Redirect based on Role
                        if (role == "Admin")
                        {
                            Response.Redirect("AdminDashboard.aspx");
                        }
                        else
                        {
                            Response.Redirect("CustomerProfile.aspx");
                        }
                    }
                    else
                    {
                        // Show error message if not found
                        if (pnlMessage != null)
                        {
                            pnlMessage.Visible = true;
                            pnlMessage.CssClass = "auth-message auth-message-error";
                            lblMessage.Text = "Invalid email or password.";
                        }
                    }
                }
            }
        }
    }
}