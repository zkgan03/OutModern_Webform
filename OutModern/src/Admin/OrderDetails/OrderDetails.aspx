<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="OrderDetails.aspx.cs" Inherits="OutModern.src.Admin.OrderDetails.OrderDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {

            #data-table tbody tr {
                @apply cursor-auto;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-2">

        <!-- Order Details-->
        <div class="mt-8">
            <div class="flex gap-10">
                <!-- Display Product Ordered Details-->
                <div class="mt-2 w-full">
                    <!-- title-->
                    <div class="flex items-center mb-5 gap-5 justify-between">
                        <div class="text-2xl font-bold">Order Info</div>
                        <div class="flex gap-2">
                            <asp:Button ID="btnReturnToPlaced" CssClass="button bg-gray-100 text-black" runat="server" Text="Return to Placed" />
                            <asp:Button ID="btnCancelOrder" CssClass="button bg-red-500" runat="server" Text="Cancel Order" />
                        </div>
                        <%--                        <!--Edit Order btn-->
                        <div>
                            <asp:HyperLink CssClass="inline-block text-white px-2 rounded bg-amber-500 hover:opacity-50" ID="hlEditOrder" runat="server"
                                NavigateUrl='<%#urls[OrderEdit] + "?id=" + Request.QueryString["id"]  %>'>
                                <i class="fa-regular fa-pen-to-square"></i>
                            </asp:HyperLink>
                        </div>--%>
                    </div>

                    <div class="mb-2">
                        <div>
                            <span class="font-[600]">Order ID :</span>
                            <asp:Label ID="lblOrderID" runat="server" Text='ORDER123'></asp:Label>
                        </div>
                        <div>
                            <span class="font-[600]">Order Date :</span>
                            <asp:Label ID="lblOrderDate" runat="server" Text='<%# DateTime.Now  %>'></asp:Label>
                        </div>
                        <div>
                            <span class="font-[600]">Order Status :</span>
                            <asp:Label ID="lblOrderStatus" runat="server" Text="Shipped"></asp:Label>
                        </div>
                    </div>

                    <asp:ListView
                        OnItemCommand="lvProductOrder_ItemCommand"
                        OnPagePropertiesChanged="lvProductOrder_PagePropertiesChanged"
                        ID="lvProductOrder" runat="server"
                        DataKeyNames="Id">
                        <LayoutTemplate>
                            <table id="data-table" style="width: 100%; text-align: center;">
                                <thead>
                                    <tr class="data-table-head">
                                        <th>Name
                                        </th>
                                        <th>Size
                                        </th>
                                        <th>Colors
                                        </th>
                                        <th>Price (RM)
                                        </th>
                                        <th>Quantity
                                        </th>
                                        <th>SubTotal (RM)
                                        </th>
                                    </tr>
                                </thead>
                                <tr runat="server" id="itemPlaceholder" class="data-table-item"></tr>
                                <tfoot>
                                    <tr class="border-none text-right">
                                        <td colspan="5" class="font-[600]" style="text-align: right;">Subtotal : </td>
                                        <td class="pr-4">RM
                                            <asp:Label ID="lblSubtotal" runat="server" Text='1000.99'></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="border-none text-right">
                                        <td colspan="3" class="font-[600] text-right">Promo Code Applied : 
                                        </td>
                                        <td class="text-left">
                                            <asp:Label ID="lblPromoCode" runat="server" Text="Promo123"></asp:Label>
                                        </td>
                                        <td class="font-[600]" style="text-align: right;">Discount :
                                        </td>
                                        <td class="pr-4">-<asp:Label ID="lblDiscount" runat="server" Text="12"></asp:Label>%
                                        </td>
                                    </tr>
                                    <tr class="border-none text-right font-bold text-xl">
                                        <td colspan="5" class=" pt-4 font-bold text-xl" style="text-align: right;">Total : </td>
                                        <td class="pr-4 pt-4 font-bold text-xl">RM
                                            <asp:Label ID="lblTotal" CssClass="font-bold text-xl" runat="server" Text="880"></asp:Label>
                                        </td>
                                    </tr>
                                </tfoot>
                            </table>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <asp:Image ID="imgPath" CssClass="mx-auto" runat="server" Width="4em" ImageUrl='<%# Eval("Path") %>' />
                                    <%# Eval("Name") %>
                                </td>
                                <td><%# Eval("Size") %></td>
                                <td>...</td>
                                <td><%# Eval("Price", "{0:0.00}") %></td>
                                <td><%# Eval("Quantity") %></td>
                                <td class="text-right" style="padding-right: 1rem;"><%# Eval("Subtotal", "{0:0.00}") %></td>
                            </tr>
                        </ItemTemplate>

                    </asp:ListView>

                </div>

                <div class="flex-shrink-0 sticky top-16 self-start">
                    <!--Customer Detail-->
                    <div class="border border-gray-500 drop-shadow rounded bg-white p-2">
                        <div class="text-xl font-bold mb-3">Customer Info</div>
                        <div>
                            <i class="fa-regular fa-user"></i>
                            <asp:HyperLink ID="hlCustomerDetail"
                                CssClass="hover:underline"
                                runat="server"
                                NavigateUrl='<%#urls[CustomerDetails] + "?id=" + "123" %>'>
                                <asp:Label ID="lblCusName" runat="server" Text="Customer A"></asp:Label>
                            </asp:HyperLink>
                        </div>
                        <div class="mt-2">
                            <i class="fa-regular fa-envelope"></i>
                            <asp:Label ID="lblCusEmail" runat="server" Text="ganzk-wm21@studeent.tarc.edu.my"></asp:Label>
                        </div>
                        <div class="mt-2">
                            <i class="fa-regular fa-phone"></i>
                            <asp:Label ID="lblCusPhoneNo" runat="server" Text="101123465"></asp:Label>
                        </div>
                        <div class="mt-2 flex gap-2">
                            <i class="fa-regular fa-location-dot"></i>
                            <div>
                                <div class="opacity-65">
                                    Shipping Address
                                </div>
                                <div>
                                    <asp:Label ID="lblAddressLine" runat="server" Text="Jaln Mewah Mewah"></asp:Label>
                                </div>
                                <div>
                                    <asp:Label ID="lblPostalCode" runat="server" Text="56600"></asp:Label>, 
                                        <asp:Label ID="lblCity" runat="server" Text="Kuala Lumpur"></asp:Label>
                                </div>
                                <div>
                                    <asp:Label ID="lblState" runat="server" Text="Kuala Lumpur"></asp:Label>, 
                                        <asp:Label ID="lblCountry" runat="server" Text="Malaysia"></asp:Label>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!--Payment Info-->
                    <div class="border border-gray-500 drop-shadow rounded bg-white p-2 mt-5">
                        <div class="text-xl font-bold mb-3">Payment Info</div>
                        <div>
                            <div class="opacity-65">Payment Date</div>
                            <div class="ml-4">
                                <asp:Label ID="lblPaymentDate" runat="server" Text='<%# DateTime.Now %>'></asp:Label>
                            </div>
                        </div>
                        <div class="mt-2">
                            <div class="opacity-65">Payment Method</div>
                            <div class="ml-4">
                                <asp:Label ID="lblPaymentMethod" runat="server" Text="Visa"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
