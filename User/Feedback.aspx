<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.master" AutoEventWireup="true" CodeFile="Feedback.aspx.cs" Inherits="User_Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        body {
            background: #f4f7f6;
        }
        .feedback-container {
            width: 90%;
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
        .feedback-card {
            background: white;
            padding: 15px;
            border-radius: 12px;
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
        }
        .feedback-card h5 {
            margin: 0;
            font-size: 16px;
            font-weight: bold;
        }
        .feedback-card span {
            font-size: 14px;
            color: #666;
        }
        .btn-submit {
            background: #007bff;
            color: white;
            padding: 10px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            width: 100%;
            transition: 0.3s;
        }
        .btn-submit:hover {
            background: #0056b3;
            transform: scale(1.05);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="feedback-container">
        <h2 class="text-center mb-4">Share Your Feedback</h2>

        <!-- Submit Feedback -->
        <div class="mb-4">
            <label class="form-label">Your Feedback:</label>
            <asp:TextBox ID="txtFeedback" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" Placeholder="Write your feedback here..."></asp:TextBox>
            <div class="text-center mt-3">
                <asp:Button ID="btnSubmitFeedback" runat="server" CssClass="btn btn-submit" Text="Submit Feedback" OnClick="btnSubmitFeedback_Click" />
            </div>
        </div>

        <!-- View Feedback -->
        <h4>Recent Feedback</h4>
        <asp:Repeater ID="rptFeedback" runat="server">
            <ItemTemplate>
                <div class="feedback-card">
                    <h5><%# Eval("FullName") %></h5>
                    <span>Posted on <%# Eval("CreatedAt", "{0:MMM dd, yyyy}") %></span>
                    <p><%# Eval("Message") %></p>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>

