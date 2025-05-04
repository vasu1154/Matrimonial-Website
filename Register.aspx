<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../Asset/css/bootstrap-5.3.3-dist/css/bootstrap.rtl.min.css" rel="stylesheet"
        type="text/css" />
    <script src="../Asset/css/bootstrap-5.3.3-dist/js/bootstrap.min.js" type="text/javascript"></script>
    <style>
        body {
            background: linear-gradient(to right, #1d2671, #c33764);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .register-container {
            width: 450px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .form-control {
            border-radius: 8px;
        }
        .btn-register {
            background: #ff4b2b;
            color: white;
            font-weight: bold;
            transition: 0.3s ease-in-out;
        }
        .btn-register:hover {
            background: #ff416c;
            transform: scale(1.05);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="register-container">
            <h2 class="text-center mb-4">Create Account</h2>

            <div class="mb-3">
                <label class="form-label">Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" required></asp:TextBox>
                <br />
                <br />
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" required></asp:TextBox>
                <br />
                <br />
            </div>

            <div class="mb-3">
                <label class="form-label">Phone</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" required></asp:TextBox>
                <br />
                <br />
            </div>

            <div class="mb-3">
                <label class="form-label">Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" required></asp:TextBox>
                <br />
                <br />
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required></asp:TextBox>
                <br />
                <br />
            </div>

            <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-register w-100" Text="Sign Up" OnClick="btnRegister_Click" />

            <p class="text-center mt-3">Already have an account? <a href="Login.aspx">Sign in</a></p>
        </div>
    </form>
</body>
</html>
