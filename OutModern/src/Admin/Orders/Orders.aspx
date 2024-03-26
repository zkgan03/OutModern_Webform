<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="OutModern.src.Admin.Orders.Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {
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
        <!--Add New Order-->
        <asp:HyperLink
            CssClass="inline-block rounded hover:opacity-60 p-2 box-border bg-green-600 text-white"
            ID="lbAddOrder" runat="server" NavigateUrl="#">
            <i class="fa-regular fa-plus"></i>       
            New Order
        </asp:HyperLink>

        <!-- Filter and add item -->
        <div class="flex justify-between items-center mt-8">
            <div>
                <h2>Order List</h2>
            </div>

            <!-- Filter -->
            <div class="filter-item flex">
                <div class="item">
                    Status
                    <i class="fa-regular fa-layer-group"></i>
                </div>
            </div>
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
                                    <asp:LinkButton ID="lbCustomerName" runat="server">
                                     Customer Name
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
                                <th>Action</th>
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
                        <td><%# Eval("CustomerName") %></td>
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
                        <td>
                            <asp:HyperLink ID="hlEdit" runat="server" CssClass="button" NavigateUrl='<%# urls[OrderEdit] +"?id=" +Eval("OrderId") %>'>
                                <i class="fa-regular fa-pen-to-square"></i>
                            </asp:HyperLink>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>

            <!--Pagination-->
            <asp:DataPager ID="dpBottomOrders" class="pagination" runat="server" PageSize="4" PagedControlID="lvOrders">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>
        </div>
    </div>

</asp:Content>
