<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="JomUndang.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section class="auth-section forgot-section">
        <div class="auth-card">
            <span class="auth-badge">Reset Password</span>
            <h1>Forgot Password?</h1>
            <p class="auth-subtitle">Enter your registered email to reset your password.</p>

            <!-- Message Box -->
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="auth-message">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Hidden Field for Email -->
            <asp:HiddenField ID="hiddenEmail" runat="server" />

            <!-- Email Input -->
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

            <!-- New Password Input -->
            <asp:Panel ID="pnlNewPassword" runat="server" Visible="false">
                <div class="form-group">
                    <asp:Label ID="lblNewPassword" runat="server" AssociatedControlID="txtNewPassword" Text="New Password"></asp:Label>
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="At least 8 characters"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server"
                        ControlToValidate="txtNewPassword" ErrorMessage="Password is required."
                        Display="Dynamic" CssClass="field-error" ValidationGroup="ResetGroup"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revNewPassword" runat="server"
                        ControlToValidate="txtNewPassword" ErrorMessage="Password must be at least 8 characters."
                        ValidationExpression="^.{8,}$" Display="Dynamic" CssClass="field-error" ValidationGroup="ResetGroup"></asp:RegularExpressionValidator>
                </div>
            </asp:Panel>

            <!-- Buttons -->
            <asp:Button ID="btnCheckEmail" runat="server" Text="Continue" CssClass="auth-btn" OnClick="btnCheckEmail_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Update Password" CssClass="auth-btn" OnClick="btnReset_Click" Visible="false" ValidationGroup="ResetGroup" style="margin-top: 10px;" />

            <!-- Footer Links -->
            <p class="auth-footer">
                Remembered it? <a href="Login.aspx">Back to Login</a>
            </p>
        </div>
    </section>

</asp:Content>