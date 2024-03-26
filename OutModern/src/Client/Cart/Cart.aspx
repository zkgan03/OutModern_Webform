<%@ Page Title="Cart" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OutModern.Client.Cart.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mx-auto py-10 w-11/12" style="min-height: 100vh">
        <h1 class="text-3xl font-bold mb-6">Checkout</h1>
        <div class="bg-white shadow-md rounded-md p-6">
            <div class="grid grid-cols-3 gap-12">
                <div class="col-span-2">
                    <div class="container mx-auto mb-4">
                        <table class="table-auto container">
                            <thead>
                                <tr>
                                    <th class="w-3/6 text-left py-2 px-4 font-semibold uppercase text-gray-800">Products</th>
                                    <th class="w-1/6 px-4 py-2 font-semibold uppercase text-gray-800">Price</th>
                                    <th class="w-1/6 px-4 py-2 font-semibold uppercase text-gray-800">Quantity</th>
                                    <th class="w-1/6 px-4 py-2 font-semibold uppercase text-gray-800">Subtotal</th>
                                    <th class="w-1/6 px-4 py-2 font-semibold uppercase text-gray-800">empty</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:ListView ID="ProductListView" runat="server">
                                    <LayoutTemplate>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </LayoutTemplate>
                                    <ItemTemplate>

                                        <!--Product-->
                                        <tr class="border-b border-gray-200">
                                            <td class="py-2 px-4">
                                                <div class="flex items-center">
                                                    <asp:Image ID="imgProduct" runat="server" AlternateText="Image" ImageUrl='<%# Eval("ProductImageUrl") %>' CssClass="w-16 h-16 mr-4" />
                                                    <div>
                                                        <div class="font-bold"><%# Eval("ProductName") %></div>
                                                        <div class="text-sm text-gray-500">Color: <%# Eval("Color") %></div>
                                                        <div class="text-sm text-gray-500">Size: <%# Eval("Size") %></div>
                                                    </div>
                                                </div>
                                            </td>

                                            <!--Price-->
                                            <td class="py-2 px-4 font-bold text-center">RM<%# Eval("Price", "{0:N2}") %></td>

                                            <!--Quantity Button-->
                                            <td class="py-2 px-4">
                                                <div class="flex items-center justify-center border border-gray-300 rounded-md">
                                                    <asp:Button runat="server" ID="btnDecrement" CssClass="px-2 py-1 text-gray-600 hover:text-gray-800" Text="-" OnClick="btnDecrement_Click" />
                                                    <asp:TextBox runat="server" ID="txtQuantity" CssClass="w-12 text-center border-none focus:outline-none" Text='<%# Eval("Quantity") %>' ReadOnly="true" />
                                                    <asp:Button runat="server" ID="btnIncrement" CssClass="px-2 py-1 text-gray-600 hover:text-gray-800" Text="+" OnClick="btnIncrement_Click" />
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
                <div class="bg-white shadow-md rounded-md p-6">

                    <div class="mb-4">
                        <div class="flex justify-between mb-2">
                            <h2 class="text-xl font-bold mb-4">Subtotal</h2>
                            <asp:Label ID="lblSubtotal" runat="server" CssClass="font-bold" Text="RM200.00"></asp:Label>
                        </div>
                        <div class="flex items-center mb-2">
                            <input type="text" placeholder="Enter Discount Code" class="border border-gray-300 rounded-l-md px-2 py-1 focus:outline-none">
                            <button type="button" class="bg-gray-200 px-2 py-1 rounded-r-md hover:bg-gray-300">Apply</button>
                        </div>
                        <div class="flex justify-between mb-2">
                            <span>Delivery Charge</span>
                            <span class="font-bold">RM5.00</span>
                        </div>
                        <div class="flex justify-between font-bold text-lg">
                            <h2 class="text-xl font-bold mb-4">Grand Total</h2>
                            <asp:Label ID="lblGrandTotal" runat="server" CssClass="font-bold" Text="RM200.00"></asp:Label>
                        </div>
                    </div>
                    <button type="button" class="bg-black text-white px-4 py-2 rounded-md hover:bg-gray-800">Proceed to Checkout</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function decrementQuantity(button) {
            const input = button.nextElementSibling;
            let value = parseInt(input.value);
            if (value > 1) {
                value--;
                input.value = value;
            }
        }

        function incrementQuantity(button) {
            const input = button.previousElementSibling;
            let value = parseInt(input.value);
            value++;
            input.value = value;
        }
    </script>
</asp:Content>
