<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CustomerProfile.aspx.cs" Inherits="JomUndang.CustomerProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-content" style="padding-top: 40px; padding-bottom: 60px; background-color: var(--page-bg); min-height: 80vh;">
        <div class="container" style="max-width: 1100px;">
            
            <!-- Title Section -->
            <div style="margin-bottom: 40px;">
                <h1 style="font-size: 2.2rem; color: var(--heading); font-weight: 700; margin: 0; letter-spacing: -0.5px;">My Dashboard</h1>
            </div>

            <!-- Main Layout -->
            <div style="display: flex; flex-wrap: wrap; gap: 30px; align-items: start;">
                
                <!-- Left Side: Edit Profile & Stats -->
                <div style="flex: 2 1 600px; display: flex; flex-direction: column; gap: 25px;">
                    
                    <!-- Edit Profile Form -->
                    <div style="background: #fff; padding: 35px 40px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03); border: 1px solid #f1f5f9;">
                        <h3 style="margin: 0 0 25px 0; font-size: 1.3rem; color: var(--heading); font-weight: 600;">Edit Profile</h3>
                        
                        <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="auth-message">
                            <asp:Label ID="lblMessage" runat="server"></asp:Label>
                        </asp:Panel>

                        <div class="form-group" style="margin-bottom: 20px;">
                            <asp:Label ID="lblName" runat="server" AssociatedControlID="txtName" Text="Full Name" style="font-weight: 600; color: var(--heading); font-size: 0.95rem; margin-bottom: 8px;"></asp:Label>
                            <asp:TextBox ID="txtName" runat="server" style="background-color: #f8fafc; border: 1px solid var(--border); padding: 12px 15px; border-radius: 10px;"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required." Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group" style="margin-bottom: 20px;">
                            <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email" style="font-weight: 600; color: var(--heading); font-size: 0.95rem; margin-bottom: 8px;"></asp:Label>
                            <asp:TextBox ID="txtEmail" runat="server" style="background-color: #f8fafc; border: 1px solid var(--border); padding: 12px 15px; border-radius: 10px;"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group" style="margin-bottom: 25px;">
                            <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" Text="New Password (Optional)" style="font-weight: 600; color: var(--heading); font-size: 0.95rem; margin-bottom: 8px;"></asp:Label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" style="background-color: #f8fafc; border: 1px solid var(--border); padding: 12px 15px; border-radius: 10px;"></asp:TextBox>
                        </div>

                        <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="auth-btn" OnClick="btnUpdate_Click" style="width: auto; padding: 12px 35px; border-radius: 10px; font-size: 1rem; font-weight: 600;" />
                    </div>

                    <!-- Stats Section -->
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                        
                        <!-- Total Tests -->
                        <div style="grid-column: span 2; background-color: #fff; border-radius: 16px; padding: 25px 30px; display: flex; align-items: center; justify-content: space-between; border: 1px solid #f1f5f9; box-shadow: 0 4px 15px rgba(0,0,0,0.02);">
                            <div>
                                <h2 style="font-size: 2.2rem; color: var(--heading); margin: 0; font-weight: 700; line-height: 1;">
                                    <asp:Label ID="lblTotalTests" runat="server" Text="0"></asp:Label>
                                </h2>
                                <p style="margin: 5px 0 0 0; font-weight: 500; color: #64748b; font-size: 0.95rem;">Total Tests Taken</p>
                            </div>
                            <a href="Test_History.aspx" style="background-color: var(--hero-1); color: var(--color-2); padding: 10px 20px; border-radius: 10px; text-decoration: none; font-size: 0.9rem; font-weight: 600;">Test History</a>
                        </div>
                        
                        <!-- Average Score -->
                        <a href="Practice.aspx" style="background-color: var(--hero-1); border-radius: 16px; padding: 25px 20px; text-decoration: none; display: flex; flex-direction: column; justify-content: center; align-items: center; border: 1px solid rgba(255,255,255,0.5);">
                            <h2 style="font-size: 2rem; color: var(--accent); margin: 0; font-weight: 700; line-height: 1;">
                                <asp:Label ID="lblAvgScore" runat="server" Text="0%"></asp:Label>
                            </h2>
                            <p style="margin: 5px 0 0 0; font-weight: 500; color: var(--heading); font-size: 0.9rem;">Avg Score</p>
                        </a>

                        <!-- Pass Rate -->
                        <a href="MockTest.aspx" style="background-color: #dcfce7; border-radius: 16px; padding: 25px 20px; text-decoration: none; display: flex; flex-direction: column; justify-content: center; align-items: center; border: 1px solid rgba(255,255,255,0.5);">
                            <h2 style="font-size: 2rem; color: #166534; margin: 0; font-weight: 700; line-height: 1;">
                                <asp:Label ID="lblPassRate" runat="server" Text="0%"></asp:Label>
                            </h2>
                            <p style="margin: 5px 0 0 0; font-weight: 500; color: #166534; font-size: 0.9rem;">Pass Rate</p>
                        </a>
                    </div>
                </div>

                <!-- Right Side: Quick Actions & Upcoming Register -->
                <div style="flex: 1 1 300px; display: flex; flex-direction: column; gap: 25px;">
                    
                    <!-- Quick Actions -->
                    <div style="background: #fff; padding: 30px 25px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03); border: 1px solid #f1f5f9;">
                        <h3 style="margin: 0 0 20px 0; font-size: 1.2rem; color: var(--heading); font-weight: 600;">Quick Actions</h3>
                        <div style="display: flex; flex-direction: column; gap: 15px;">
                            <a href="Practice.aspx" class="cta-button" style="text-align: center; padding: 14px; font-size: 1rem; border-radius: 10px; display: block; font-weight: 600;">Practice Quiz</a>
                            <a href="MockTest.aspx" class="cta-button" style="text-align: center; padding: 14px; font-size: 1rem; border-radius: 10px; display: block; font-weight: 600;">Mock Test</a>
                        </div>
                    </div>
                    
                    <!-- Upcoming Register -->
                    <div style="background: #fff; padding: 30px 25px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; min-height: 150px; display: flex; flex-direction: column;">
                        <h3 style="margin: 0 0 15px 0; font-size: 1.2rem; color: var(--heading); font-weight: 600;">Upcoming Register</h3>
                        <div style="flex: 1; display: flex; align-items: center; justify-content: center; background: #f8fafc; border-radius: 12px; padding: 20px; text-align: center;">
                            <asp:Label ID="lblUpcomingTest" runat="server" Text="No upcoming register registered." style="font-size: 0.95rem; color: #64748b; line-height: 1.6;"></asp:Label>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    </div>
</asp:Content>