<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="JomUndang.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="Home.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero -->
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

    <!-- Features -->
    <section class="features-section">
        <div class="features-header">
            <span class="features-badge">Our Services</span>
            <h2>Why Choose JomUndang?</h2>
        </div>
        
        <div class="features-container">
            <div class="feature-row">
                <div class="feature-text-box">
                    <h3>Learn Undang</h3>
                    <ul>
                        <li>Study basic Malaysian driving theory knowledge.</li>
                        <li>Includes traffic rules, road signs, and safety regulations.</li>
                        <li>Comprehensive materials for beginners.</li>
                    </ul>
                    <a href="LearnUndang.aspx" class="btn-feature">View More</a>
                </div>
                <div class="feature-image-box">
                    <img src="learn-home.jpg" alt="Learn Undang" />
                </div>
            </div>

            <div class="feature-row reverse">
                <div class="feature-text-box">
                    <h3>Practice Quiz</h3>
                    <ul>
                        <li>Practice KPP questions categorized by topics.</li>
                        <li>Unlimited attempts with immediate feedback.</li>
                        <li>Track your progress as you learn.</li>
                    </ul>
                    <a href="PracticeQuiz.aspx" class="btn-feature">View More</a>
                </div>
                <div class="feature-image-box">
                    <img src="p-home.jpg" alt="Practice Quiz" />
                </div>
            </div>

            <div class="feature-row">
                <div class="feature-text-box">
                    <h3>Mock Test</h3>
                    <ul>
                        <li>Simulate the actual test environment.</li>
                        <li>Same time limit and question format as the real test.</li>
                        <li>Get instant results to gauge your readiness.</li>
                    </ul>
                    <a href="MockTest.aspx" class="btn-feature">View More</a>
                </div>
                <div class="feature-image-box">
                    <img src="mock-home.jpg" alt="Mock Test" />
                </div>
            </div>

            <div class="feature-row reverse">
                <div class="feature-text-box">
                    <h3>Test Registration</h3>
                    <ul>
                        <li>Register for the actual KPP 01 theory test.</li>
                        <li>Select your preferred location and date.</li>
                        <li>View your test history and results easily.</li>
                    </ul>
                    <a href="TestRegistration.aspx" class="btn-feature">View More</a>
                </div>
                <div class="feature-image-box">
                    <img src="regis-home.jpg" alt="Test Registration" />
                </div>
            </div>
        </div>
    </section>

    <!-- Instructor -->
    <section class="instructor-section">
        <div class="instructor-header">
            <h2>Meet Our Team</h2>
            <p>At JomUndang, we're dedicated to providing the best learning experience to help you succeed.</p>
        </div>
        
        <div class="instructor-grid">
            <div class="instructor-card">
                <img src="CaliseHome.jpg" alt="Calise Chew Huan Qing" />
                <div class="instructor-overlay">
                    <h3>Calise Chew Huan Qing</h3>
                    <p>Senior Coach with 6 years of experience</p>
                </div>
            </div>
            
            <div class="instructor-card">
                <img src="SYhome.jpg" alt="Tong Su Yee" />
                <div class="instructor-overlay">
                    <h3>Tong Su Yee</h3>
                    <p>Senior Coach with 5 years of experience</p>
                </div>
            </div>
            
            <div class="instructor-card">
                <img src="PWHome.png" alt="Yeo Pei Wen" />
                <div class="instructor-overlay">
                    <h3>Yeo Pei Wen</h3>
                    <p>Senior Coach with 4 years of experience</p>
                </div>
            </div>
        </div>
    </section>

</asp:Content>