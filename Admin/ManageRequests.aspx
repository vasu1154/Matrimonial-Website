<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="ManageRequests.aspx.cs" Inherits="Admin_ManageRequests" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        body {
            background: #f4f7f6;
        }
        .container {
            max-width: 1100px;
            margin: 40px auto;
            background: white;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
        }
        .card {
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
            padding: 15px;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
        }
        .user-img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            object-fit: cover;
        }
        .btn-action {
            transition: 0.3s;
        }
        .btn-action:hover {
            transform: scale(1.05);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <h2 class="text-center mb-4">Manage Match Requests</h2>

        <!-- Requests List -->
       <asp:Repeater ID="rptRequests" runat="server">
    <ItemTemplate>
        <div class="card mb-3">
            <div class="d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center">
                    <img src='<%# ResolveUrl(Eval("SenderProfileImage").ToString()) %>' 
                         alt="Sender" class="user-img me-3">
                    <div>
                        <h5 class="mb-1"><%# Eval("SenderName") %> ➝ <%# Eval("ReceiverName") %></h5>
                        <span>Status: <strong><%# Eval("RequestStatus") %></strong></span>
                        <p class="text-muted">Requested on <%# Eval("RequestedAt", "{0:MMM dd, yyyy hh:mm tt}") %></p>
                    </div>
                </div>
                <div>
                    <asp:Button ID="btnAccept" runat="server" CssClass="btn btn-success btn-action" 
                                Text="Accept" CommandArgument='<%# Eval("RequestID") %>' OnClick="btnAccept_Click" />
                    <asp:Button ID="btnReject" runat="server" CssClass="btn btn-danger btn-action ms-2" 
                                Text="Reject" CommandArgument='<%# Eval("RequestID") %>' OnClick="btnReject_Click" />
                    <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-dark btn-action ms-2" 
                                Text="Delete" CommandArgument='<%# Eval("RequestID") %>' OnClick="btnDelete_Click" />
                </div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
    </div>
</asp:Content>

