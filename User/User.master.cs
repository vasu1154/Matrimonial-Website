using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class User_User : System.Web.UI.MasterPage
{
    private string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\EMMW\App_Data\EMMW.mdf;Integrated Security=True;User Instance=True";
    protected void Page_Load(object sender, EventArgs e)
    {
        string currentPage = System.IO.Path.GetFileName(Request.Path).ToLower();

        // Allow Home.aspx to be accessible without login
        if (currentPage != "home.aspx" && Session["UserID"] == null)
        {
            Response.Redirect("~/Login.aspx");
            return;
        }

        if (!IsPostBack)
        {
            LoadUserProfile();
        }
    }
    private void LoadUserProfile()
    {
        if (Session["UserID"] == null)
        {
            // If user is not logged in, show default avatar & guest message
            lblUserName.Text = "Guest";
            imgUserProfile.ImageUrl = ResolveUrl("~/Asset/pic/360_F_587766653_PkBNyGx7mQh9l1XXPtCAq1lBgOsLl6xH.jpg");
            Button1.Visible = true;
            btnLogout.Visible = false;
            return;
        }

        if (Session["UserID"] != null)
        {
            Button1.Visible = false;
        }
        int userId;
        if (!int.TryParse(Session["UserID"].ToString(), out userId))
        {
            Response.Redirect("~/Login.aspx");
            return;
        }

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT FullName, ISNULL(ProfileImage, '~/Asset/images/default-user.png') AS ProfileImage FROM Users WHERE UserID = @UserID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", userId);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                lblUserName.Text = reader["FullName"].ToString();
                imgUserProfile.ImageUrl = ResolveUrl(reader["ProfileImage"].ToString());
            }
            conn.Close();
        }
    }
    protected void btnLogout_Click(object sender, EventArgs e)
    {
        
        Session.Abandon();
        Response.Redirect("~/User/Home.aspx");
    }
    protected void btnLoginLogout_Click(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Login.aspx");
    }
}
