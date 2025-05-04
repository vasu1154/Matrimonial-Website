<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="ManageUsers.aspx.cs" Inherits="Admin_ManageUsers" %>

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
        .btn-danger, .btn-success {
            transition: 0.3s;
        }
        .btn-danger:hover, .btn-success:hover {
            transform: scale(1.05);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="container">
        <h2 class="text-center mb-4">Manage Users</h2>

        <!-- Add User Form -->
        <div class="mb-4">
            <h4>Add New User</h4>
            <div class="row">
                <div class="col-md-4 mb-2">
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" Placeholder="Full Name"></asp:TextBox>
                </div>
                <div class="col-md-4 mb-2">
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email"></asp:TextBox>
                </div>
                <div class="col-md-4 mb-2">
                    <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Select Role" Value="" />
                        <asp:ListItem Text="Admin" Value="Admin" />
                        <asp:ListItem Text="User" Value="User" />
                    </asp:DropDownList>
                </div>
            </div>
            <div class="text-center">
                <asp:Button ID="btnAddUser" runat="server" CssClass="btn btn-success" Text="Add User" OnClick="btnAddUser_Click" />
            </div>
        </div>

        <!-- Users List -->
        <h4>All Users</h4>
        <asp:Repeater ID="rptUsers" runat="server">
            <ItemTemplate>
                <div class="card mb-3">
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="d-flex align-items-center">
                            <img src='<%# ResolveUrl(string.IsNullOrEmpty(Eval("ProfileImage").ToString()) ? "~/Asset/images/default-user.png" : Eval("ProfileImage").ToString()) %>' 
                                 alt="Profile" class="user-img me-3">
                            <div>
                                <h5 class="mb-1"><%# Eval("FullName") %></h5>
                                <span>Email: <%# Eval("Email") %> | Role: <%# Eval("Role") %></span>
                            </div>
                        </div>
                        <asp:Button ID="btnDelete" runat="server" CssClass="btn btn-danger" Text="Delete" CommandArgument='<%# Eval("UserID") %>' OnClick="btnDelete_Click" />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>

