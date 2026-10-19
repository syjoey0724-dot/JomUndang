using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;

namespace JomUndang
{
    public partial class Register : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["JomUndangDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string name = txtName.Text.Trim();
            int age = Convert.ToInt32(txtAge.Text.Trim());
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = ddlRole.SelectedValue;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Check if email exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email = @Email";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();
                    int count = (int)checkCmd.ExecuteScalar();

                    if (count > 0)
                    {
                        pnlMessage.Visible = true;
                        pnlMessage.CssClass = "auth-message auth-message-error";
                        lblMessage.Text = "Email is already registered.";
                        return;
                    }
                }

                // If Admin, set IsApproved to 0 (Pending). If Customer, set to 1 (Approved)
                int isApproved = (role == "Admin") ? 0 : 1;

                // Insert new user
                string insertQuery = "INSERT INTO Users (FullName, Age, Email, Password, Role, IsApproved) VALUES (@Name, @Age, @Email, @Password, @Role, @IsApproved); SELECT SCOPE_IDENTITY();";
                using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                {
                    insertCmd.Parameters.AddWithValue("@Name", name);
                    insertCmd.Parameters.AddWithValue("@Age", age);
                    insertCmd.Parameters.AddWithValue("@Email", email);
                    insertCmd.Parameters.AddWithValue("@Password", password);
                    insertCmd.Parameters.AddWithValue("@Role", role);
                    insertCmd.Parameters.AddWithValue("@IsApproved", isApproved);

                    // Get new UserID
                    int newUserId = Convert.ToInt32(insertCmd.ExecuteScalar());

                    if (role == "Admin")
                    {
                        // Show pending message for Admin
                        pnlMessage.Visible = true;
                        pnlMessage.CssClass = "auth-message auth-message-success";
                        lblMessage.Text = "Admin account registered successfully. Please wait for an existing Admin to approve your account before logging in.";

                        // Optional: Clear form
                        txtName.Text = "";
                        txtAge.Text = "";
                        txtEmail.Text = "";
                    }
                    else
                    {
                        // Auto login for Customer
                        Session["UserID"] = newUserId.ToString();
                        Session["FullName"] = name;
                        Session["Role"] = role;

                        FormsAuthentication.SetAuthCookie(email, false);

                        // Direct to Profile
                        Response.Redirect("CustomerProfile.aspx");
                    }
                }
            }
        }
    }
}