<%@ Page Title="" MaintainScrollPositionOnPostback="true" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ProgrammingTricks.Default" %>

<%@ Register Assembly="Microsoft.AspNet.EntityDataSource" Namespace="Microsoft.AspNet.EntityDataSource" TagPrefix="ef" %>
<asp:Content ID="Content1" ContentPlaceHolderID="headContentContainer" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentContainer" runat="server">
    <div class="container">
        <h1>Programmier Tricks</h1>
        <p>Willkommen auf meiner Internetseite wo sich User gegenseitig die besten Programmier Tricks vorstellen können.</p>
        <div class="trick-table-container">
            <asp:GridView ID="gvTricks" runat="server" AutoGenerateColumns="False"
                DataKeyNames="TricksId" CssClass="table table-bordered" AllowPaging="true"
                ItemType="ProgrammingTricks.Models.TricksGridViewModel" AllowSorting="true"
                OnSelectedIndexChanged="gvTricks_SelectedIndexChanged" SelectMethod="gvTricks_GetData" PageSize="4">
                <Columns>
                    <asp:BoundField DataField="UploadDate" DataFormatString="{0:d}" HeaderText="Uploaded" SortExpression="UploadDate" />
                    <asp:BoundField DataField="Title" HeaderText="Titel" />
                    <asp:BoundField DataField="Description" HeaderText="Beschreibung" />
                    <asp:BoundField DataField="Language" HeaderText="Programmiersprache" SortExpression="Language" />
                    <asp:CommandField ShowSelectButton="True" SelectText="Mehr" />
                </Columns>
                <PagerSettings Mode="NextPreviousFirstLast" />
                <PagerStyle HorizontalAlign="Center" />
            </asp:GridView>
        </div>
        <asp:Label ID="lblCommentWarning" runat="server" Text="" CssClass="text-danger"></asp:Label>
        <div>
            <asp:DetailsView ID="dvTricks" AutoGenerateRows="false" runat="server"
                BorderStyle="Solid" Width="100%" BorderColor="#dee2e6" SelectMethod="dvTricks_GetItem">
                <Fields>
                    <asp:TemplateField ShowHeader="false">
                        <ItemTemplate>
                            <div class="content-container p-3">
                                <div class="d-flex justify-content-between align-items-start">
                                    <h2><%# Eval("Title") %></h2>
                                    <div class="badge rounded-pill bg-warning text-dark font-weight-bold"><%# Eval("Language") %></div>
                                </div>
                                <p>
                                    Von <span class="text-primary font-weight-bold"><%# Eval("UserName") %></span> am
                                    <asp:Label ID="lblUploadDate" runat="server" Text='<%# Eval("UploadDate", "{0:d}") %>'></asp:Label>
                                </p>
                                <div>
                                    <p><%# Eval("Description") %></p>
                                </div>
                                <div>
                                    <code><%# Eval("TrickContent") %></code>
                                </div>
                                <div class="mt-3">
                                    <asp:ListView ID="lvComments" runat="server"
                                        DataKeyNames="CommentId" ItemType="ProgrammingTricks.Models.DetailsViewCommentModel"
                                        SelectMethod="lvComments_GetData" InsertMethod="lvComments_InsertItem"
                                        OnItemInserting="lvComments_ItemInserting" OnDataBound="lvComments_DataBound" OnItemDataBound="lvComments_ItemDataBound">
                                        <LayoutTemplate>
                                            <div class="row justify-content-between m-0 mb-2">
                                                <p>
                                                    <asp:Label ID="lblNumComments" runat="server" Text=""></asp:Label>
                                                    Kommentare</p>
                                                <asp:Button ID="btnAddComment" CssClass="btn btn-primary" runat="server" Text="Kommentieren" CausesValidation="false" OnClick="btnAddComment_Click" />
                                            </div>
                                            <div runat="server" id="itemPlaceholderContainer" class="mb-2">
                                                <span runat="server" id="itemPlaceholder" />
                                            </div>
                                            <div id="pager" class="text-center">
                                                <asp:DataPager ID="DataPager1" runat="server" PageSize="4">
                                                    <Fields>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="btn btn-secondary"
                                                            ShowFirstPageButton="true" ShowLastPageButton="true" FirstPageText="&lt;&lt;"
                                                            PreviousPageText="&lt;" NextPageText="&gt;" LastPageText="&gt;&gt;" />
                                                    </Fields>
                                                </asp:DataPager>
                                            </div>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <div class="p-3 border-grey-solid">
                                                <div class="d-flex justify-content-between">
                                                    <span class="text-secondary font-weight-bold font-size-lg">
                                                        <%# Eval("UserName") %><span id="hyphen" visible="false" runat="server"> - </span><asp:Label ID="lblIsAuthor" CssClass="text-primary" runat="server" Text=""></asp:Label></span>
                                                    <span class="font-italic text-grey font-size-sm"><%# Eval("CommentDate") %></span>
                                                </div>
                                                <div>
                                                    <%# Eval("CommentContent") %>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                        <InsertItemTemplate>
                                            <p>Bitte geben Sie einen Kommentar ein</p>
                                            <div class="row justify-content-between m-0 mb-4">
                                                <asp:TextBox ID="txtComment" CssClass="col-md-9 form-control" runat="server"></asp:TextBox>
                                                <asp:Button ID="btnSendComment" CssClass="btn btn-primary col-md-2" runat="server" Text="Senden" CommandName="insert" />
                                            </div>
                                            <asp:RequiredFieldValidator ID="rfvComment" runat="server" ErrorMessage="Das Kommentarfeld darf nicht leer sein!" ControlToValidate="txtComment" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                                        </InsertItemTemplate>
                                        <EmptyDataTemplate>
                                            <div class="row justify-content-between m-0 mb-2">
                                                <p>0 Kommentare</p>
                                                <asp:Button ID="btnAddComment" CssClass="btn btn-primary" runat="server" Text="Kommentieren" CausesValidation="false" OnClick="btnAddComment_Click" />
                                            </div>
                                        </EmptyDataTemplate>
                                    </asp:ListView>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
            </asp:DetailsView>
        </div>
    </div>
</asp:Content>
