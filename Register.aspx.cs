using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            Session.Clear();
        }
    }
    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtFullName.Text) ||
             string.IsNullOrWhiteSpace(txtEmail.Text) ||
             string.IsNullOrWhiteSpace(txtPhone.Text) ||
             string.IsNullOrWhiteSpace(txtUsername.Text) ||
             string.IsNullOrWhiteSpace(txtPassword.Text))
        {
            Response.Write("<script>alert('All fields are required!');</script>");
            return;
        }

        // Database connection string (Update this in Web.config)
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\EMMW\App_Data\EMMW.mdf;Integrated Security=True;User Instance=True";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            try
            {
                // Check if username or email already exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @Username OR Email = @Email";
                SqlCommand checkCmd = new SqlCommand(checkQuery, conn);
                checkCmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text);

                conn.Open();
                int userExists = (int)checkCmd.ExecuteScalar();
                conn.Close();

                if (userExists > 0)
                {
                    Response.Write("<script>alert('Username or Email already exists. Try another one.');</script>");
                    return;
                }

                // Insert new user into database
                string insertQuery = "INSERT INTO Users (FullName, Email, Phone, Username, Password, Role) " +
                                     "VALUES (@FullName, @Email, @Phone, @Username, @Password, 'User')";
                SqlCommand cmd = new SqlCommand(insertQuery, conn);
                cmd.Parameters.AddWithValue("@FullName", txtFullName.Text);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text); // Store hashed password in production

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                conn.Close();

                if (rowsAffected > 0)
                {
                    Response.Write("<script>alert('Registration successful! Redirecting to login...');</script>");
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    Response.Write("<script>alert('Registration failed. Please try again.');</script>");
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }
    }
}