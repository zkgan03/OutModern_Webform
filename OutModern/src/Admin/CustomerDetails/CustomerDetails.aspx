<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="CustomerDetails.aspx.cs" Inherits="OutModern.src.Admin.CustomerDetails.CustomerDetails" %>

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

        <!--Customer Name and Edit btn-->
        <div class="">
            <asp:Label ID="lblTitleCustomerName" CssClass="text-2xl font-bold" runat="server" Text="Customer A"></asp:Label>
        </div>

        <div class="mt-8 flex gap-8">
            <!-- Customer Details-->
            <div class="w-72 flex-shrink-0">
                <div class="text-xl font-[600] flex items-center gap-2">
                    Customer Info            
                    <asp:HyperLink CssClass="inline-block text-white px-2 rounded bg-amber-500 hover:opacity-50" ID="hlEditOrder" runat="server" 
                        NavigateUrl='<%#urls[CustomerEdit] + "?id=" + "123" %>'>
                    <i class="fa-regular fa-pen-to-square"></i>
                    </asp:HyperLink>
                </div>
                <div class="mt-2 text-xl border drop-shadow-lg bg-white rounded p-4 border-gray-700">
                    <div class="desc-grp">
                        <div class="desc-title">Customer ID</div>
                        <div class="desc-desc">
                            <asp:Label ID="lblCustomerId" runat="server" Text="123"></asp:Label>
                        </div>
                    </div>
                    <div class="desc-grp">
                        <div class="desc-title">Username</div>
                        <div class="desc-desc">
                            <asp:Label ID="lblUsername" runat="server" Text="username123"></asp:Label>
                        </div>
                    </div>
                    <div class="desc-grp">
                        <div class="desc-title">Email</div>
                        <div class="desc-desc">
                            <asp:Label ID="lblEmail" runat="server" Text="ganzk-wm21@student.tarc.edu.my"></asp:Label>
                        </div>
                    </div>
                    <div class="desc-grp">
                        <div class="desc-title">Phone No</div>
                        <div class="desc-desc">
                            <asp:Label ID="lblPhoneNo" runat="server" Text="012-3456781"></asp:Label>
                        </div>
                    </div>
                    <div class="desc-grp">
                        <div class="desc-title">Address</div>
                        <div class="desc-desc">
                            <asp:Label ID="lblAddress" runat="server" Text="Jalan mewah mewah, <br> dawawd  <br>  awd  <br>  awdawd"></asp:Label>
                        </div>
                    </div>
                    <div class="desc-grp">
                        <div class="desc-title">Status</div>
                        <div class="desc-desc">
                            <asp:Label ID="lblStatus" runat="server" Text="Activated"></asp:Label>
                        </div>
                    </div>

                </div>
            </div>


            <!--Customer's Order details-->
            <div class="flex-1">
                <div class="text-xl font-[600]">Orders Made (123)</div>
                <div class="mt-2 status-list flex justify-between ">
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

                <!-- Display Orders -->
                <div class="mt-2">
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
