<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="JomUndang.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .admin-table { width: 100%; border-collapse: collapse; table-layout: auto; }
        .admin-table th { text-align: left; padding: 15px; background-color: #f8fafc; color: #475569; font-weight: 600; border-bottom: 2px solid #e2e8f0; }
        .admin-table td { padding: 15px; border-bottom: 1px solid #f1f5f9; }
        .admin-table tr:hover { background-color: #f8fafc; }
        
        .admin-table th:last-child, 
        .admin-table td:last-child { 
            text-align: right !important; 
        }
        
        .btn-approve { background-color: #22c55e; color: white; border-radius: 8px; padding: 8px 16px; text-decoration: none; font-size: 0.9rem; margin-right: 5px; display: inline-block; }
        .btn-reject { background-color: #ef4444; color: white; border-radius: 8px; padding: 8px 16px; text-decoration: none; font-size: 0.9rem; display: inline-block; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-content" style="padding-top: 40px; padding-bottom: 60px; background-color: var(--page-bg); min-height: 80vh;">
        <div class="container" style="max-width: 1100px;">
            
            <!-- Title -->
            <div style="margin-bottom: 40px;">
                <h1 style="font-size: 2.2rem; color: var(--heading); font-weight: 700; margin: 0;">Admin Dashboard</h1>
            </div>

            <!-- Main Layout -->
            <div style="display: flex; flex-wrap: wrap; gap: 30px; align-items: start; margin-bottom: 40px;">
                
                <!-- Left Side: Edit Profile -->
                <div style="flex: 2 1 500px; background: #fff; padding: 35px 40px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.03); border: 1px solid #f1f5f9;">
                    <h3 style="margin: 0 0 25px 0; font-size: 1.3rem; color: var(--heading); font-weight: 600;">Edit Profile</h3>
                    
                    <asp:Panel ID="pnlMessage" runat="server" Visible="false" CssClass="auth-message">
                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                    </asp:Panel>

                    <div class="form-group" style="margin-bottom: 20px;">
                        <asp:Label ID="lblName" runat="server" AssociatedControlID="txtName" Text="Full Name" style="font-weight: 600; color: var(--heading); font-size: 0.95rem; margin-bottom: 8px;"></asp:Label>
                        <asp:TextBox ID="txtName" runat="server" style="background-color: #f8fafc; border: 1px solid var(--border); padding: 12px 15px; border-radius: 10px; width: 100%;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Name is required." Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group" style="margin-bottom: 20px;">
                        <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email" style="font-weight: 600; color: var(--heading); font-size: 0.95rem; margin-bottom: 8px;"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" style="background-color: #f8fafc; border: 1px solid var(--border); padding: 12px 15px; border-radius: 10px; width: 100%;"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required." Display="Dynamic" CssClass="field-error"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group" style="margin-bottom: 25px;">
                        <asp:Label ID="lblPassword" runat="server" AssociatedControlID="txtPassword" Text="New Password (Optional)" style="font-weight: 600; color: var(--heading); font-size: 0.95rem; margin-bottom: 8px;"></asp:Label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" style="background-color: #f8fafc; border: 1px solid var(--border); padding: 12px 15px; border-radius: 10px; width: 100%;"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="auth-btn" OnClick="btnUpdate_Click" style="width: auto; padding: 12px 35px; border-radius: 10px; font-size: 1rem; font-weight: 600;" />
                </div>

                <!-- Right Side: Stats & Actions -->
                <div style="flex: 1 1 350px; display: flex; flex-direction: column; gap: 25px;">
                    
                    <!-- Stats Section -->
                    <div style="display: flex; flex-direction: column; gap: 15px;">
                        <div style="background: #fff; padding: 20px; border-radius: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <h2 style="font-size: 1.8rem; color: var(--color-2); margin: 0; font-weight: 700;">
                                    <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                                </h2>
                                <p style="margin: 0; font-weight: 500; color: #64748b; font-size: 0.9rem;">Total Users</p>
                            </div>
                        </div>

                        <div style="background: #fff; padding: 20px; border-radius: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <h2 style="font-size: 1.8rem; color: #dc2626; margin: 0; font-weight: 700;">
                                    <asp:Label ID="lblPendingUsers" runat="server" Text="0"></asp:Label>
                                </h2>
                                <p style="margin: 0; font-weight: 500; color: #64748b; font-size: 0.9rem;">Pending Approvals</p>
                            </div>
                        </div>

                        <div style="background: #fff; padding: 20px; border-radius: 16px; box-shadow: 0 4px 15px rgba(0,0,0,0.03); border: 1px solid #f1f5f9; display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <h2 style="font-size: 1.8rem; color: #166534; margin: 0; font-weight: 700;">
                                    <asp:Label ID="lblTotalTests" runat="server" Text="0"></asp:Label>
                                </h2>
                                <p style="margin: 0; font-weight: 500; color: #64748b; font-size: 0.9rem;">Tests Taken</p>
                            </div>
                        </div>
                    </div>

                    <!-- Quick Actions -->
                    <div>
                        <a href="ManageQuestions.aspx" class="cta-button" style="text-align: center; padding: 14px; border-radius: 12px; display: block; margin-bottom: 15px;">Manage Questions</a>
                        <a href="ManageTests.aspx" class="cta-button" style="text-align: center; padding: 14px; border-radius: 12px; display: block;">Manage Tests</a>
                    </div>

                </div>
            </div>

            <!-- Bottom Row: Pending Approvals -->
            <div style="background: #fff; padding: 30px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid #f1f5f9;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h3 style="margin: 0; font-size: 1.3rem; color: var(--heading); font-weight: 600;">Pending Admin Approvals</h3>
                </div>

                <asp:Panel ID="pnlApprovalMessage" runat="server" Visible="false" CssClass="auth-message"></asp:Panel>

                <asp:GridView ID="gvPendingAdmins" runat="server" AutoGenerateColumns="False" 
                    CssClass="admin-table" GridLines="None" Width="100%"
                    OnRowCommand="gvPendingAdmins_RowCommand"
                    EmptyDataText="No pending admin registrations at the moment.">
                    <Columns>
                        <asp:BoundField DataField="FullName" HeaderText="Full Name" ItemStyle-ForeColor="#1e1b4b" ItemStyle-Font-Bold="true" />
                        <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-ForeColor="#64748b" />
                        <asp:BoundField DataField="CreatedAt" HeaderText="Date Applied" DataFormatString="{0:dd MMM yyyy}" ItemStyle-ForeColor="#64748b" />
                        
                        <asp:TemplateField HeaderText="Action" HeaderStyle-HorizontalAlign="Right" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="220px">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnApprove" runat="server" 
                                    CommandName="Approve" 
                                    CommandArgument='<%# Eval("UserID") %>' 
                                    CssClass="btn-approve" 
                                    OnClientClick="return confirm('Are you sure you want to approve this Admin?');">
                                    Approve
                                </asp:LinkButton>

                                <asp:LinkButton ID="btnReject" runat="server" 
                                    CommandName="Reject" 
                                    CommandArgument='<%# Eval("UserID") %>' 
                                    CssClass="btn-reject" 
                                    OnClientClick="return confirm('Are you sure you want to REJECT and delete this request?');">
                                    Reject
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

        </div>
    </div>
</asp:Content>