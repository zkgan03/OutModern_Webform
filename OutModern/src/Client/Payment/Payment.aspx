<%@ Page Title="Payment" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="OutModern.src.Client.Payment.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="rounded-md p-2 mb-2 flex">
        <!--Left Container-->
        <div class="w-3/5 p-4 ml-12">
            <div id="paymentMethod" runat="server" class="p-4 bg-white shadow-md rounded-md mb-4">
                <!--UPPER PANEL-->
                <p class="m-6 font-bold text-xl">Payment Method</p>
                <div class="flex items-center space-x-8">
                    <asp:Label ID="lblCreditCardContainer" runat="server" CssClass="flex items-center border border-gray-300 rounded-md p-4 bg-white shadow-md ml-4 mb-4 w-56 h-14 cursor-pointer" AssociatedControlID="creditCard">
                        <asp:Image ID="imgCreditCard" ImageUrl="~/images/mastercard_logo.png" CssClass="ml-6 h-6 w-auto" runat="server" />
                        <span class="ml-2 mr-2 text-gray-700">Credit Card</span>
                        <asp:RadioButton ID="creditCard" GroupName="paymentMethod" runat="server" Checked="true" CssClass="h-5 w-5 ml-auto" />
                    </asp:Label>

                    <asp:Label ID="lblPaypalContainer" runat="server" CssClass="flex items-center border border-gray-300 rounded-md p-4 bg-white shadow-md mb-4 w-56 h-14 cursor-pointer" AssociatedControlID="paypal">
                        <asp:Image ID="imgPaypal" ImageUrl="~/images/paypal.png" CssClass="ml-6 h-6 w-auto" runat="server" />
                        <span class="ml-2 mr-2 text-gray-700">Paypal</span>
                        <asp:RadioButton ID="paypal" GroupName="paymentMethod" CssClass="h-5 w-5 ml-auto" runat="server" />
                    </asp:Label>
                </div>

                <asp:Panel ID="pnlCreditCardDetails" runat="server" CssClass="mt-4 ml-6 mr-6">
                    <div class="mb-4">
                        <asp:Label ID="lblCcInfo" runat="server" class="text-gray-700 font-semibold ">Credit card Information</asp:Label>
                    </div>
                    <div class="mb-4">
                        <asp:Label for="txtCardNumber" runat="server" class="text-gray-700">Card Number</asp:Label>
                        <asp:TextBox ID="txtCardNumber" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" placeholder="**** **** **** 2343" Text="**** **** **** 2343"></asp:TextBox>
                    </div>
                    <div class="flex space-x-4">
                        <div class="mb-4 flex-1">
                            <asp:Label for="txtExpirationDate" runat="server" class="text-gray-700">Expiration Date</asp:Label>
                            <asp:TextBox ID="txtExpirationDate" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" placeholder="MM/YY" Text="12/25"></asp:TextBox>
                        </div>
                        <div class="mb-4 flex-1">
                            <asp:Label for="txtCvv" runat="server" class="text-gray-700">CVV</asp:Label>
                            <asp:TextBox ID="txtCvv" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" placeholder="***" Text="***"></asp:TextBox>
                        </div>
                    </div>
                    <div class="flex items-center mb-4">
                        <asp:CheckBox ID="cbSameAsShipping" runat="server" CssClass="form-checkbox h-5 w-5 text-blue-500" />
                        <asp:Label for="cbSameAsShipping" runat="server" class="ml-2 text-gray-700">Billing address same as shipping</asp:Label>
                    </div>
                </asp:Panel>
            </div>

            <!--LOWER PANEL-->
            <div id="billingAddress" runat="server" class="p-4 bg-white shadow-md rounded-md mt-4">

                <asp:Panel ID="pnlBillingAddress" runat="server" Visible="true" CssClass="mt-8 mr-6 ml-6">
                    <div>
                        <h2 class="text-xl font-bold mb-2">Billing Address</h2>
                        <div class="grid grid-cols-2 gap-4">
                            <div class="mb-4">
                                <asp:Label for="txtFirstName" runat="server" class="text-gray-700 font-semibold">First Name</asp:Label>
                                <asp:TextBox ID="txtFirstName" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" Text="Patricia"></asp:TextBox>
                            </div>
                            <div class="mb-4">
                                <asp:Label for="txtLastName" runat="server" class="text-gray-700 font-semibold">Last Name</asp:Label>
                                <asp:TextBox ID="txtLastName" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" Text="Eyni"></asp:TextBox>
                            </div>
                        </div>
                        <div class="mb-4">
                            <asp:Label for="txtAddress" runat="server" class="text-gray-700 font-semibold">Address</asp:Label>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" Text="Paunte Resort 56 P"></asp:TextBox>
                        </div>
                        <div class="grid grid-cols-3 gap-4">
                            <div class="mb-4">
                                <asp:Label for="txtCity" runat="server" class="text-gray-700 font-semibold">City</asp:Label>
                                <asp:TextBox ID="txtCity" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" Text="Mission District"></asp:TextBox>
                            </div>
                            <div class="mb-4">
                                <asp:Label for="ddlState" runat="server" class="text-gray-700 font-semibold">State</asp:Label>
                                <asp:DropDownList ID="ddlState" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1">
                                    <asp:ListItem Value="CA" Selected="True">California</asp:ListItem>

                                </asp:DropDownList>
                            </div>
                            <div class="mb-4">
                                <asp:Label for="txtPostalCode" runat="server" class="text-gray-700 font-semibold">Postal Code</asp:Label>
                                <asp:TextBox ID="txtPostalCode" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" Text="94102-4331"></asp:TextBox>
                            </div>
                        </div>
                        <div class="grid grid-cols-2 gap-4">
                            <div class="mb-4">
                                <asp:Label for="txtEmail" runat="server" class="text-gray-700 font-semibold">Email</asp:Label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" Text="patricia.eyni@gmail.com"></asp:TextBox>
                            </div>
                            <div class="mb-4">
                                <asp:Label for="txtPhoneNumber" runat="server" class="text-gray-700 font-semibold">Phone Number</asp:Label>
                                <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="w-full border border-gray-300 rounded-md px-3 py-2 mt-1" Text="+1 (415) 123-1234"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </asp:Panel>


            </div>
        </div>

        <!--Right Container-->
        <div class="w-2/5 p-4 mr-12">

            <!-- Order Summary -->
            <div id="orderSummary" runat="server" class="p-4 bg-white shadow-md rounded-md">
                <h2 class="text-lg font-semibold mt-2 mb-2 ml-6 mr-6">Order Summary</h2>
                <div class="flex justify-between  mb-2 ml-6 mr-6">
                    <span class="text-gray-700">Items</span>
                    <asp:Label ID="lblItemPrice" runat="server" CssClass="text-gray-700" Text="itemprice"></asp:Label>
                </div>
                <div class="flex justify-between mb-2 ml-6 mr-6">
                    <span class="text-gray-700">Delivery Cost</span>
                    <asp:Label ID="lvlDeliveryCost" runat="server" CssClass="text-gray-700" Text="deliveryvost"></asp:Label>
                </div>
                <div class="flex justify-between border-b border-gray-300 mb-4 ml-6 mr-6">
                    <span class="text-gray-700">Estimated Tax</span>
                    <asp:Label ID="lblText" runat="server" CssClass="text-gray-700" Text="tax"></asp:Label>
                </div>
                <div class="flex justify-between font-semibold ml-6 mr-6">
                    <span class="text-gray-700">Total</span>
                    <asp:Label ID="lblTotal" runat="server" CssClass="text-gray-700" Text="total"></asp:Label>
                </div>
                <asp:Button ID="btnSubmitOrder" runat="server" Text="Submit Order" CssClass="bg-blue-500 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded mt-4" />

            </div>

        </div>
        <!-- Add more input fields as needed -->
    </div>


</asp:Content>

