using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_ViewFeedback : System.Web.UI.Page
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
    private void LoadFeedback()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"
                SELECT f.FeedbackID, f.Message, f.CreatedAt, 
                       u.FullName AS UserName, 
                       ISNULL(u.ProfileImage, '~/Asset/images/default-user.png') AS ProfileImage 
                FROM Feedback f
                INNER JOIN Users u ON f.UserID = u.UserID
                ORDER BY f.CreatedAt DESC";  // Sort by latest feedback first

            SqlCommand cmd = new SqlCommand(query, conn);

            conn.Open();
            rptFeedback.DataSource = cmd.ExecuteReader();
            rptFeedback.DataBind();
            conn.Close();
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int feedbackId = Convert.ToInt32(btn.CommandArgument);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "DELETE FROM Feedback WHERE FeedbackID = @FeedbackID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@FeedbackID", feedbackId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        Response.Write("<script>alert('Feedback deleted successfully!');</script>");
        LoadFeedback();
    }
}