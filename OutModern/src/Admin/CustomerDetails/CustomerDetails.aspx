﻿<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="CustomerDetails.aspx.cs" Inherits="OutModern.src.Admin.CustomerDetails.CustomerDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {
            .desc-grp {
                @apply mb-2 leading-5;
            }

                .desc-grp .desc-title {
                    @apply text-black text-opacity-65;
                }

                .desc-grp .desc-desc {
                    @apply p-2 border border-gray-300 rounded;
                }

            /*Order status*/
            .status-list a {
                @apply p-2 border;
            }

            .order-status {
                @apply rounded p-1;
            }

                .order-status.order-placed {
                    @apply bg-amber-300;
                }

                .order-status.shipped {
                    @apply bg-green-100;
                }

                .order-status.cancelled {
                    @apply bg-red-300;
                }

                .order-status.received {
                    @apply bg-green-300;
                }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-2">

        <div class="mt-8">
            <!-- Customer Info-->
            <div class="">

                <!--title and edit button-->
                <div class="text-xl font-[600] flex items-center gap-2">
                    Customer Info            
                    <asp:HyperLink CssClass="inline-block text-white px-2 rounded bg-amber-500 hover:opacity-50" ID="hlEditOrder" runat="server"
                        NavigateUrl='<%#urls[CustomerEdit] + "?id=" + "123" %>'>
                    <i class="fa-regular fa-pen-to-square"></i>
                    </asp:HyperLink>
                </div>

                <!--Infomation-->
                <div class="mt-5 w-fit border border-black rounded p-2">
                    <!--Status-->
                    <div class="float-right ">
                        <asp:Label ID="lblStatus" runat="server" CssClass="bg-green-300 p-1 rounded" Text="Activated"></asp:Label>
                    </div>
                    <!--Profile pic and name-->
                    <div class="flex gap-5 items-center">
                        <div>
                            <asp:Image ID="imgProfile" runat="server"
                                CssClass="rounded-full size-20 object-cover border"
                                ImageUrl="~/images/about_us_img/img(a).jpg" />
                        </div>
                        <div>

                            <div>
                                <asp:Label CssClass="font-[600] text-xl" ID="lblFullName" runat="server" Text="Ali Ali"></asp:Label>
                            </div>
                            <div>
                                <asp:Label ID="lblUsername" CssClass="text-gray-700" runat="server" Text="ali123"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <!--Info-->
                    <div class="mt-3 flex gap-10">
                        <!--Left-->
                        <div>
                            <!--Id-->
                            <div>
                                <i class="fa-regular fa-id-badge fa-lg mr-2"></i>
                                <asp:Label ID="lblId" runat="server" Text="C123"></asp:Label>
                            </div>

                            <!--Email-->
                            <div class="mt-2">
                                <i class="fa-regular fa-envelope mr-2"></i>
                                <asp:Label ID="lblEmail" runat="server" Text="Ali@mail.com"></asp:Label>
                            </div>

                            <!--phone-->
                            <div class="mt-2">
                                <i class="fa-regular fa-phone mr-2"></i>
                                <asp:Label ID="Label2" runat="server" Text="0121234567"></asp:Label>
                            </div>
                        </div>

                        <!--Right-->
                        <div class="flex gap-2">
                            <asp:Repeater ID="rptAddress" runat="server">
                                <ItemTemplate>
                                    <div class="flex">
                                        <div>
                                            <i class="fa-regular fa-location-dot mr-2"></i>
                                        </div>
                                        <div>
                                            <div class="text-gray-500"><%#Eval("AddressName") %></div>
                                            <div><%# Eval("AddressLine") %></div>
                                            <div><%# Eval("PostalCode") %>, <%# Eval("City") %></div>
                                            <div><%# Eval("State") %>, <%# Eval("Country") %></div>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>
                </div>
            </div>


            <!--Customer's Order details-->
            <div class="mt-10">
                <div class="flex items-center justify-between ">
                    <div class="text-xl font-[600]">Orders Made (123)</div>
                    <div class="mt-2 status-list flex gap-5 mr-10">
                        <asp:LinkButton ID="LinkButton1" runat="server">
                        All
                        </asp:LinkButton>
                        <asp:LinkButton ID="lbOrderPlacedTotal" runat="server">
                            Order Placed :
                        <asp:Label ID="lblOrderPlacedTotal" runat="server" Text="2"></asp:Label>
                        </asp:LinkButton>
                        <asp:LinkButton ID="lbShippedTotal" runat="server">
                            Shipped :
                            <asp:Label ID="lblShippedTotal" runat="server" Text="2"></asp:Label>
                        </asp:LinkButton>
                        <asp:LinkButton ID="lbReceivedTotal" runat="server">
                            Received :
                            <asp:Label ID="lblReceivedTotal" runat="server" Text="110"></asp:Label>
                        </asp:LinkButton>
                        <asp:LinkButton ID="lbCancelledTotal" runat="server">
                            Cancelled :
                            <asp:Label ID="lblCancelledTotal" runat="server" Text="10"></asp:Label>
                        </asp:LinkButton>
                    </div>
                </div>

                <!-- Display Orders -->
                <div class="mt-2 px-10">
                    <!--Pagination-->
                    <asp:DataPager ID="dpTopOrders" class="pagination" runat="server" PagedControlID="lvOrders">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                            <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                        </Fields>
                    </asp:DataPager>

                       <asp:ListView
                            OnItemDataBound="lvOrders_ItemDataBound"
                            OnPagePropertiesChanged="lvOrders_PagePropertiesChanged"
                            ID="lvOrders" runat="server">
                            <LayoutTemplate>
                                <table id="data-table" style="width: 100%; text-align: center;">
                                    <thead>
                                        <tr class="data-table-head">
                                            <th class="active">
                                                <asp:LinkButton ID="lbId" runat="server">
                                             ID
                                             <i class="fa-solid fa-arrow-up"></i>
                                                </asp:LinkButton>
                                            </th>
                                            <th>
                                                <asp:LinkButton ID="lbOrderDateTime" runat="server">
                                                  Order Date
                                                  <i class="fa-solid fa-arrow-up"></i>
                                                </asp:LinkButton>
                                            </th>
                                            <th>
                                                <asp:LinkButton ID="lbProductOrdered" runat="server">
                                              Product Ordered
                                              <i class="fa-solid fa-arrow-up"></i>
                                                </asp:LinkButton>
                                            </th>

                                            <th>
                                                <asp:LinkButton ID="lbSubtotal" runat="server">
                                             Subtotal
                                             <i class="fa-solid fa-arrow-up"></i>
                                                </asp:LinkButton>
                                            </th>
                                            <th>
                                                <asp:LinkButton ID="lbOrderStatus" runat="server">
                                             Order Status
                                             <i class="fa-solid fa-arrow-up"></i>
                                                </asp:LinkButton>
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr runat="server" id="itemPlaceholder" class="data-table-item"></tr>
                                    </tbody>
                                </table>

                            </LayoutTemplate>
                            <ItemTemplate>
                                <tr onclick="window.location='<%# Page.ResolveClientUrl(urls[OrderDetails] + "?id=" +  Eval("OrderId") )%>'">
                                    <td><%# Eval("OrderId") %></td>
                                    <td><%# Eval("OrderDateTime", "{0:dd/MM/yyyy </br> h:mm tt}") %></td>
                                    <td>
                                        <asp:Repeater ID="rptProducts" DataSource='<%# Eval("ProductDetails") %>' runat="server">
                                            <ItemTemplate>
                                                <div><%# Eval("ProductName")  %> -> <%# Eval("Quantity")  %></div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </td>
                                    <td><%# Eval("SubTotal") %></td>
                                    <td><span runat="server" id="orderStatus" class="order-status"><%# Eval("OrderStatus") %></span></td>
                                </tr>
                            </ItemTemplate>
                        </asp:ListView>
            
                    <!--Pagination-->
                    <asp:DataPager ID="dpBottomOrders" class="pagination" runat="server" PageSize="10" PagedControlID="lvOrders">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                            <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>
        </div>
    </div>
</asp:Content>