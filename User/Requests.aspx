<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.master" AutoEventWireup="true" CodeFile="Requests.aspx.cs" Inherits="User_Requests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <style>
        body {
            background: #f4f7f6;
            font-family: Arial, sans-serif;
        }
        
        .requests-container {
            width: 90%;
            max-width: 1200px;
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

        .section-title {
            font-size: 22px;
            font-weight: bold;
            margin-bottom: 20px;
            color: #007bff;
        }

        /* Grid Layout for Profile Cards */
        .profile-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            padding: 10px;
        }

        .profile-card, .accepted-profile {
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            transition: transform 0.2s;
            min-height: 270px;
            justify-content: space-between;
        }

        .profile-card:hover, .accepted-profile:hover {
            transform: scale(1.02);
        }

        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 10px;
            object-fit: cover;
            margin-bottom: 10px;
            border: 3px solid #007bff;
        }

        .profile-details h5 {
            margin: 5px 0;
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }

        .profile-details span {
            font-size: 14px;
            color: #666;
        }

        .btn-send, .btn-unfollow {
            color: white;
            padding: 8px 15px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: bold;
            transition: 0.3s;
            border: none;
            cursor: pointer;
            margin-top: auto;
        }

        .btn-send {
            background: #007bff;
        }

        .btn-send:hover {
            background: #0056b3;
            transform: scale(1.05);
        }

        .disabled-btn {
            background: gray !important;
            cursor: not-allowed !important;
        }

        .btn-unfollow {
            background: #dc3545;
        }

        .btn-unfollow:hover {
            background: #b02a37;
            transform: scale(1.05);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
      <div class="requests-container">
        <h2 class="text-center mb-4">Browse Profiles & Send Requests</h2>

        <!-- Show All Available Profiles -->
        <h4 class="section-title">All Available Profiles</h4>
        <div class="profile-grid">
            <asp:Repeater ID="rptAllProfiles" runat="server">
                <ItemTemplate>
                    <div class="profile-card">
                        <a href="Profile.aspx?UserID=<%# Eval("UserID") %>">
                            <img src='<%# ResolveUrl(string.IsNullOrEmpty(Eval("ProfileImage").ToString()) ? "~/Asset/images/default-user.png" : Eval("ProfileImage").ToString()) %>' 
                                 alt="Profile" class="profile-img">
                        </a>
                        &nbsp;&nbsp;&nbsp;<div class="profile-details">
                            <h5>
                                <a href="Profile.aspx?UserID=<%# Eval("UserID") %>" style="text-decoration: none; color: black;">
                                    <%# Eval("FullName") %>
                                </a>
                            </h5>
                            <span>Status: <%# Eval("RequestStatus") %></span>
                        </div>
                        <asp:Button ID="btnSendRequest" runat="server" CssClass='<%# Eval("RequestStatus").ToString() == "Accepted" ? "btn btn-send disabled-btn" : "btn btn-send" %>' 
                                    Text="Send Request" CommandArgument='<%# Eval("UserID") %>' 
                                    OnClick="btnSendRequest_Click" Enabled='<%# Eval("RequestStatus").ToString() != "Accepted" %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <!-- Accepted Matches -->
        <h4 class="section-title accepted-matches">Accepted Matches</h4>
        <div class="profile-grid">
            <asp:Repeater ID="rptAcceptedMatches" runat="server">
                <ItemTemplate>
                    <div class="accepted-profile">
                        <a href="Profile.aspx?UserID=<%# Eval("AcceptedUserID") %>">
                            <img src='<%# ResolveUrl(string.IsNullOrEmpty(Eval("ProfileImage").ToString()) ? "~/Asset/images/default-user.png" : Eval("ProfileImage").ToString()) %>' 
                                 alt="Profile" class="profile-img">
                        </a>
                        &nbsp;&nbsp;&nbsp;<div class="profile-details">
                            <h5>
                                <a href="Profile.aspx?UserID=<%# Eval("AcceptedUserID") %>" style="text-decoration: none; color: black;">
                                    <%# Eval("AcceptedUserName") %>
                                </a>
                            </h5>
                            <span>Matched on <%# Eval("AcceptedAt", "{0:MMM dd, yyyy}") %></span>
                        </div>
                        
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>

