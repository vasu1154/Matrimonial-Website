using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_AdminDashboard : System.Web.UI.Page
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
            LoadDashboardData();
        }
    }
    private void LoadDashboardData()
    {
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            // Total Users
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users", conn))
            {
                lblTotalUsers.Text = cmd.ExecuteScalar().ToString();
            }

            // Total Requests
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Requests", conn))
            {
                lblTotalRequests.Text = cmd.ExecuteScalar().ToString();
            }

            // Pending Requests
            using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Requests WHERE RequestStatus = 'Pending'", conn))
            {
                lblPendingRequests.Text = cmd.ExecuteScalar().ToString();
            }

            conn.Close();
        }
    }
}