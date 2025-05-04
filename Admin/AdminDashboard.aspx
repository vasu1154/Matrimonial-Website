<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.master" AutoEventWireup="true" CodeFile="AdminDashboard.aspx.cs" Inherits="Admin_AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        body {
            background: #f4f7f6;
        }
        .dashboard-container {
            width: 95%;
            max-width: 1200px;
            margin: 40px auto;
        }
        .card {
            border-radius: 12px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease-in-out;
            background: white;
            padding: 20px;
            text-align: center;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.2);
        }
        .card-title {
            font-weight: bold;
            font-size: 1.2rem;
            margin-top: 10px;
        }
        .card i {
            font-size: 2.5rem;
            color: #fff;
        }
        .stat {
            font-size: 1.8rem;
            font-weight: bold;
        }
        .admin-actions .btn {
            font-size: 1rem;
            padding: 12px;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s;
        }
        .admin-actions .btn:hover {
            transform: scale(1.05);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="dashboard-container">
        <h2 class="text-center mb-4">Admin Dashboard</h2>
        
        <!-- Stats Cards -->
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card bg-primary text-white">
                    <i class="fas fa-users"></i>
                    <h5 class="card-title">Total Users</h5>
                    <asp:Label ID="lblTotalUsers" runat="server" CssClass="stat"></asp:Label>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="card bg-warning text-dark">
                    <i class="fas fa-envelope"></i>
                    <h5 class="card-title">Total Requests</h5>
                    <asp:Label ID="lblTotalRequests" runat="server" CssClass="stat"></asp:Label>
                </div>
            </div>

            <div class="col-md-4 mb-4">
                <div class="card bg-danger text-white">
                    <i class="fas fa-exclamation-circle"></i>
                    <h5 class="card-title">Pending Requests</h5>
                    <asp:Label ID="lblPendingRequests" runat="server" CssClass="stat"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Admin Controls -->
        <div class="row admin-actions">
            <div class="col-md-4">
                <a href="ManageUsers.aspx" class="btn btn-primary w-100">👤 Manage Users</a>
            </div>
            <div class="col-md-4">
                <a href="ManageRequests.aspx" class="btn btn-warning w-100">💌 Manage Requests</a>
            </div>
            <div class="col-md-4">
                <a href="ViewFeedback.aspx" class="btn btn-info w-100">📝 Manage Feedback</a>
            </div>
        </div>
    </div>
</asp:Content>

