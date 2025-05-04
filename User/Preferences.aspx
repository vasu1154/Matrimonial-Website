<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.master" AutoEventWireup="true" CodeFile="Preferences.aspx.cs" Inherits="User_Preferences" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
        body {
            background: #f4f7f6;
        }
        .preferences-container {
            width: 80%;
            max-width: 800px;
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
        .form-control {
            border-radius: 8px;
        }
        .btn-save {
            background: #007bff;
            color: white;
            font-weight: bold;
            transition: 0.3s ease-in-out;
        }
        .btn-save:hover {
            background: #0056b3;
            transform: scale(1.05);
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="preferences-container">
        <h2 class="text-center mb-4">Set Your Preferences</h2>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Preferred Age From</label>
                <asp:DropDownList ID="ddlPreferredAgeFrom" runat="server" CssClass="form-control">
                    <asp:ListItem Text="18" Value="18"></asp:ListItem>
                    <asp:ListItem Text="19" Value="19"></asp:ListItem>
                    <asp:ListItem Text="20" Value="20"></asp:ListItem>
                    <asp:ListItem Text="25" Value="25"></asp:ListItem>
                    <asp:ListItem Text="30" Value="30"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Preferred Age To</label>
                <asp:DropDownList ID="ddlPreferredAgeTo" runat="server" CssClass="form-control">
                    <asp:ListItem Text="25" Value="25"></asp:ListItem>
                    <asp:ListItem Text="30" Value="30"></asp:ListItem>
                    <asp:ListItem Text="35" Value="35"></asp:ListItem>
                    <asp:ListItem Text="40" Value="40"></asp:ListItem>
                    <asp:ListItem Text="45" Value="45"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Preferred Gender</label>
                <asp:DropDownList ID="ddlPreferredGender" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Any" Value="Any"></asp:ListItem>
                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Preferred Location</label>
                <asp:TextBox ID="txtPreferredLocation" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Preferred Religion</label>
                <asp:DropDownList ID="ddlReligion" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Hindu" Value="Hindu"></asp:ListItem>
                    <asp:ListItem Text="Muslim" Value="Muslim"></asp:ListItem>
                    <asp:ListItem Text="Christian" Value="Christian"></asp:ListItem>
                    <asp:ListItem Text="Sikh" Value="Sikh"></asp:ListItem>
                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-md-6 mb-3">
                <label class="form-label">Preferred Caste</label>
                <asp:DropDownList ID="ddlCaste" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Any" Value="Any"></asp:ListItem>
                    <asp:ListItem Text="Brahmin" Value="Brahmin"></asp:ListItem>
                    <asp:ListItem Text="Kshatriya" Value="Kshatriya"></asp:ListItem>
                    <asp:ListItem Text="Vaishya" Value="Vaishya"></asp:ListItem>
                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="col-md-12 mb-3">
                <label class="form-label">Additional Preferences</label>
                <asp:TextBox ID="txtAdditionalPreferences" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
            </div>
        </div>

        <div class="text-center">
            <asp:Button ID="btnSavePreferences" runat="server" CssClass="btn btn-save w-50" Text="Save Preferences" OnClick="btnSavePreferences_Click" />
        </div>
    </div>
</asp:Content>

