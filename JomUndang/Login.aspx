<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="JomUndang.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section class="auth-section">
        <div class="auth-card">
            <span class="auth-badge">Login</span>
            <h1>Welcome Back</h1>
            <p class="auth-subtitle">Login to continue your Undang journey.</p>

            <div class="form-group">
                <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email"></asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" placeholder="jom@gmail.com"></asp:TextBox>

                <!-- Form validation: required + email format -->
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                    ControlToValidate="txtEmail" ErrorMessage="Email is required."
                    Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                    ControlToValidate="txtEmail" ErrorMessage="Please enter a valid email."
                    ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                    Display="Dynamic" CssClass="field-error"></asp:RegularExpressionValidator>
            </div>

            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" Text="Password"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                    ControlToValidate="txtPassword" ErrorMessage="Password is required."
                    Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
            </div>

            <div class="auth-options">
                <a href="ForgotPassword.aspx">Forgot password?</a>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="auth-btn" />

            <p class="auth-footer">
                Don't have an account? <a href="Register.aspx">Register here</a>
            </p>
        </div>
    </section>

</asp:Content>