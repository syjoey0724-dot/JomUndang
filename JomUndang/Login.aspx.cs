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
                // Get user data with Role and Approval status
                string query = "SELECT UserID, FullName, Role, IsApproved FROM Users WHERE Email = @Email AND Password = @Password";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Password", password);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        bool isApproved = Convert.ToBoolean(reader["IsApproved"]);
                        string dbRole = reader["Role"].ToString();

                        // Check Admin approval status
                        if (dbRole == "Admin" && !isApproved)
                        {
                            pnlMessage.Visible = true;
                            pnlMessage.CssClass = "auth-message auth-message-error";
                            lblMessage.Text = "Your Admin account is pending approval.";
                            return;
                        }

                        // Check Role mismatch
                        if (role != dbRole)
                        {
                            pnlMessage.Visible = true;
                            pnlMessage.CssClass = "auth-message auth-message-error";
                            lblMessage.Text = "Role mismatch. You are registered as: " + dbRole;
                            return;
                        }

                        // Save session
                        Session["UserID"] = reader["UserID"].ToString();
                        Session["FullName"] = reader["FullName"].ToString();
                        Session["Role"] = dbRole;

                        FormsAuthentication.SetAuthCookie(email, false);

                        // Redirect based on Role
                        if (dbRole == "Admin")
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
                        // Show error message
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