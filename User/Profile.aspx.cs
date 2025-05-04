using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class User_Profile : System.Web.UI.Page
{
    protected string ViewingUserID;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserID"] == null)
        {
            Response.Redirect("~/Login.aspx");
        }

        // Check if UserID is passed in the URL (for viewing another user's profile)
        ViewingUserID = Request.QueryString["UserID"] ?? Session["UserID"].ToString();

        if (!IsPostBack)
        {
            LoadUserProfile();
            ToggleEditMode(); // Enable editing only for logged-in users
        }
    }

    private void LoadUserProfile()
    {
        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\EMMW\App_Data\EMMW.mdf;Integrated Security=True;User Instance=True";

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "SELECT FullName, Email, Phone, Gender, DateOfBirth, Address, Bio, ISNULL(ProfileImage, 'Asset/images/default-user.png') AS ProfileImage FROM Users WHERE UserID = @UserID";
            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@UserID", ViewingUserID);

            conn.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            if (reader.Read())
            {
                txtFullName.Text = reader["FullName"] != DBNull.Value ? reader["FullName"].ToString() : "";
                txtEmail.Text = reader["Email"] != DBNull.Value ? reader["Email"].ToString() : "";
                txtPhone.Text = reader["Phone"] != DBNull.Value ? reader["Phone"].ToString() : "";
                ddlGender.SelectedValue = reader["Gender"] != DBNull.Value ? reader["Gender"].ToString() : "";
                txtDOB.Text = reader["DateOfBirth"] != DBNull.Value ? Convert.ToDateTime(reader["DateOfBirth"]).ToString("yyyy-MM-dd") : "";
                txtLocation.Text = reader["Address"] != DBNull.Value ? reader["Address"].ToString() : "";
                txtBio.Text = reader["Bio"] != DBNull.Value ? reader["Bio"].ToString() : "";
                imgProfile.ImageUrl = ResolveUrl(reader["ProfileImage"].ToString());
            }

            conn.Close();
        }
    }

    private void ToggleEditMode()
    {
        // Check if the logged-in user is viewing their own profile
        bool isUserProfile = ViewingUserID == Session["UserID"].ToString();

        // Enable/Disable fields based on profile ownership
        txtFullName.ReadOnly = !isUserProfile;
        txtPhone.ReadOnly = !isUserProfile;
        ddlGender.Enabled = isUserProfile;
        txtDOB.ReadOnly = !isUserProfile;
        txtLocation.ReadOnly = !isUserProfile;
        txtBio.ReadOnly = !isUserProfile;
        fuProfilePic.Visible = isUserProfile;
        btnUpdateProfile.Visible = isUserProfile;
    }

    protected void btnUpdateProfile_Click(object sender, EventArgs e)
    {
        if (ViewingUserID != Session["UserID"].ToString())
        {
            Response.Write("<script>alert('You cannot update another user\'s profile!');</script>");
            return;
        }

        string connStr = @"Data Source=.\SQLEXPRESS;AttachDbFilename=Z:\Projects\Asp.Net\EMMW\App_Data\EMMW.mdf;Integrated Security=True;User Instance=True";
        string imagePath = null;

        // Handle file upload
        if (fuProfilePic.HasFile)
        {
            string fileExtension = Path.GetExtension(fuProfilePic.FileName).ToLower();
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };

            if (Array.Exists(allowedExtensions, ext => ext == fileExtension))
            {
                string fileName = "Profile_" + Session["UserID"] + fileExtension;
                imagePath = "~/Image/" + fileName;
                fuProfilePic.SaveAs(Server.MapPath(imagePath));
            }
            else
            {
                Response.Write("<script>alert('Invalid file format. Please upload a JPG, JPEG, PNG, or GIF.');</script>");
                return;
            }
        }

        using (SqlConnection conn = new SqlConnection(connStr))
        {
            string query = "UPDATE Users SET FullName = @FullName, Phone = @Phone, Gender = @Gender, DateOfBirth = @DOB, Address = @Location, Bio = @Bio";

            if (!string.IsNullOrEmpty(imagePath))
            {
                query += ", ProfileImage = @ProfileImage";
            }

            query += " WHERE UserID = @UserID";

            SqlCommand cmd = new SqlCommand(query, conn);
            cmd.Parameters.AddWithValue("@FullName", txtFullName.Text);
            cmd.Parameters.AddWithValue("@Phone", txtPhone.Text);
            cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
            cmd.Parameters.AddWithValue("@DOB", txtDOB.Text);
            cmd.Parameters.AddWithValue("@Location", txtLocation.Text);
            cmd.Parameters.AddWithValue("@Bio", txtBio.Text);
            cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);

            if (!string.IsNullOrEmpty(imagePath))
            {
                cmd.Parameters.AddWithValue("@ProfileImage", imagePath);
            }

            conn.Open();
            int rowsAffected = cmd.ExecuteNonQuery();
            conn.Close();

            if (rowsAffected > 0)
            {
                Response.Write("<script>alert('Profile updated successfully!');</script>");
                LoadUserProfile();
            }
            else
            {
                Response.Write("<script>alert('Profile update failed. Please try again.');</script>");
            }
        }
    }
}
