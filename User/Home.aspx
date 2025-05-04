<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="User_Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        /* Hero Section */
        .hero {
            background: linear-gradient(to right, #1d2671, #c33764);
            color: white;
            padding: 80px 20px;
            text-align: center;
            border-radius: 10px;
            animation: fadeIn 1.5s ease-in-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Featured Profiles Section */
        .profile-card {
            border-radius: 12px;
            overflow: hidden;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2);
        }

        .profile-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .profile-card .card-body {
            text-align: center;
            background: white;
            padding: 15px;
        }

        .btn-view {
            background: #007bff;
            color: white;
            font-weight: bold;
            transition: 0.3s ease-in-out;
        }

        .btn-view:hover {
            background: #0056b3;
            transform: scale(1.05);
        }

        /* About Section */
        .about-section {
            padding: 60px 20px;
            text-align: center;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero {
                padding: 50px 10px;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="hero">
        <h1>Welcome to Elite Match</h1>
        <p>Find your perfect match with our trusted matrimonial services.</p>
        <a href="../Register.aspx" class="btn btn-light btn-lg">Join Now</a>
    </div>

    <!-- Featured Profiles Section -->
    <div class="container mt-5">
        <h2 class="text-center mb-4">Featured Profiles</h2>
        <div class="row">
            <asp:Repeater ID="rptProfiles" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <div class="card profile-card">
                            <img src='<%# string.IsNullOrEmpty(Eval("ProfileImage").ToString()) ? "Asset/images/default-user.png" : ResolveUrl(Eval("ProfileImage").ToString()) %>' 
                     alt="Profile Image" class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title"><%# Eval("FullName") %></h5>
                                <p class="card-text"><%# Eval("Address") %></p>
                                <a href="Profile.aspx?UserID=<%# Eval("UserID") %>" class="btn btn-view">View Profile</a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <!-- About Section -->
    <div class="about-section bg-light">
        <h2>About Elite Match</h2>
        <p>Elite Match is a leading matrimonial platform dedicated to helping individuals find their perfect life partners. With a secure and user-friendly platform, we ensure a smooth and successful matchmaking experience.</p>
    </div>
</asp:Content>

