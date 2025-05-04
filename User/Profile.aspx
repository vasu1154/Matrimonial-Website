<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="User_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <style>
        body {
            background: #f4f7f6;
        }
        .profile-container {
            width: 80%;
            max-width: 900px;
            margin: 40px auto;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .profile-header {
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-header img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #007bff;
        }

        .form-control {
            border-radius: 8px;
        }

        .btn-update {
            background: #007bff;
            color: white;
            font-weight: bold;
            transition: 0.3s ease-in-out;
        }

        .btn-update:hover {
            background: #0056b3;
            transform: scale(1.05);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="profile-container">
        <div class="profile-header">
            <h2>Profile</h2>
            <asp:Image ID="imgProfile" runat="server" CssClass="img-thumbnail" />
        </div>

        <div class="text-center mb-3">
            <asp:FileUpload ID="fuProfilePic" runat="server" CssClass="form-control w-50 mx-auto" />
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" ReadOnly></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Phone</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" ReadOnly></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Gender</label>
                <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Select Gender" Value="" />
                    <asp:ListItem Text="Male" Value="Male" />
                    <asp:ListItem Text="Female" Value="Female" />
                    <asp:ListItem Text="Other" Value="Other" />
                </asp:DropDownList>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Date of Birth</label>
                <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" TextMode="Date" ReadOnly></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Address</label>
                <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" ReadOnly></asp:TextBox>
            </div>

            <div class="col-md-12 mb-3">
                <label class="form-label">Bio</label>
                <asp:TextBox ID="txtBio" runat="server" CssClass="form-control" TextMode="MultiLine" ReadOnly></asp:TextBox>
            </div>
        </div>

        <div class="text-center">
            <asp:Button ID="btnUpdateProfile" runat="server" CssClass="btn btn-update w-50" Text="Update Profile" OnClick="btnUpdateProfile_Click" />
        </div>
    </div>

</asp:Content>

