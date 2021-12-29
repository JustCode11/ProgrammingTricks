<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NewEntrie.aspx.cs" Inherits="ProgrammingTricks.Formular.NewEntrie" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContentContainer" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentContainer" runat="server">
    <div class="container">
        <div class="form-horizontal">
            <h4>Neuen Eintrag erstellen</h4>
            <div class="form-group">
                <label class="col-form-label col-md-5">Titel</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtTitle" CssClass="form-control" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTitle" runat="server" ErrorMessage="Titel wird benötigt." ControlToValidate="txtTitle" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="col-form-label col-md-5">Beschreibung (max: 100 Zeichen)</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtDescription" CssClass="form-control" MaxLength="100" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ErrorMessage="Beschreibung wird benötigt." CssClass="text-danger" ControlToValidate="txtDescription" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="col-form-label col-md-5">Geben Sie hier den Programmcode ein</label>
                <div class="col-md-10">
                    <asp:TextBox ID="txtTrickContent" CssClass="form-control" TextMode="MultiLine" Columns="100" Rows="10" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTrickContent" runat="server" ErrorMessage="Code wird benötigt." CssClass="text-danger" ControlToValidate="txtTrickContent" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
            </div>
            <div class="form-group">
                <label class="col-form-label col-md-5">Verwendete Programmiersprache</label>
                <div class="col-md-10">
                    <asp:DropDownList ID="ddlLanguage" CssClass="form-control dropdown-toggle" DataValueField="LanguageId" DataTextField="LanguageName" runat="server"></asp:DropDownList>
                </div>
            </div>
            <div class="form-group">
                <asp:Button ID="btnSend" CssClass="btn btn-primary" runat="server" Text="Erstellen" OnClick="btnSend_Click" />
                <asp:Label ID="lblError" runat="server" Text="" CssClass="text-danger"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>
