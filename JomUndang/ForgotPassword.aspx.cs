using System;
using System.Data.SqlClient;
using System.Configuration;

namespace JomUndang
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["JomUndangDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Validate Email
        protected void btnCheckEmail_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();

                    if (count > 0)
                    {
                        // Store email in hidden field
                        hiddenEmail.Value = email;

                        // Show new password field
                        pnlNewPassword.Visible = true;
                        btnCheckEmail.Visible = false;
                        btnReset.Visible = true;
                        txtEmail.Enabled = false;

                        pnlMessage.Visible = true;
                        pnlMessage.CssClass = "auth-message auth-message-success";
                        lblMessage.Text = "Email verified. Please enter your new password.";
                    }
                    else
                    {
                        // Show error
                        pnlMessage.Visible = true;
                        pnlMessage.CssClass = "auth-message auth-message-error";
                        lblMessage.Text = "Email not found in our system.";
                    }
                }
            }
        }

        // Update Password
        protected void btnReset_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // Get email from hidden field
            string email = hiddenEmail.Value;
            string newPassword = txtNewPassword.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                pnlMessage.Visible = true;
                pnlMessage.CssClass = "auth-message auth-message-error";
                lblMessage.Text = "Session expired. Please enter your email again.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE Users SET Password = @Password WHERE Email = @Email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Password", newPassword);
                    cmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();

                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        // Redirect after success
                        Response.Redirect("Login.aspx");
                    }
                    else
                    {
                        // Show update error
                        pnlMessage.Visible = true;
                        pnlMessage.CssClass = "auth-message auth-message-error";
                        lblMessage.Text = "Failed to update password. Please try again.";
                    }
                }
            }
        }
    }
}