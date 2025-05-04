using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class User_Requests : System.Web.UI.Page
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
            LoadAllProfiles();
            LoadAcceptedMatches();
        }
    }

    private void LoadAllProfiles()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = @"
            SELECT DISTINCT u.UserID, u.FullName, 
                   COALESCE(NULLIF(u.ProfileImage, ''), '~/Asset/images/default-user.png') AS ProfileImage, 
                   COALESCE(r.RequestStatus, 'Not Requested') AS RequestStatus
            FROM Users u
            LEFT JOIN Requests r ON 
                (r.SenderID = @UserID AND r.ReceiverID = u.UserID)
                OR (r.SenderID = u.UserID AND r.ReceiverID = @UserID)
            WHERE u.UserID <> @UserID";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

            conn.Open();
            rptAllProfiles.DataSource = cmd.ExecuteReader();
            rptAllProfiles.DataBind();
            conn.Close();
        }
    }

    protected void btnSendRequest_Click(object sender, EventArgs e)
    {
        Button btn = (Button)sender;
        int receiverID = Convert.ToInt32(btn.CommandArgument);

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO Requests (SenderID, ReceiverID, RequestStatus, RequestedAt) " +
                           "VALUES (@SenderID, @ReceiverID, 'Pending', GETDATE())";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@SenderID", Session["UserID"]);
            cmd.Parameters.AddWithValue("@ReceiverID", receiverID);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
        }

        LoadAllProfiles();
    }

    private void LoadAcceptedMatches()
    {
         using (SqlConnection conn = new SqlConnection(connStr))
    {
        string query = @"
            SELECT DISTINCT u.UserID AS AcceptedUserID, u.FullName AS AcceptedUserName, 
                   COALESCE(NULLIF(u.ProfileImage, ''), '~/Asset/images/default-user.png') AS ProfileImage, 
                   r.RequestedAt AS AcceptedAt 
            FROM Requests r
            INNER JOIN Users u ON (r.SenderID = u.UserID OR r.ReceiverID = u.UserID)
            WHERE (r.SenderID = @UserID OR r.ReceiverID = @UserID) 
                  AND r.RequestStatus = 'Accepted' 
                  AND u.UserID <> @UserID";

        SqlCommand cmd = new SqlCommand(query, conn);
        cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

        conn.Open();
        rptAcceptedMatches.DataSource = cmd.ExecuteReader();
        rptAcceptedMatches.DataBind();
        conn.Close();
    }
    }
}
