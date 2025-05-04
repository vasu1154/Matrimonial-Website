using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class User_Home : System.Web.UI.Page
{
    protected string ViewingUserID;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            LoadFeaturedProfiles();
        }
    }
    private void LoadFeaturedProfiles()
    {
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\EMMW\App_Data\EMMW.mdf;Integrated Security=True;User Instance=True";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT TOP 3 UserID, FullName, Address, ISNULL(ProfileImage, 'Asset/images/default-user.png') AS ProfileImage FROM Users WHERE Role='User' ORDER BY NEWID()";
            SqlCommand cmd = new SqlCommand(query, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            conn.Open();
            da.Fill(dt);
            conn.Close();

            rptProfiles.DataSource = dt;
            rptProfiles.DataBind();
        }
    }
}