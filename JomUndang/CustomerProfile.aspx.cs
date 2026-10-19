using System;
using System.Data.SqlClient;
using System.Configuration;

namespace JomUndang
{
    public partial class CustomerProfile : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["JomUndangDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Auth Check
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
                LoadDashboardStats();
            }
        }

        // Load Profile Data
        private void LoadUserProfile()
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

        // Load Dashboard Stats
        private void LoadDashboardStats()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string statsQuery = @"
                    SELECT 
                        COUNT(TestID) AS TotalTests, 
                        ISNULL(AVG(Score), 0) AS AvgScore,
                        ISNULL((CAST(SUM(CASE WHEN IsPassed = 1 THEN 1 ELSE 0 END) AS FLOAT) / NULLIF(COUNT(TestID), 0)) * 100, 0) AS PassRate
                    FROM TestResults 
                    WHERE UserID = @UserID";

                using (SqlCommand cmd = new SqlCommand(statsQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblTotalTests.Text = reader["TotalTests"].ToString();
                        lblAvgScore.Text = Math.Round(Convert.ToDouble(reader["AvgScore"]), 1).ToString() + "%";
                        lblPassRate.Text = Math.Round(Convert.ToDouble(reader["PassRate"]), 1).ToString() + "%";
                    }
                    reader.Close();
                }

                string testQuery = "SELECT TOP 1 TestDate, Location FROM TestRegistrations WHERE UserID = @UserID AND TestDate >= GETDATE() ORDER BY TestDate ASC";
                using (SqlCommand cmd = new SqlCommand(testQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        lblUpcomingTest.Text = "Date: " + Convert.ToDateTime(reader["TestDate"]).ToString("dd MMM yyyy") +
                                               "<br/>Location: " + reader["Location"].ToString();
                    }
                    reader.Close();
                }
            }
        }

        // Update Profile Data
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
                    lblMessage.Text = "Profile updated successfully!";
                }
            }
        }
    }
}