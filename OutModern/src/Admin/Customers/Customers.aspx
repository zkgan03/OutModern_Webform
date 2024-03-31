﻿<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="OutModern.src.Admin.Customers.Customers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {

            .user-status {
                @apply rounded p-1;
            }

                .user-status.activated {
                    @apply bg-green-300;
                }

                .user-status.locked {
                    @apply bg-amber-300;
                }

                .user-status.deleted {
                    @apply bg-red-300;
                }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-2">

        <!-- Filter and add item -->
        <div class="flex justify-between items-center mt-8">
            <div>
                <h2>Customer List</h2>
            </div>

            <!-- Filter -->
            <div class="filter-item flex">
                <div class="item">
                    Status
                  <i class="fa-regular fa-layer-group"></i>
                </div>
            </div>

        </div>

        <!-- Display Product -->
        <div class="mt-2">
            <!--Pagination-->
            <asp:DataPager ID="dpTopCustomers" class="pagination" runat="server" PagedControlID="lvCustomers">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>

            <asp:ListView
                OnItemDataBound="lvCustomers_ItemDataBound"
                OnPagePropertiesChanged="lvCustomers_PagePropertiesChanged"
                ID="lvCustomers"
                runat="server">
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
                              Username
                              <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbProductOrdered" runat="server">
                              Email
                              <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>

                                <th>
                                    <asp:LinkButton ID="lbSubtotal" runat="server">
                             Phone No
                             <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbOrderStatus" runat="server">
                             Status
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
                    <tr onclick="window.location='<%# Page.ResolveClientUrl(urls[CustomerDetails] + "?id=" +  Eval("CustomerId") )%>'">
                        <td><%# Eval("CustomerId") %></td>
                        <td><%# Eval("CustomerName") %></td>
                        <td><%# Eval("CustomerUsername") %></td>
                        <td><%# Eval("CustomerEmail") %></td>
                        <td><%# Eval("CustomerPhoneNumber") %></td>
                        <td><span runat="server" id="userStatus" class="user-status"><%# Eval("UserStatusName") %></span></td>
                        <td>
                            <asp:HyperLink ID="hlEdit" runat="server" CssClass="button" NavigateUrl='<%#urls[CustomerEdit] +"?id=" +Eval("CustomerId") %>'>
                        <i class="fa-regular fa-pen-to-square"></i>
                            </asp:HyperLink>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>

            <!--Pagination-->
            <asp:DataPager ID="dpBottomCustomers" class="pagination" runat="server" PageSize="4" PagedControlID="lvCustomers">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>
        </div>
    </div>
</asp:Content>