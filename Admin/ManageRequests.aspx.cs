using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_ManageRequests : System.Web.UI.Page
{
    private string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\EMMW\App_Data\EMMW.mdf;Integrated Security=True;User Instance=True";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("~/AdminLogin.aspx");
        }

        if (!IsPostBack)
        {
            LoadRequests();
        }
    }
    private void LoadRequests()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"
            SELECT r.RequestID, r.RequestStatus, r.RequestedAt, 
                   s.FullName AS SenderName, 
                   ISNULL(s.ProfileImage, '~/Asset/images/default-user.png') AS SenderProfileImage, 
                   rcv.FullName AS ReceiverName
            FROM Requests r
            INNER JOIN Users s ON r.SenderID = s.UserID
            INNER JOIN Users rcv ON r.ReceiverID = rcv.UserID
            ORDER BY r.RequestedAt DESC";

            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            conn.Open();
            da.Fill(dt);
            conn.Close();

            if (dt.Rows.Count > 0)
            {
                rptRequests.DataSource = dt;
                rptRequests.DataBind();
            }
            else
            {
                rptRequests.DataSource = null;
                rptRequests.DataBind();
            }
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

        Response.Write("<script>alert('Request accepted successfully!');</script>");
        LoadRequests();
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int requestId = Convert.ToInt32(btn.CommandArgument);

        UpdateRequestStatus(requestId, "Rejected");
    }

    private void UpdateRequestStatus(int requestId, string status)
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "UPDATE Requests SET RequestStatus = @RequestStatus WHERE RequestID = @RequestID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@RequestStatus", status);
            cmd.Parameters.AddWithValue("@RequestID", requestId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        LoadRequests();
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int requestId = Convert.ToInt32(btn.CommandArgument);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "DELETE FROM Requests WHERE RequestID = @RequestID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@RequestID", requestId);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        Response.Write("<script>alert('Request deleted successfully!');</script>");
        LoadRequests();
    }
}