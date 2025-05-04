<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {
            background: linear-gradient(to right, #11998e, #38ef7d);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-container {
            width: 400px;
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
            animation: slideIn 1s ease-in-out;
        }
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .form-control {
            border-radius: 8px;
        }
        .btn-login {
            background: #007bff;
            color: white;
            font-weight: bold;
            transition: 0.3s ease-in-out;
        }
        .btn-login:hover {
            background: #0056b3;
            transform: scale(1.05);
        }
    </style>
    <link href="../Asset/css/bootstrap-5.3.3-dist/css/bootstrap.rtl.min.css" rel="stylesheet"
        type="text/css" />
    <script src="../Asset/css/bootstrap-5.3.3-dist/js/bootstrap.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div class="login-container">
            <h2 class="text-center mb-4">Welcome Back</h2>

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

            <asp:Button ID="btnLogin" runat="server" CssClass="btn btn-login w-100" Text="Sign In" OnClick="btnLogin_Click" />

            <p class="text-center mt-3">Don't have an account? <a href="Register.aspx">Sign up</a></p>
        </div>
    </form>
</body>
</html>
