<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="ProgrammingTricks.UserViews.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContentContainer" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentContainer" runat="server">
    <div class="container">
        <div class="form-horizontal">
            <h4>Login</h4>
            <p class="text-danger">
                <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
            </p>
            <div class="form-group">
                <label class="col-form-label col-md-2">Benutzername</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtUserName" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ErrorMessage="Das Feld Benutzername ist erforderlich." ControlToValidate="txtUserName" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="col-form-label col-md-2">Password</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtPassword" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Das Feld Password ist erforderlich." ControlToValidate="txtPassword" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
