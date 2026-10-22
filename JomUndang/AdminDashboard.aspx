<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="JomUndang.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <!-- Styles -->
    <style>
        .admin-table { width: 100%; border-collapse: collapse; table-layout: auto; min-width: 600px; }
        .admin-table th { text-align: left; padding: 15px; background-color: #f8fafc; color: #475569; font-weight: 600; border-bottom: 2px solid #e2e8f0; white-space: nowrap; }
        .admin-table td { padding: 15px; border-bottom: 1px solid #f1f5f9; white-space: nowrap; }
        .admin-table tr:hover { background-color: #f8fafc; }
        
        .admin-table th:last-child, 
        .admin-table td:last-child { 
            text-align: right !important; 
        }
        
        .btn-approve { background-color: #dcfce7; color: #166534; border-radius: 8px; padding: 6px 16px; text-decoration: none; font-size: 0.9rem; font-weight: 600; display: inline-block; margin-right: 5px; }
        .btn-reject { background-color: transparent; color: #64748b; border-radius: 8px; padding: 6px 12px; text-decoration: none; font-size: 0.9rem; display: inline-block; }
        
        .status-pass { background-color: #dcfce7; color: #166534; padding: 4px 12px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; }
        .status-fail { background-color: #fee2e2; color: #991b1b; padding: 4px 12px; border-radius: 20px; font-size: 0.85rem; font-weight: 600; }
        
        .filter-select { padding: 8px 16px; border-radius: 8px; border: 1px solid var(--border); background-color: #fff; font-size: 0.9rem; outline: none; }
        
        /* Vertical Stats Card */
        .v-stats-card { display: flex; flex-direction: column; background: #fff; border-radius: 16px; border: 1px solid var(--border); box-shadow: 0 4px 15px rgba(0,0,0,0.02); overflow: hidden; }
        .v-stat-item { padding: 20px 25px; border-bottom: 1px solid var(--border); text-decoration: none; display: block; transition: background 0.2s; }
        .v-stat-item:last-child { border-bottom: none; }
        .v-stat-item:hover { background-color: #f8fafc; }
        .v-stat-label { color: #64748b; font-size: 0.9rem; font-weight: 500; margin-bottom: 5px; display: flex; justify-content: space-between; align-items: center; }
        .v-stat-value { font-size: 2rem; font-weight: 700; line-height: 1; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-content" style="padding-top: 40px; padding-bottom: 60px; background-color: var(--page-bg); min-height: 80vh;">
        <div class="container" style="max-width: 1100px;">
            
            <!-- Title -->
            <div style="margin-bottom: 30px;">
                <h1 style="font-size: 2.2rem; color: var(--heading); font-weight: 700; margin: 0;">Admin Dashboard</h1>
            </div>

            <!-- Top Layout -->
            <div style="display: flex; flex-wrap: wrap; gap: 30px; align-items: stretch; margin-bottom: 30px;">
                
                <!-- Edit Profile -->
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

                <!-- Right Side: Stats & Links -->
                <div style="flex: 1 1 300px; display: flex; flex-direction: column;">
                    
                    <div class="v-stats-card">
                        <!-- Total Users -->
                        <div class="v-stat-item" style="cursor: default;">
                            <div class="v-stat-label">Total users</div>
                            <div class="v-stat-value" style="color: var(--heading);">
                                <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                            </div>
                        </div>
                        
                        <!-- Tests Taken -->
                        <a href="ManageTests.aspx" class="v-stat-item">
                            <div class="v-stat-label">
                                <span>Tests taken</span>
                                <span style="color: var(--accent); font-weight: 600;">Manage Tests</span>
                            </div>
                            <div class="v-stat-value" style="color: var(--heading);">
                                <asp:Label ID="lblTotalTests" runat="server" Text="0"></asp:Label>
                            </div>
                        </a>

                        <!-- Pending Approvals -->
                        <div class="v-stat-item" style="cursor: default;">
                            <div class="v-stat-label">Pending Approvals</div>
                            <div class="v-stat-value" style="color: #dc2626;">
                                <asp:Label ID="lblPendingUsers" runat="server" Text="0"></asp:Label>
                            </div>
                        </div>

                        <!-- Manage Questions -->
                        <a href="ManageQuestions.aspx" class="v-stat-item" style="display: flex; align-items: center; justify-content: center; min-height: 75px; background-color: #f8fafc;">
                            <span style="color: var(--accent); font-weight: 600; font-size: 0.95rem;">Manage Questions</span>
                        </a>
                    </div>

                </div>
            </div>

            <!-- Pending Approvals Grid -->
            <div style="background: #fff; padding: 30px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid #f1f5f9; margin-bottom: 30px; overflow-x: auto;">
                <div style="margin-bottom: 10px;">
                    <h3 style="margin: 0; font-size: 1.3rem; color: var(--heading); font-weight: 600;">Pending Admin Approvals</h3>
                    <p style="margin: 5px 0 20px 0; color: #64748b; font-size: 0.9rem;">People who registered as admin and are waiting for access.</p>
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

            <!-- Test Results Grid -->
            <div style="background: #fff; padding: 30px; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); border: 1px solid #f1f5f9; overflow-x: auto;">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h3 style="margin: 0; font-size: 1.3rem; color: var(--heading); font-weight: 600;">Latest test results</h3>
                    
                    <!-- Filter Dropdown -->
                    <div style="display: flex; align-items: center; gap: 10px;">
                        <span style="color: #64748b; font-size: 0.9rem;">Filter by result</span>
                        <asp:DropDownList ID="ddlFilterResult" runat="server" CssClass="filter-select" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterResult_SelectedIndexChanged">
                            <asp:ListItem Text="All" Value="All"></asp:ListItem>
                            <asp:ListItem Text="Pass" Value="Pass"></asp:ListItem>
                            <asp:ListItem Text="Fail" Value="Fail"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <asp:GridView ID="gvTestResults" runat="server" AutoGenerateColumns="False" 
                    CssClass="admin-table" GridLines="None" Width="100%"
                    EmptyDataText="No test results found.">
                    <Columns>
                        <asp:BoundField DataField="FullName" HeaderText="Student" ItemStyle-ForeColor="#1e1b4b" />
                        <asp:BoundField DataField="TestName" HeaderText="Test" ItemStyle-ForeColor="#1e1b4b" />
                        <asp:BoundField DataField="ScoreDisplay" HeaderText="Score" ItemStyle-ForeColor="#1e1b4b" />
                        
                        <asp:TemplateField HeaderText="Result">
                            <ItemTemplate>
                                <span class='<%# Convert.ToBoolean(Eval("IsPassed")) ? "status-pass" : "status-fail" %>'>
                                    <%# Convert.ToBoolean(Eval("IsPassed")) ? "Pass" : "Fail" %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="TestDate" HeaderText="When" DataFormatString="{0:dd MMM yyyy}" ItemStyle-ForeColor="#1e1b4b" />
                    </Columns>
                </asp:GridView>
            </div>

        </div>
    </div>
</asp:Content>