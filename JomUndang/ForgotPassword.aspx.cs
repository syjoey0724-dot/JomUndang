using System;
using System.Data.SqlClient;
using System.Configuration;

namespace JomUndang
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim();

            // 1. Check the email exists (adjust connection string / table / columns)
            string connString = ConfigurationManager.ConnectionStrings["JomUndangDB"].ConnectionString;
            bool exists = false;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();
                    exists = (int)cmd.ExecuteScalar() > 0;
                }
            }

            // 2. Always show the same message (security: don't reveal if email exists)
            pnlMessage.Visible = true;
            pnlMessage.CssClass = "auth-message auth-message-success";
            lblMessage.Text = "If that email is registered, a reset link has been sent. Please check your inbox.";

            // 3. TODO: generate a reset token, save it with an expiry,
            //    and email the user a link like: ResetPassword.aspx?token=xxxx
            if (exists)
            {
                // Send email here (e.g. SmtpClient)
            }
        }
    }
}