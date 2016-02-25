<%@ Page Title="MembersOnly" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MembersOnly.aspx.cs" Inherits="Iteration1Working.Members.MembersOnly" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h2><%: Title %>.</h2>
        <h3>Your application description page.</h3>
        <p>Use this area to provide additional information.</p>
        </br>
        <p>Add Expense</p>
        <p>Add Deposit</p>
    </div>
</asp:Content>
