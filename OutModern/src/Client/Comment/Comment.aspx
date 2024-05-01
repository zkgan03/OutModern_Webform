<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master"  AutoEventWireup="true" CodeBehind="Comment.aspx.cs" Inherits="OutModern.src.Client.Comment.Comment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="comment-container mb-10 mt-10 flex items-center justify-center" style="min-height:500px;">
        <div class="flex w-4/5">
            <div class="product-image mr-8">
                <asp:Image ID="imgProduct" runat="server" ImageUrl="~/images/product-img/hoodies/black-Hoodie/unisex-heavy-blend-hoodie-black-front-60e815eedacd3.png" CssClass="h-96 w-96 rounded-md object-cover" />
            </div>
            <div class="product-details flex-1">
                <div class="product-info mb-3">
                    <asp:Label ID="lblProductName" runat="server" Text="Unisex Heavy Hoodie" CssClass="text-3xl font-bold"></asp:Label>
                </div>
                <div class="mb-3">
                    <asp:Label ID="lblProductPrice" runat="server" Text="RM49.99" CssClass="text-2xl font-bold text-gray-600"></asp:Label>
                </div>
                <div class="mb-4">
                    <asp:Label ID="lblProductColour" runat="server" Text="Colour: Black" CssClass="text-gray-600"></asp:Label> |
                    <asp:Label ID="lblProductSize" runat="server" Text="Size: L" CssClass="text-gray-600"></asp:Label>           
                </div>

                 <div class="rating-stars mb-4 flex items-center">
                    <span class="mr-2 text-gray-600">Rating:</span>
                    <asp:DropDownList ID="ddlRating" runat="server" CssClass="rounded-md border-gray-300 p-2 focus:border-indigo-500 focus:ring-indigo-500" style="min-width:100px;">
                        <asp:ListItem Value="1" Text="1 Star"></asp:ListItem>
                        <asp:ListItem Value="2" Text="2 Stars"></asp:ListItem>
                        <asp:ListItem Value="3" Text="3 Stars"></asp:ListItem>
                        <asp:ListItem Value="4" Text="4 Stars"></asp:ListItem>
                        <asp:ListItem Value="5" Text="5 Stars"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="comment-form">
                    <h2 class="mb-2 text-xl font-bold">Add a Comment</h2>
                    <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" Rows="5" Placeholder="Enter your comment here" CssClass="w-full rounded-md border-gray-300 p-2 focus:border-indigo-500 focus:ring-indigo-500" ></asp:TextBox>
                    <asp:Button ID="btnSubmitComment" OnClick="btnSubmitComment_Click" runat="server" Text="Submit Comment" CssClass="mt-2 rounded-md bg-black px-4 py-2 font-bold text-white hover:bg-indigo-600" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
