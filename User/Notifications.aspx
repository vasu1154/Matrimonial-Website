<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.master" AutoEventWireup="true" CodeFile="Notifications.aspx.cs" Inherits="User_Notifications" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        body {
            background-color: #f4f7f6;
        }

        .notifications-container {
            max-width: 800px;
            margin: 40px auto;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .notification-card {
            background: white;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .notification-card img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .notification-card h5 {
            margin: 0;
            font-size: 16px;
            color: #333;
        }

        .notification-card span {
            font-size: 12px;
            color: #777;
        }

        .btn-action {
            font-weight: bold;
            transition: 0.3s ease-in-out;
        }

        .btn-accept {
            background: #28a745;
            color: white;
        }

        .btn-accept:hover {
            background: #218838;
            transform: scale(1.05);
        }

        .btn-ignore {
            background: #dc3545;
            color: white;
        }

        .btn-ignore:hover {
            background: #c82333;
            transform: scale(1.05);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="notifications-container">
        <h2 class="text-center mb-4">Notifications</h2>

        <!-- Pending Requests -->
        <asp:Repeater ID="rptNotifications" runat="server">
            <ItemTemplate>
                <div class="notification-card">
                    <div class="d-flex align-items-center">
                        <img src='<%# ResolveUrl(string.IsNullOrEmpty(Eval("ProfileImage").ToString()) ? "~/Asset/images/default-user.png" : Eval("ProfileImage").ToString()) %>' alt="Profile">
                        <div>
                            <h5><%# Eval("SenderName") %></h5>
                            <span>Sent you a request on <%# Eval("RequestedAt", "{0:MMM dd, yyyy}") %></span>
                        </div>
                    </div>
                    <div>
                        <asp:Button ID="btnAccept" runat="server" CssClass="btn btn-accept btn-action" Text="Accept" CommandArgument='<%# Eval("RequestID") %>' OnClick="btnAccept_Click" />
                        <asp:Button ID="btnIgnore" runat="server" CssClass="btn btn-ignore btn-action ms-2" Text="Ignore" CommandArgument='<%# Eval("RequestID") %>' OnClick="btnIgnore_Click" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- No Notifications Message -->
        <asp:Panel ID="pnlNoNotifications" runat="server" Visible="false">
            <p class="text-center text-muted">No new notifications.</p>
        </asp:Panel>
    </div>
</asp:Content>

