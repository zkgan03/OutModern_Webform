<%@ Page Title="Cart" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OutModern.src.Client.Cart.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mx-auto pt-10 pb-20 w-[75%] min-h-[60vh]">
        <h1 class="text-3xl font-bold mb-4">Checkout</h1>
        <div class="flex justify-between">

            <!--Cart Item-->
            <div class="bg-white shadow-md rounded-md p-6" style="width: 70%">
                <div class="container mx-auto">
                    <table class="table-auto container">
                        <thead class="border-b">
                            <tr>
                                <th class="w-3/6 text-left py-4 px-4 font-semibold capitalize text-gray-800 text-base">Products</th>
                                <th class="w-1/6 px-4 py-4 font-semibold capitalize text-gray-800 text-base">Price</th>
                                <th class="w-1/6 px-4 py-4 font-semibold capitalize text-gray-800 text-base">Quantity</th>
                                <th class="w-1/6 px-4 py-4 font-semibold capitalize text-gray-800 text-base">Subtotal</th>
                                <th class="w-1/6 px-4 py-4 font-semibold capitalize text-gray-800 text-base">empty</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Label ID="lblEmptyCart" runat="server" CssClass="text-red-500 font-bold justify-items-center" Visible="false">Cart is empty</asp:Label>

                            <asp:ListView ID="ProductListView" runat="server">
                                <LayoutTemplate>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </LayoutTemplate>
                                <ItemTemplate>

                                    <!--Product-->



                                    <tr class="border-b border-gray-200">
                                        <td class="py-6 px-4">
                                            <div class="flex items-center">
                                                <asp:Image ID="imgProduct" runat="server" AlternateText="Image" ImageUrl='<%# Eval("ProductImageUrl") %>' CssClass="w-12 h-10 mr-4" />
                                                <div>
                                                    <div class="font-bold capitalize text-black text-lg"><%# Eval("ProductName") %></div>
                                                    <div class="text-sm text-gray-500">Color: <%# Eval("Color") %></div>
                                                    <div class="text-sm text-gray-500">Size: <%# Eval("Size") %></div>
                                                </div>
                                            </div>
                                        </td>

                                        <!--Price-->
                                        <td class="py-2 px-4 font-bold text-center">RM<%# Eval("Price", "{0:N2}") %></td>

                                        <!--Quantity Button-->
                                        <td class="py-2 px-6">
                                            <div class="flex items-center justify-center border border-gray-300 rounded-md">
                                                <asp:Button runat="server" ID="btnDecrement" CssClass="px-2 py-1 text-gray-600 hover:text-gray-800 text-2xl" Text="-" OnClick="btnDecrement_Click" />
                                                <asp:TextBox runat="server" ID="txtQuantity" CssClass="w-12 text-center border-none focus:outline-none" Text='<%# Eval("Quantity") %>' ReadOnly="true" />
                                                <asp:Button runat="server" ID="btnIncrement" CssClass="px-2 py-1 text-gray-600 hover:text-gray-800 text-2xl" Text="+" OnClick="btnIncrement_Click" />
                                            </div>

                                        </td>
                                        <td class="py-2 px-4 font-bold text-center">RM<%# Eval("Subtotal", "{0:N2}") %></td>
                                        <td class="py-2 px-4">
                                            <asp:Button runat="server" ID="btnDelete" CssClass="text-red-600 hover:text-red-800" Text="Delete" OnClick="btnDelete_Click" aria-label="Delete" />
                                        </td>

                                    </tr>
                                </ItemTemplate>
                            </asp:ListView>
                        </tbody>
                    </table>
                </div>
            </div>

            <!--OrderSummary-->
            <div class="bg-white shadow-md rounded-md p-6 w-1/4 h-96 overflow-y-auto">
                <div class="mb-4">
                    <div class="flex justify-between border-b border-gray-300 pb-4">
                        <h2 class="text-xl font-bold">Subtotal</h2>
                        <asp:Label ID="lblSubtotal" runat="server" CssClass="font-bold" Text="RM200.00"></asp:Label>
                    </div>

                    <div class="mt-4">
                        <span class="text-sm">Enter Discount Code</span>
                    </div>

                    <div class="flex relative items-center mb-2 rounded-lg border border-black">
                        <asp:TextBox runat="server" ID="txtDiscountCode" CssClass="w-full px-4 py-4 flex-grow text-sm rounded-lg" />
                        <asp:Button runat="server" ID="btnApply" CssClass="absolute right-0 bg-black text-white px-6 py-4 hover:bg-gray-800 text-sm rounded-md" Text="Apply" />
                    </div>

                    <div class="flex justify-between border-b border-gray-300 pb-4">
                        <span>Delivery Charge</span>
                        <span class="font-bold">RM5.00</span>
                    </div>
                    <div class="flex justify-between font-bold text-lg mt-4">
                        <h2 class="text-xl font-bold mb-4">Grand Total</h2>
                        <asp:Label ID="lblGrandTotal" runat="server" CssClass="font-bold" Text="RM200.00"></asp:Label>
                    </div>
                </div>

                <asp:Button runat="server" ID="btnCheckout" CssClass="w-full bg-black text-white py-3 rounded-md hover:bg-gray-800" Text="Proceed to Checkout" OnClick="btnCheckout_Click" />

            </div>
        </div>
    </div>
</asp:Content>
