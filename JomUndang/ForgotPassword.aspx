<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="JomUndang.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section class="auth-section forgot-section">
        <div class="auth-card">
            <span class="auth-badge">Reset Password</span>
            <h1>Forgot Password?</h1>
            <p class="auth-subtitle">Enter your registered email and we'll send you a link to reset your password.</p>

            <!-- Success / error message -->
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="auth-message">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Email -->
            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="jom@gmail.com"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                    ControlToValidate="txtEmail" ErrorMessage="Email is required."
                    Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                    ControlToValidate="txtEmail" ErrorMessage="Please enter a valid email."
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    Display="Dynamic" CssClass="field-error"></asp:RegularExpressionValidator>
            </div>

            <asp:Button ID="btnReset" runat="server" Text="Send Reset Link"
                CssClass="auth-btn" OnClick="btnReset_Click" />

            <p class="auth-footer">
                Remembered it? <a href="Login.aspx">Back to Login</a>
            </p>
            <p class="auth-footer auth-footer-sub">
                Don't have an account? <a href="Register.aspx">Register here</a>
            </p>
        </div>
    </section>

</asp:Content>