<%@ Page Title="Payment" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="OutModern.src.Client.Payment.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="mx-[264px] mt-10">
        <asp:SiteMapPath ID="SiteMapPath1" runat="server" CssClass="text-3xl font-bold"></asp:SiteMapPath>
        <h2 class="flex text-3xl font-bold">Payment Method</h2>
    </div>

    <div class="mx-[248px] mb-10 flex justify-between rounded-md">
        <!--Left Container-->
        <div class="w-[66%] min-h-[60vh] p-4">
            <div id="paymentMethod" runat="server" class="mb-12 rounded-xl bg-white p-4 drop-shadow-lg">

                <h3 class="mx-4 my-4 text-xl font-bold text-black">Select a payment method</h3>


                <!--Selection-->
                <div class="mx-4 flex items-center space-x-8">
                    <asp:Label ID="lblCreditCardContainer" runat="server" CssClass="address-item selected mb-4 flex h-14 w-56 cursor-pointer items-center rounded-md border border-gray-300 bg-white p-4 shadow-md" AssociatedControlID="creditCard" OnClick="LabelContainer_Click">
                        <asp:Image ID="imgCreditCard" ImageUrl="~/images/mastercard_logo.png" CssClass="ml-4 h-8 w-10" runat="server" />
                        <span class="ml-2 mr-2 text-gray-700">Credit Card</span>
                        <asp:RadioButton ID="creditCard" GroupName="paymentMethod" runat="server" Checked="true" CssClass="ml-auto h-5 w-5" OnCheckedChanged="PaymentMethod_CheckedChanged" />
                    </asp:Label>

                    <asp:Label ID="lblPaypalContainer" runat="server" CssClass="address-item mb-4 flex h-14 w-56 cursor-pointer items-center rounded-md border border-gray-300 bg-white p-4 shadow-md" AssociatedControlID="paypal" OnClick="LabelContainer_Click">
                        <asp:Image ID="imgPaypal" ImageUrl="~/images/paypal.png" CssClass="ml-6 h-8 w-8" runat="server" />
                        <span class="ml-2 mr-2 text-gray-700">Paypal</span>
                        <asp:RadioButton ID="paypal" GroupName="paymentMethod" CssClass="ml-auto h-5 w-5" runat="server" OnCheckedChanged="PaymentMethod_CheckedChanged" />
                    </asp:Label>
                </div>

                <!--show payment-->
                <div id="paymentDetails" class="mx-4" runat="server">

                    <div class="mb-4">
                        <asp:Label ID="lblCcInfo" runat="server" class="font-semibold text-gray-700">Credit card Information</asp:Label>
                    </div>
                    <div class="mb-4">
                        <asp:Label for="txtCardNumber" runat="server" class="text-gray-700">Card Number</asp:Label>
                        <asp:TextBox ID="txtCardNumber" runat="server" CssClass="mt-1 w-full rounded-md border border-gray-300 px-3 py-2" placeholder="1234 1234 1234 2343"></asp:TextBox>
                    </div>
                    <div class="flex space-x-4">
                        <div class="flex-1 mb-4">
                            <asp:Label for="txtExpirationDate" runat="server" class="text-gray-700">Expiration Date</asp:Label>
                            <asp:TextBox ID="txtExpirationDate" runat="server" CssClass="mt-1 w-full rounded-md border border-gray-300 px-3 py-2" placeholder="MM/YY"></asp:TextBox>
                        </div>
                        <div class="flex-1 mb-4">
                            <asp:Label for="txtCvv" runat="server" class="text-gray-700">CVV</asp:Label>
                            <asp:TextBox ID="txtCvv" runat="server" CssClass="mt-1 w-full rounded-md border border-gray-300 px-3 py-2" placeholder="123"></asp:TextBox>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!--Right Container-->
        <div class="w-[32%] p-4">

            <!-- Order Summary -->
            <div id="orderSummary" runat="server" class="rounded-xl bg-white p-4 drop-shadow-lg">
                <h2 class="mb-2 ml-6 mr-6 mt-2 text-2xl font-bold">Order Summary</h2>

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
                                <div class="px-4 py-6">
                                    <div class="flex flex-wrap items-center">
                                        <asp:Image ID="imgProduct" runat="server" AlternateText="Image" ImageUrl='<%# Eval("ProductImageUrl") %>' CssClass="w-16 h-16 mr-4" />
                                        <div>
                                            <div class="text-lg font-semibold capitalize text-black"><%# Eval("ProductName") %></div>
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

                <div class="mb-2 ml-6 mr-6 flex flex-wrap justify-between pt-4">
                    <span class="text-gray-500">Items</span>
                    <asp:Label ID="lblItemPrice" runat="server" CssClass="text-gray-500" Text="itemprice"></asp:Label>
                </div>
                <div class="mb-2 ml-6 mr-6 flex flex-wrap justify-between">
                    <span class="text-gray-500">Delivery Cost</span>
                    <asp:Label ID="lblDeliveryCost" runat="server" CssClass="text-gray-500" Text="RM5.00"></asp:Label>
                </div>
                <div class="mb-4 ml-6 mr-6 flex flex-wrap justify-between border-b border-gray-300 pb-4">
                    <span class="text-gray-500">Estimated Tax</span>
                    <asp:Label ID="lblTax" runat="server" CssClass="text-gray-500" Text="tax"></asp:Label>
                </div>
                <div class="ml-6 mr-6 flex flex-wrap justify-between font-semibold">
                    <span class="text-gray-500">Total</span>
                    <asp:Label ID="lblTotal" runat="server" CssClass="text-gray-500" Text="total"></asp:Label>
                </div>
            </div>

            <!--Submit button-->
            <div class="mt-8">
                <asp:Button ID="btnSubmitOrder" runat="server" Text="Submit Order" CssClass="bg-[#131118] w-full cursor-pointer rounded-xl px-4 py-2 font-semibold text-white hover:bg-gray-700" OnClick="btnSubmitOrder_Click" />
            </div>

        </div>
        <!-- Add more input fields as needed -->
    </div>

    <script>

    </script>


    <style>
        .selected {
            box-shadow: 0 0 5px #000000; /* Replace with your desired glow color */
        }

        .modal-overlay {
            background-color: rgba(0, 0, 0, 0.4);
        }
    </style>
</asp:Content>

