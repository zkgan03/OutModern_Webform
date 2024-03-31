<%@ Page Title="Shipping" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Shipping.aspx.cs" Inherits="OutModern.src.Client.Shipping.Shipping" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="mx-10">

        <div class="mx-56 mt-10">
            <asp:SiteMapPath ID="SiteMapPath1" runat="server" CssClass="text-3xl font-bold flex"></asp:SiteMapPath>
            <h2 class="text-3xl font-bold flex">Shipping Address</h2>
        </div>

        <div class="rounded-md mt-4 mb-10 flex justify-between mx-56">
            <!--Left Container-->
            <div class="w-[65%] min-h-[60vh] flex-col bg-white drop-shadow-lg p-8 rounded-xl">
                <div class="flex flex-col">
                    <h3 class="mb-2 font-bold">Select a delivery address</h3>
                    <p class="mb-4">Is the address you'd like to use displayed below? If so, click the corresponding address. Or you can enter a new delivery address.</p>
                </div>

                <div class="border-b">
                    <asp:ListView ID="AddressListView" runat="server" OnItemDataBound="AddressListView_ItemDataBound">
                        <LayoutTemplate>
                            <div class="grid grid-cols-2 gap-x-28">
                                <div runat="server" id="itemPlaceholder"></div>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <!-- Address Existing -->
                            <div class="border flex mb-6 max-w-sm bg-white shadow rounded-2xl w-80 address-item">
                                <div class="p-4 w-full">
                                    <div class="flex justify-between">
                                        <div class="capitalize text-black text-xl font-bold"><%# Eval("AddressName") %></div>
                                    </div>
                                    <div class="flex flex-col">
                                        <div class="text-sm"><%# Eval("AddressLine") %></div>
                                        <div class="text-sm"><%# Eval("PostalCode") %> <%# Eval("State") %></div>
                                        <div class="text-sm"><%# Eval("Country") %></div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>

                </div>

                <!--Add address-->
                <div class="flex flex-col">
                    <h3 class="my-6 font-bold">Add a new address</h3>

                    <div class="mb-2">
                        <p class="text-black text-sm">Nickname</p>
                        <asp:TextBox ID="TextBox1" runat="server" CssClass="w-full border border-black rounded-lg h-12 p-6" placeholder="Enter NickName"></asp:TextBox>
                    </div>
                    <div class="my-2">
                        <p class="text-black text-sm">Address Line</p>
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="w-full border border-black rounded-lg h-12 p-6" placeholder="Enter Address"></asp:TextBox>
                    </div>
                    <div class="my-2">
                        <p class="text-black text-sm">Postal Code</p>
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="w-full border border-black rounded-lg h-12 p-6" placeholder="Enter Postal Code"></asp:TextBox>
                    </div>
                    <div class="my-2">
                        <p class="text-black text-sm">State</p>
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="w-full border border-black rounded-lg h-12 p-6" placeholder="Enter Name"></asp:TextBox>
                    </div>
                    <div class="my-2">
                        <p class="text-black text-sm">Country</p>
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="w-full border border-black rounded-lg h-12 p-6" placeholder="Enter Name"></asp:TextBox>
                    </div>

                    <!--Add address button-->
                    <div class="mt-8">
                        <asp:Button ID="Button1" runat="server" Text="Add New Address" CssClass="bg-[#131118] hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded-xl w-1/3 h-12" />
                    </div>
                </div>
            </div>

            <!--Right Container-->
            <div class="w-[30%]">

                <!-- Order Summary -->
                <div id="orderSummary" runat="server" class="p-4 bg-white drop-shadow-lg rounded-xl flex-wrap">
                    <h2 class="text-2xl font-bold mt-2 mb-2 ml-6 mr-6">Order Summary</h2>

                    <div>
                        <asp:ListView ID="ProductListView" runat="server">
                            <LayoutTemplate>
                                <div>
                                    <table>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </div>
                            </LayoutTemplate>
                            <ItemTemplate>
                                <!-- Product item template -->
                                <div class="border-b border-gray-200">
                                    <div class="py-6 px-4">
                                        <div class="flex items-center">
                                            <asp:Image ID="imgProduct" runat="server" AlternateText="Image" ImageUrl='<%# Eval("ProductImageUrl") %>' CssClass="w-16 h-16 mr-4" />
                                            <div>
                                                <div class="font-semibold capitalize text-black text-lg"><%# Eval("ProductName") %></div>
                                                <div class="text-sm">Color: <%# Eval("Color") %></div>
                                                <div class="text-sm">Size: <%# Eval("Size") %></div>
                                                <div class="text-sm">Quantity: <%# Eval("Quantity") %></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:ListView>

                    </div>

                    <div class="flex flex-wrap justify-between pt-4 mb-2 ml-6 mr-6">
                        <span class="text-gray-500">Items</span>
                        <asp:Label ID="lblItemPrice" runat="server" CssClass="text-gray-500" Text="itemprice"></asp:Label>
                    </div>
                    <div class="flex justify-between mb-2 ml-6 mr-6">
                        <span class="text-gray-500">Delivery Cost</span>
                        <asp:Label ID="lblDeliveryCost" runat="server" CssClass="text-gray-500" Text="RM5.00"></asp:Label>
                    </div>
                    <div class="flex justify-between border-b border-gray-300 mb-4 ml-6 mr-6  pb-4">
                        <span class="text-gray-500">Estimated Tax</span>
                        <asp:Label ID="lblTax" runat="server" CssClass="text-gray-500" Text="tax"></asp:Label>
                    </div>
                    <div class="flex justify-between font-semibold ml-6 mr-6">
                        <span class="text-gray-500">Total</span>
                        <asp:Label ID="lblTotal" runat="server" CssClass="text-gray-500" Text="total"></asp:Label>
                    </div>
                </div>

                <!--Submit button-->
                <div class="mt-8">
                    <asp:Button ID="btnProceed" runat="server" Text="Proceed to Payment" CssClass="bg-[#131118] hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded-xl w-full h-12" OnClick="btnProceed_Click" />
                </div>

            </div>
            <!-- Add more input fields as needed -->

        </div>

    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var addressItems = document.querySelectorAll('.address-item');
            addressItems.forEach(function (item) {
                item.addEventListener('click', function () {
                    addressItems.forEach(function (el) {
                        el.classList.remove('selected');
                    });
                    this.classList.add('selected');
                });
            });
        });
    </script>

    <style>
        .selected {
            box-shadow: 0 0 10px #000000; /* Replace with your desired glow color */
        }
    </style>


</asp:Content>

