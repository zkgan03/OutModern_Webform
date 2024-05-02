<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="UserReivew.aspx.cs" Inherits="OutModern.src.Client.UserProfile.UserReivew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mx-auto py-8">
        <h1 class="mb-6 text-3xl font-bold">User Review History</h1>
        <div class="rounded-lg bg-white p-6 shadow-md">
            <h2 class="mb-4 text-xl font-bold">Recent 5 Reviews</h2>
            <div class="overflow-x-auto">
                <div class="mb-5 flex space-x-4">
                    <asp:Repeater ID="rptReviews" runat="server">
                        <ItemTemplate>
                            <div class="min-w-[420px] flex-shrink-0 mr-4 rounded-lg bg-white p-4 shadow-md">
                                <asp:Image ImageUrl='<%# Eval("ProductImageUrl") %>' alt="Product Image" class="w-full h-52 object-cover cursor-pointer rounded-lg mb-4" ID="Image1" runat="server"  onclick='<%# Eval("productID", "window.location.href = \"/src/Client/ProductDetails/ProductDetails.aspx?ProductId={0}\";") %>' />
                                <h3 class="mb-2 text-lg font-bold hover:underline hover:cursor-pointer" onclick='<%# Eval("productID", "window.location.href = \"/src/Client/ProductDetails/ProductDetails.aspx?ProductId={0}\";") %>'><%# Eval("ProductName") %></h3>
                                <p class="mb-2 text-gray-600">Color: <%# Eval("ColorName") %>
                                    | Size: <%# Eval("SizeName") %>
                                </p>
                                <p class="mb-2 text-gray-600">Your Rating: <%# GenerateStars(Convert.ToDouble(Eval("Rating"))) %></p>
                                <p class="text-gray-700"><%# Eval("ReviewDescription") %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>

        <div class="mt-8 rounded-lg bg-white p-6 shadow-md">
            <h2 class="mb-4 text-xl font-bold">All Reviews</h2>

            <div class="overflow-x-auto">
                <table class="w-full table-auto">
                    <thead>
                        <tr class="bg-gray-200">
                            <th class="px-4 py-2">Product</th>
                            <th class="px-4 py-2">Rating</th>
                            <th class="px-4 py-2">Review</th>
                            <th class="px-4 py-2">Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Repeater ID="rptAllReviews" runat="server">
                            <ItemTemplate>
                                <tr>
                                    <td class="border px-4 py-2"><%# Eval("ProductName") %></td>
                                    <td class="border px-4 py-2"><%# GenerateStars(Convert.ToDouble(Eval("Rating"))) %></td>
                                    <td class="border px-4 py-2"><%# Eval("ReviewDescription") %></td>
                                    <td class="border px-4 py-2"><%# Eval("ReviewDateTime") %></td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>

