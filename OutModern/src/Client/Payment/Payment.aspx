<%@ Page Title="Payment" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="OutModern.src.Client.Payment.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="mx-56 mt-10">
        <h2 class="text-3xl font-bold flex">Shipping Address</h2>
    </div>

    <div class="rounded-md flex justify-between mx-52">

        <!--Left Container-->
        <div class="w-[65%] p-4 min-h-[60vh]">
            <div id="paymentMethod" runat="server" class="p-4 bg-white shadow-md rounded-md mb-12">
                <!-- Upper Panel Accordion -->

                <h3 class="mx-4 my-4 font-bold text-xl text-black">Select a payment method</h3>


                
            </div>
        </div>

        <!--Right Container-->
        <div class="w-[30%] p-4 mr-12">

            <!-- Order Summary -->
            <div id="orderSummary" runat="server" class="p-4 bg-white shadow-md rounded-md">
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

                <div class="flex justify-between pt-4 mb-2 ml-6 mr-6">
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
                <asp:Button ID="btnSubmitOrder" runat="server" Text="Submit Order" CssClass="bg-black hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded w-full h-12" />
            </div>

        </div>
        <!-- Add more input fields as needed -->
    </div>

    <style>
        .accordion {
            border: 1px solid #ccc;
            margin-bottom: 10px;
        }

        .accordion-header {
            background-color: #f1f1f1;
            padding: 10px;
            cursor: pointer;
        }

        .accordion-content {
            display: none;
            padding: 10px;
        }
    </style>
</asp:Content>

