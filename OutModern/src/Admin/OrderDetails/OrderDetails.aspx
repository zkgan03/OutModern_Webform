<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="OutModern.src.Admin.OrderDetails.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-2">

        <!--Edit Order btn-->
        <div>
            <asp:HyperLink CssClass="inline-block text-white p-2 rounded bg-amber-500 hover:opacity-50" ID="hlEditOrder" runat="server" NavigateUrl='#'>
                <i class="fa-regular fa-pen-to-square"></i>
                Edit Order
            </asp:HyperLink>
        </div>

        <!-- Order Details-->
        <div class="mt-8">
            <div class="text-[1.5rem] font-bold">Order Details</div>
        </div>

    </div>
</asp:Content>
