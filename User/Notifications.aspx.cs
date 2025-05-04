using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class User_Notifications : System.Web.UI.Page
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
            LoadNotifications();
        }
    }
    private void LoadNotifications()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"
                SELECT r.RequestID, u.FullName AS SenderName, 
                       ISNULL(u.ProfileImage, '~/Asset/images/default-user.png') AS ProfileImage, 
                       r.RequestedAt 
                FROM Requests r 
                INNER JOIN Users u ON r.SenderID = u.UserID 
                WHERE r.ReceiverID = @UserID AND r.RequestStatus = 'Pending'";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.HasRows)
            {
                rptNotifications.DataSource = reader;
                rptNotifications.DataBind();
                pnlNoNotifications.Visible = false;
            }
            else
            {
                pnlNoNotifications.Visible = true;
            }

            conn.Close();
        }
    }
    protected void btnAccept_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int requestId = Convert.ToInt32(btn.CommandArgument);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "UPDATE Requests SET RequestStatus = 'Accepted' WHERE RequestID = @RequestID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@RequestID", requestId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        LoadNotifications();
    }

    protected void btnIgnore_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int requestId = Convert.ToInt32(btn.CommandArgument);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "UPDATE Requests SET RequestStatus = 'Rejected' WHERE RequestID = @RequestID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@RequestID", requestId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        LoadNotifications();
    }
}