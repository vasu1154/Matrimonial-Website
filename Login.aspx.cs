using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\EMMW\App_Data\EMMW.mdf;Integrated Security=True;User Instance=True";
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT UserID, Role FROM Users WHERE Username=@Username AND Password=@Password";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
            cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                Session["UserID"] = reader["UserID"];
                Session["Role"] = reader["Role"];

                if (reader["Role"].ToString() == "Admin")
                    Response.Redirect("~/Admin/AdminDashboard.aspx");
                else
                    Response.Redirect("~/User/Home.aspx");
            }
            else
            {
                Response.Write("<script>alert('Invalid credentials');</script>");
            }
        }
    }
}