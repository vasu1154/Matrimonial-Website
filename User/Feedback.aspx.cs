using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class User_Feedback : System.Web.UI.Page
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
            LoadFeedback();
        }
    }
    protected void btnSubmitFeedback_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrWhiteSpace(txtFeedback.Text))
        {
            Response.Write("<script>alert('Feedback cannot be empty!');</script>");
            return;
        }

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO Feedback (UserID, Message, CreatedAt) VALUES (@UserID, @FeedbackText, GETDATE())";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
            cmd.Parameters.AddWithValue("@FeedbackText", txtFeedback.Text.Trim());

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        txtFeedback.Text = "";
        Response.Write("<script>alert('Thank you for your feedback!');</script>");
        LoadFeedback();
    }
    private void LoadFeedback()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"
                SELECT u.FullName, f.Message, f.CreatedAt 
                FROM Feedback f 
                INNER JOIN Users u ON f.UserID = u.UserID
                ORDER BY f.CreatedAt DESC";
            SqlCommand cmd = new SqlCommand(query, conn);

            conn.Open();
            rptFeedback.DataSource = cmd.ExecuteReader();
            rptFeedback.DataBind();
            conn.Close();
        }
    }
}