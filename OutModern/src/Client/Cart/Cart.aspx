<%@ Page Title="Cart" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OutModern.Client.Cart.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mx-auto py-10 w-5/6" style="min-height:100vh">
        <h1 class="text-3xl font-bold mb-6">Checkout</h1>
        <div class="bg-white shadow-md rounded-md p-6">
            <div class="grid grid-cols-3 gap-4">
                <div class="col-span-2">
                    <div class="flex justify-between mb-4">
                        <!-- Added flex container -->
                        <h2 class="text-xl font-bold mb-0">Products</h2>
                        <div class="flex space-x-5">
                            <div>Price</div>
                            <!-- Text for Price -->
                            <div>Quantity</div>
                            <div>Subtotal</div>
                            <!-- Text for Subtotal -->
                        </div>
                    </div>
                    <asp:ListView ID="ProductListView" runat="server">
                        <LayoutTemplate>
                            <div class="flex flex-col">
                                <div>
                                    <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                                </div>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="flex items-center justify-between mb-2">
                                <div class="flex items-center">
                                    <asp:Image ID="imgProduct" runat="server" AlternateText="Image" ImageUrl='<%# Eval("ProductImageUrl") %>' CssClass="w-16 h-16 mr-4" />
                                    <div>
                                        <div class="font-bold"><%# Eval("ProductName") %></div>
                                        <div class="text-sm text-gray-500">Quantity: <%# Eval("Quantity") %></div>
                                    </div>
                                </div>
                                <div class="flex items-center">
                                    <div class="font-bold mr-2"><%# Eval("Price", "{0:C}") %></div>

                                    <div class="flex items-center border border-gray-300 rounded-md">
                                        <asp:Button runat="server" ID="btnDecrement" CssClass="px-2 py-1 text-gray-600 hover:text-gray-800" Text="-" OnClick="btnDecrement_Click" />
                                        <asp:TextBox runat="server" ID="txtQuantity" CssClass="w-12 text-center border-none focus:outline-none" Text='<%# Eval("Quantity") %>' ReadOnly="true" />
                                        <asp:Button runat="server" ID="btnIncrement" CssClass="px-2 py-1 text-gray-600 hover:text-gray-800" Text="+" OnClick="btnIncrement_Click" />
                                    </div>


                                    <div class="font-bold mr-2"><%# Eval("Subtotal", "{0:C}") %></div>
                                    <!-- Subtotal -->
                                </div>
                            </div>
                        </ItemTemplate>

                    </asp:ListView>
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
