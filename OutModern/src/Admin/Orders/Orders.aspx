<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="OutModern.src.Admin.Orders.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    Orders
    <asp:Repeater ID="Repeater1" runat="server">
        <HeaderTemplate>
            <div>
                Test
            </div>
            <div>
                Test2
            </div>
        </HeaderTemplate>

        <ItemTemplate>
        </ItemTemplate>

        <FooterTemplate>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
