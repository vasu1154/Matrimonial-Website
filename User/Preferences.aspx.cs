using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class User_Preferences : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadPreferences();
        }
    }
    private void LoadPreferences()
    {
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\EMMW\App_Data\EMMW.mdf;Integrated Security=True;User Instance=True";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT PreferredAgeFrom, PreferredAgeTo, PreferredGender, PreferredLocation, Religion, Caste, AdditionalPreferences FROM Preferences WHERE UserID = @UserID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                ddlPreferredAgeFrom.SelectedValue = reader["PreferredAgeFrom"].ToString();
                ddlPreferredAgeTo.SelectedValue = reader["PreferredAgeTo"].ToString();
                ddlPreferredGender.SelectedValue = reader["PreferredGender"].ToString();
                txtPreferredLocation.Text = reader["PreferredLocation"].ToString();
                ddlReligion.SelectedValue = reader["Religion"].ToString();
                ddlCaste.SelectedValue = reader["Caste"].ToString();
                txtAdditionalPreferences.Text = reader["AdditionalPreferences"].ToString();
            }

            conn.Close();
        }
    }
    protected void btnSavePreferences_Click(object sender, EventArgs e)
    {
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\EMMW\App_Data\EMMW.mdf;Integrated Security=True;User Instance=True";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "INSERT INTO Preferences (UserID, PreferredAgeFrom, PreferredAgeTo, PreferredGender, PreferredLocation, Religion, Caste, AdditionalPreferences) " +
                           "VALUES (@UserID, @PreferredAgeFrom, @PreferredAgeTo, @PreferredGender, @PreferredLocation, @Religion, @Caste, @AdditionalPreferences)";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
            cmd.Parameters.AddWithValue("@PreferredAgeFrom", ddlPreferredAgeFrom.SelectedValue);
            cmd.Parameters.AddWithValue("@PreferredAgeTo", ddlPreferredAgeTo.SelectedValue);
            cmd.Parameters.AddWithValue("@PreferredGender", ddlPreferredGender.SelectedValue);
            cmd.Parameters.AddWithValue("@PreferredLocation", txtPreferredLocation.Text);
            cmd.Parameters.AddWithValue("@Religion", ddlReligion.SelectedValue);
            cmd.Parameters.AddWithValue("@Caste", ddlCaste.SelectedValue);
            cmd.Parameters.AddWithValue("@AdditionalPreferences", txtAdditionalPreferences.Text);

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            Response.Write("<script>alert('Preferences saved successfully!');</script>");
        }
    }
}