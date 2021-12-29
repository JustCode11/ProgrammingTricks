<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="ProgrammingTricks.UserViews.Manage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContentContainer" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentContainer" runat="server">
    <div class="container">
        <h2>Benutzerprofil</h2>
        <div>
            <dl class="row">
                <dt class="col-md-2">Benutzername</dt>
                <dd class="col-md-2">
                    <asp:Label ID="lblUserName" runat="server" Text=""></asp:Label></dd>
            </dl>
            <dl class="row">
                <dt class="col-md-2">Email</dt>
                <dd class="col-md-2">
                    <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label></dd>
            </dl>
            <dl class="row">
                <dt class="col-md-2">Passwort</dt>
                <dd class="col-md-2">
                    <asp:LinkButton ID="lbChangePassword" runat="server" PostBackUrl="~/UserViews/PasswordChange.aspx">[Passwort ändern]</asp:LinkButton></dd>
                <asp:Label ID="lblPasswordChangedInfo" runat="server" Text="" CssClass="text-info"></asp:Label>
            </dl>
        </div>
        <div>
            <dl class="row">
                <dt class="col-md-2">Erstellte Einträge</dt>
                <dd class="col-md-2"><asp:Label ID="lblCreatedEntries" runat="server" Text=""></asp:Label></dd>
            </dl>
            <dl class="row">
                <dt class="col-md-2">Erstellte Kommentare</dt>
                <dd class="col-md-2"><asp:Label ID="lblCreatedComments" runat="server" Text=""></asp:Label></dd>
            </dl>
        </div>
        <div>
            <h3>Deine Einträge</h3>
            <asp:GridView ID="gvUserEntries" runat="server" DataKeyNames="TricksId" 
                AutoGenerateColumns="false" AllowPaging="true" 
                ItemType="ProgrammingTricks.Models.TricksGridViewModel" 
                SelectMethod="gvUserEntries_GetData" PageSize="4" CssClass="table table-bordered">
                <Columns>
                    <asp:BoundField DataField="UploadDate" DataFormatString="{0:d}" HeaderText="Uploaded" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="Description" HeaderText="Beschreibung" />
                    <asp:BoundField DataField="Language" HeaderText="Programmiersprache" />
                </Columns>
                <PagerSettings Mode="NextPreviousFirstLast" />
                <PagerStyle HorizontalAlign="Center" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>
