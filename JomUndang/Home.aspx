<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="JomUndang.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Home.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="hero-content">
            <h1>Pass Your Undang Test with Confidence</h1>
            <p>Learn the rules, Practice by topic, Try full mock tests, all in one place.</p>
            <div class="hero-buttons">
                <a href="Register.aspx" class="btn-primary">Start Journey</a>
                <a href="Login.aspx" class="btn-secondary">Login Now</a>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section">
        <div class="section-title">
            <h2>Why Choose JomUndang?</h2>
            <p>Everything you need to prepare for your driving theory test in one place.</p>
        </div>
        
        <div class="features-grid">
            <!-- card 1 -->
            <a href="LearnUndang.aspx" class="feature-card">
                <div class="feature-icon">&#x1F4DA;</div>
                <h3>Learn Undang</h3>
                <p>Study basic Malaysian driving theory knowledge including traffic rules, road signs, and safety regulations.</p>
            </a>
            
            <!-- card 2 -->
            <a href="PracticeQuiz.aspx" class="feature-card">
                <div class="feature-icon">&#x1F4DD;</div>
                <h3>Practice Quiz</h3>
                <p>Practice KPP questions categorized by topics with unlimited attempts and immediate feedback.</p>
            </a>
            
            <!-- card 3 -->
            <a href="MockTest.aspx" class="feature-card">
                <div class="feature-icon">&#x1F4CA;</div>
                <h3>Mock Test</h3>
                <p>Simulate the actual test environment with the same time limit and question format. Get instant results.</p>
            </a>
            
            <!-- card 4 -->
            <a href="TestRegistration.aspx" class="feature-card">
                <div class="feature-icon">&#x1F6A6;</div>
                <h3>Test Registration</h3>
                <p>Register for the actual KPP 01 theory test, select your preferred location, and view your history.</p>
            </a>
        </div>
    </section>

    <!-- Meet Team Section -->
    <section class="team-section">
        <div class="section-title">
            <h2>Meet Our Team</h2>
            <p>The developers behind JomUndang</p>
        </div>
        
        <div class="team-grid">
            <div class="team-member">
                <div class="team-avatar">
                    <img src="people.jpg" alt="Calise Chew Huan Qing" />
                </div>
                <h3>Calise Chew Huan Qing</h3>
                <p>Senior Coach with 6 years of experience</p>
            </div>
            <div class="team-member">
                <div class="team-avatar">
                    <img src="people.jpg" alt="Tong Su Yee" />
                </div>
                <h3>Tong Su Yee</h3>
                <p>Senior Coach with 5 years of experience</p>
            </div>
            <div class="team-member">
                <div class="team-avatar">
                    <img src="people.jpg" alt="Yeo Pei Wen" />
                </div>
                <h3>Yeo Pei Wen</h3>
                <p>Senior Coach with 4 years of experience</p>
            </div>
        </div>
    </section>

</asp:Content>