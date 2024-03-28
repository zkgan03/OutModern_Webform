<%@ Page Title="Payment" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="OutModern.src.Client.Payment.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div class="rounded-md p-2 my-10 flex justify-between mx-44">
        <!--Left Container-->
        <div class="w-[65%] p-4 ml-12 min-h-[60vh]">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div id="paymentMethod" runat="server" class="p-4 bg-white shadow-md rounded-md mb-12">
                        <!-- Upper Panel Accordion -->
                        <asp:LinkButton ID="lnkTogglePaymentMethod" runat="server" CssClass="p-0 bg-white mb-8 cursor-pointer" OnClick="TogglePaymentMethod">
    <p class="m-4 font-bold text-xl text-black">Payment Method</p>
                        </asp:LinkButton>

                        <!-- Upper Panel Content -->
                        <asp:Panel ID="pnlPaymentDetails" runat="server" CssClass="accordion-content mx-4 mt-6" Visible="false" ClientIDMode="Static">
                            <!-- Content of Upper Panel -->
                            <div class="flex items-center space-x-8">
                                <asp:Label ID="lblCreditCardContainer" runat="server" CssClass="flex items-center border border-gray-300 rounded-md p-4 bg-white shadow-md mb-4 w-56 h-14 cursor-pointer" AssociatedControlID="creditCard">
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
                        <!-- Lower Panel Accordion -->
                        <asp:LinkButton ID="lnkToggleBillingAddress" runat="server" CssClass="p-0 bg-white mb-12 cursor-pointer" OnClick="ToggleBillingAddress">
    <p class="m-4 font-bold text-xl text-black">Billing Address</p>
                        </asp:LinkButton>


                        <asp:Panel ID="pnlBillingDetails" runat="server" CssClass="accordion-content mx-4" Visible="false" ClientIDMode="Static">
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
                        </asp:Panel>


                    </div>

                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="lnkTogglePaymentMethod" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="lnkToggleBillingAddress" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>

        <!--Right Container-->
        <div class="w-1/4 p-4 mr-12">

            <!-- Order Summary -->
            <div id="orderSummary" runat="server" class="p-4 bg-white shadow-md rounded-md">
                <h2 class="text-lg font-semibold mt-2 mb-2 ml-6 mr-6">Order Summary</h2>

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
                                        <asp:Image ID="imgProduct" runat="server" AlternateText="Image" ImageUrl='<%# Eval("ProductImageUrl") %>' CssClass="w-12 h-10 mr-4" />
                                        <div>
                                            <div class="font-bold capitalize text-black text-lg"><%# Eval("ProductName") %></div>
                                            <div class="text-sm text-gray-500">Color: <%# Eval("Color") %></div>
                                            <div class="text-sm text-gray-500">Size: <%# Eval("Size") %></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:ListView>

                </div>

                <div class="flex justify-between pt-4 mb-2 ml-6 mr-6">
                    <span class="text-gray-700">Items</span>
                    <asp:Label ID="lblItemPrice" runat="server" CssClass="text-gray-700" Text="itemprice"></asp:Label>
                </div>
                <div class="flex justify-between mb-2 ml-6 mr-6">
                    <span class="text-gray-700">Delivery Cost</span>
                    <asp:Label ID="lvlDeliveryCost" runat="server" CssClass="text-gray-700" Text="deliveryvost"></asp:Label>
                </div>
                <div class="flex justify-between border-b border-gray-300 mb-4 ml-6 mr-6  pb-4">
                    <span class="text-gray-700">Estimated Tax</span>
                    <asp:Label ID="lblText" runat="server" CssClass="text-gray-700" Text="tax"></asp:Label>
                </div>
                <div class="flex justify-between font-semibold ml-6 mr-6">
                    <span class="text-gray-700">Total</span>
                    <asp:Label ID="lblTotal" runat="server" CssClass="text-gray-700" Text="total"></asp:Label>
                </div>
            </div>

            <!--Submit button-->
            <div class="mt-8">
                <asp:Button ID="btnSubmitOrder" runat="server" Text="Submit Order" CssClass="bg-black hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded w-full h-12" />
            </div>

        </div>
        <!-- Add more input fields as needed -->
    </div>


</asp:Content>

