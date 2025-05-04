using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_ManageUsers : System.Web.UI.Page
{
    private string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\EMMW\App_Data\EMMW.mdf;Integrated Security=True;User Instance=True";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadUsers();
        }
    }
    private void LoadUsers()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT UserID, FullName, Email, Role, ISNULL(ProfileImage, '~/Asset/images/default-user.png') AS ProfileImage FROM Users";
            SqlCommand cmd = new SqlCommand(query, conn);

            conn.Open();
            rptUsers.DataSource = cmd.ExecuteReader();
            rptUsers.DataBind();
            conn.Close();
        }
    }
    protected void btnAddUser_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtFullName.Text) || string.IsNullOrWhiteSpace(txtEmail.Text) || string.IsNullOrWhiteSpace(ddlRole.SelectedValue))
        {
            Response.Write("<script>alert('Please fill all fields!');</script>");
            return;
        }

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO Users (FullName, Email, Role) VALUES (@FullName, @Email, @Role)";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@FullName", txtFullName.Text);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@Role", ddlRole.SelectedValue);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        Response.Write("<script>alert('User added successfully!');</script>");
        txtFullName.Text = "";
        txtEmail.Text = "";
        ddlRole.SelectedIndex = 0;
        LoadUsers();
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int userId = Convert.ToInt32(btn.CommandArgument);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // Check if user has feedback
            string deletePreferences = "DELETE FROM Preferences WHERE UserID = @UserID";
            SqlCommand cmdPreferences = new SqlCommand(deletePreferences, conn);
            cmdPreferences.Parameters.AddWithValue("@UserID", userId);
            cmdPreferences.ExecuteNonQuery();

            // Step 2: Delete requests where the user is sender or receiver
            string deleteRequests = "DELETE FROM Requests WHERE SenderID = @UserID OR ReceiverID = @UserID";
            SqlCommand cmdRequests = new SqlCommand(deleteRequests, conn);
            cmdRequests.Parameters.AddWithValue("@UserID", userId);
            cmdRequests.ExecuteNonQuery();

            // Step 3: Delete user feedback
            string deleteFeedback = "DELETE FROM Feedback WHERE UserID = @UserID";
            SqlCommand cmdFeedback = new SqlCommand(deleteFeedback, conn);
            cmdFeedback.Parameters.AddWithValue("@UserID", userId);
            cmdFeedback.ExecuteNonQuery();

            // Step 4: Delete the user
            string deleteUser = "DELETE FROM Users WHERE UserID = @UserID";
            SqlCommand cmdUser = new SqlCommand(deleteUser, conn);
            cmdUser.Parameters.AddWithValue("@UserID", userId);
            cmdUser.ExecuteNonQuery();

            conn.Close();
        }

        Response.Write("<script>alert('User deleted successfully!');</script>");
        LoadUsers();
    }
}