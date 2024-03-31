<%@ Page Title="Payment" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="OutModern.src.Client.Payment.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="mx-56 mt-10">
        <h2 class="text-3xl font-bold flex">Shipping Address</h2>
    </div>

    <div class="rounded-md flex justify-between mx-52 mb-10">

        <!--Left Container-->
        <div class="w-[65%] p-4 min-h-[60vh]">
            <div id="paymentMethod" runat="server" class="p-4 bg-white drop-shadow-lg rounded-xl mb-12">

                <h3 class="mx-4 my-4 font-bold text-xl text-black">Select a payment method</h3>


                <!--Selection-->
                <div class="flex items-center space-x-8 mx-4">
                    <asp:Label ID="lblCreditCardContainer" runat="server" CssClass="address-item selected flex items-center border border-gray-300 rounded-md p-4 bg-white shadow-md mb-4 w-56 h-14 cursor-pointer" AssociatedControlID="creditCard">
                        <asp:Image ID="imgCreditCard" ImageUrl="~/images/mastercard_logo.png" CssClass="ml-4 h-8 w-10" runat="server" />
                        <span class="ml-2 mr-2 text-gray-700">Credit Card</span>
                        <asp:RadioButton ID="creditCard" GroupName="paymentMethod" runat="server" Checked="true" CssClass="h-5 w-5 ml-auto" />
                    </asp:Label>

                    <asp:Label ID="lblPaypalContainer" runat="server" CssClass="address-item flex items-center border border-gray-300 rounded-md p-4 bg-white shadow-md mb-4 w-56 h-14 cursor-pointer" AssociatedControlID="paypal">
                        <asp:Image ID="imgPaypal" ImageUrl="~/images/paypal.png" CssClass="ml-6 h-8 w-8" runat="server" />
                        <span class="ml-2 mr-2 text-gray-700">Paypal</span>
                        <asp:RadioButton ID="paypal" GroupName="paymentMethod" CssClass="h-5 w-5 ml-auto" runat="server" />
                    </asp:Label>
                </div>

                <!--show payment-->
                <div id="paymentDetails" class="mx-4">

                    <div class="mb-4">
                        <asp:Label ID="lblCcInfo" runat="server" class="text-gray-700 font-semibold ">Credit card Information</asp:Label>
                    </div>
                    <div class="mb-4">
                        <asp:Label for="txtCardNumber" runat="server" class="text-gray-700">Card Number</asp:Label>
                        <asp:TextBox ID="txtCardNumber" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" placeholder="1234 1234 1234 2343"></asp:TextBox>
                    </div>
                    <div class="flex space-x-4">
                        <div class="mb-4 flex-1">
                            <asp:Label for="txtExpirationDate" runat="server" class="text-gray-700">Expiration Date</asp:Label>
                            <asp:TextBox ID="txtExpirationDate" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" placeholder="MM/YY"></asp:TextBox>
                        </div>
                        <div class="mb-4 flex-1">
                            <asp:Label for="txtCvv" runat="server" class="text-gray-700">CVV</asp:Label>
                            <asp:TextBox ID="txtCvv" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" placeholder="123"></asp:TextBox>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!--Right Container-->
        <div class="w-[30%] p-4 mr-12">

            <!-- Order Summary -->
            <div id="orderSummary" runat="server" class="p-4 bg-white drop-shadow-lg rounded-xl">
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

            var creditCardRadio = document.getElementById('<%= creditCard.ClientID %>');
            var paypalRadio = document.getElementById('<%= paypal.ClientID %>');
            var paymentDetails = document.getElementById('paymentDetails');

            creditCardRadio.addEventListener('change', function () {
                if (creditCardRadio.checked) {
                    paymentDetails.style.display = 'block';
                } else {
                    paymentDetails.style.display = 'none';
                }
            });

            paypalRadio.addEventListener('change', function () {
                if (paypalRadio.checked) {
                    paymentDetails.style.display = 'none';
                }
            });
        });

    </script>


    <style>
        .selected {
            box-shadow: 0 0 5px #000000; /* Replace with your desired glow color */
        }
    </style>
</asp:Content>

