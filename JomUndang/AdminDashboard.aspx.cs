using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace JomUndang
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["JomUndangDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Admin Auth Check
            if (Session["UserID"] == null || Session["Role"]?.ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadAdminProfile();
                LoadStats();
                LoadPendingAdmins();
                LoadTestResults(); // Load the new table
            }
        }

        // Load Admin Profile
        private void LoadAdminProfile()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT FullName, Email FROM Users WHERE UserID = @UserID";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtName.Text = reader["FullName"].ToString();
                        txtEmail.Text = reader["Email"].ToString();
                    }
                }
            }
        }

        // Update Admin Profile
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                string query = "UPDATE Users SET FullName = @FullName, Email = @Email";

                if (!string.IsNullOrWhiteSpace(txtPassword.Text))
                {
                    query += ", Password = @Password";
                }
                query += " WHERE UserID = @UserID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@FullName", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

                    if (!string.IsNullOrWhiteSpace(txtPassword.Text))
                    {
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                    }

                    cmd.ExecuteNonQuery();

                    pnlMessage.Visible = true;
                    pnlMessage.CssClass = "auth-message auth-message-success";
                    lblMessage.Text = "Admin details updated successfully!";
                }
            }
        }

        // Load Stats
        private void LoadStats()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM Users", conn);
                lblTotalUsers.Text = cmd1.ExecuteScalar().ToString();

                SqlCommand cmd2 = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Role = 'Admin' AND IsApproved = 0", conn);
                lblPendingUsers.Text = cmd2.ExecuteScalar().ToString();

                SqlCommand cmd3 = new SqlCommand("SELECT COUNT(*) FROM TestResults", conn);
                lblTotalTests.Text = cmd3.ExecuteScalar().ToString();
            }
        }

        // Load Pending Admins
        private void LoadPendingAdmins()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT UserID, FullName, Email, CreatedAt FROM Users WHERE Role = 'Admin' AND IsApproved = 0";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvPendingAdmins.DataSource = dt;
                        gvPendingAdmins.DataBind();
                    }
                }
            }
        }

        // Handle Approve / Reject
        protected void gvPendingAdmins_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Approve" || e.CommandName == "Reject")
            {
                int userId = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    if (e.CommandName == "Approve")
                    {
                        string query = "UPDATE Users SET IsApproved = 1 WHERE UserID = @UserID";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            cmd.ExecuteNonQuery();
                        }

                        pnlApprovalMessage.Visible = true;
                        pnlApprovalMessage.CssClass = "auth-message auth-message-success";
                        pnlApprovalMessage.Controls.Clear();
                        pnlApprovalMessage.Controls.Add(new System.Web.UI.LiteralControl("Admin approved successfully!"));
                    }
                    else if (e.CommandName == "Reject")
                    {
                        string query = "DELETE FROM Users WHERE UserID = @UserID";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            cmd.ExecuteNonQuery();
                        }

                        pnlApprovalMessage.Visible = true;
                        pnlApprovalMessage.CssClass = "auth-message auth-message-error";
                        pnlApprovalMessage.Controls.Clear();
                        pnlApprovalMessage.Controls.Add(new System.Web.UI.LiteralControl("Admin request rejected and removed."));
                    }
                }

                LoadStats();
                LoadPendingAdmins();
            }
        }

        // Load Test Results with Filter
        private void LoadTestResults()
        {
            string filter = ddlFilterResult.SelectedValue;
            string query = @"
                SELECT u.FullName, 'Mock Test ' + CAST(tr.TestID AS VARCHAR) AS TestName, 
                       CAST(tr.Score AS VARCHAR) + ' / 50' AS ScoreDisplay, 
                       tr.IsPassed, tr.TestDate
                FROM TestResults tr
                INNER JOIN Users u ON tr.UserID = u.UserID";

            if (filter == "Pass")
                query += " WHERE tr.IsPassed = 1";
            else if (filter == "Fail")
                query += " WHERE tr.IsPassed = 0";

            query += " ORDER BY tr.TestDate DESC";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvTestResults.DataSource = dt;
                        gvTestResults.DataBind();
                    }
                }
            }
        }

        // Handle Filter Change
        protected void ddlFilterResult_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadTestResults();
        }
    }
}