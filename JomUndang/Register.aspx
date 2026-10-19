<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="JomUndang.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <section class="auth-section register-section">

        <div class="register-intro">
            <h1>Create Account</h1>
            <p>Join JomUndang and start preparing for your Undang test.</p>
            <ul>
                <li>&#10004; Learn traffic rules and road signs</li>
                <li>&#10004; Practice KPP questions by topic</li>
                <li>&#10004; Try full mock tests</li>
            </ul>
        </div>

        <!-- register form -->
        <div class="auth-card">
            
            <!-- Message Box -->
            <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="auth-message">
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </asp:Panel>

            <!-- Full name -->
            <div class="form-group">
                <asp:Label ID="lblName" runat="server" AssociatedControlID="txtName" Text="Full Name"></asp:Label>
                <asp:TextBox ID="txtName" runat="server" placeholder="Your full name"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server"
                    ControlToValidate="txtName" ErrorMessage="Full name is required."
                    Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
            </div>

            <!-- Age -->
            <div class="form-group">
                <asp:Label ID="lblAge" runat="server" AssociatedControlID="txtAge" Text="Age"></asp:Label>
                <asp:TextBox ID="txtAge" runat="server" placeholder="Must be 17 or above"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvAge" runat="server"
                    ControlToValidate="txtAge" ErrorMessage="Age is required."
                    Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
                <asp:RangeValidator ID="rvAge" runat="server"
                    ControlToValidate="txtAge" Type="Integer" MinimumValue="17" MaximumValue="100"
                    ErrorMessage="Age must be between 17 and 100."
                    Display="Dynamic" CssClass="field-error"></asp:RangeValidator>
            </div>

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

            <!-- Role Selection (NEW) -->
            <div class="form-group">
                <asp:Label ID="lblRole" runat="server" AssociatedControlID="ddlRole" Text="Register As"></asp:Label>
                <asp:DropDownList ID="ddlRole" runat="server" style="width: 100%; padding: 12px 14px; font-size: 1rem; background-color: rgba(255, 255, 255, 0.8); border: 1px solid var(--border); border-radius: 8px;">
                    <asp:ListItem Text="Customer" Value="Customer"></asp:ListItem>
                    <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Password -->
            <div class="form-group">
                <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" Text="Password"></asp:Label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="At least 8 characters"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                    ControlToValidate="txtPassword" ErrorMessage="Password is required."
                    Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="revPassword" runat="server"
                    ControlToValidate="txtPassword" ErrorMessage="Password must be at least 8 characters."
                    ValidationExpression="^.{8,}$"
                    Display="Dynamic" CssClass="field-error"></asp:RegularExpressionValidator>
            </div>

            <!-- Confirm password -->
            <div class="form-group">
                <asp:Label ID="lblConfirm" runat="server" AssociatedControlID="txtConfirm" Text="Confirm Password"></asp:Label>
                <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" placeholder="Enter your password again"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirm" runat="server"
                    ControlToValidate="txtConfirm" ErrorMessage="Please confirm your password."
                    Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvConfirm" runat="server"
                    ControlToValidate="txtConfirm" ControlToCompare="txtPassword"
                    ErrorMessage="Passwords do not match."
                    Display="Dynamic" CssClass="field-error"></asp:CompareValidator>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="auth-btn" OnClick="btnRegister_Click" />

            <p class="auth-footer">
                Already have an account? <a href="Login.aspx">Login here</a>
            </p>
        </div>
    </section>

</asp:Content>