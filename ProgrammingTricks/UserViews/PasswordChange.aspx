<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PasswordChange.aspx.cs" Inherits="ProgrammingTricks.UserViews.PasswordChange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="headContentContainer" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentContainer" runat="server">
    <div class="container">
        <h2>Passwort ändern</h2>
        <div class="form-horizontal">
            <p class="text-danger">
                <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
            </p>
            <div class="form-group">
                <label class="col-form-label col-md-2">Altes Passwort</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtOldPassword" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvOldPassword" runat="server" ErrorMessage="Das Feld darf nicht leer sein!" ControlToValidate="txtOldPassword" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="col-form-label col-md-2">Neues Passwort</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtNewPassword" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ErrorMessage="Das Feld darf nicht leer sein!" ControlToValidate="txtNewPassword" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="col-form-label col-md-2">Neues Passwort wiederholen</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtConfirmNewPassword" CssClass="form-control" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmNewPassword" runat="server" ErrorMessage="Das Feld darf nicht leer sein!" ControlToValidate="txtConfirmNewPassword" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="dvConfirmNewPassword" runat="server" ErrorMessage="Die beiden eingegeben Passwörter stimmen nicht überein!" ControlToCompare="txtNewPassword" ControlToValidate="txtConfirmNewPassword" CssClass="text-danger" Display="Dynamic"></asp:CompareValidator>
                </div>
            </div>
            <div class="form-group">
                <div class="col-md-offset-2 col-md-10">
                    <asp:Button ID="btnChangePassword" runat="server" Text="Passwort ändern" CssClass="btn btn-secondary" OnClick="btnChangePassword_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
