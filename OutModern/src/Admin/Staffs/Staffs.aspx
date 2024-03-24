<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="Staffs.aspx.cs" Inherits="OutModern.src.Admin.Staffs.Staffs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {
            .button {
                @apply text-white px-2 py-1 cursor-pointer bg-amber-500 hover:opacity-50 rounded;
            }

            .filter-item .item {
                @apply cursor-pointer mr-2 border p-2 box-border;
            }

            .product-status {
                @apply rounded p-1;
            }

                .product-status.out-of-stock {
                    @apply bg-red-300;
                }

                .product-status.in-stock {
                    @apply bg-green-300;
                }

                .product-status.temp-unavailable {
                    @apply bg-amber-300;
                }

            /*Table style*/
            #data-table {
                @apply border-spacing-5 border-collapse text-center;
            }

                #data-table tr {
                    @apply border-b border-black;
                }

                #data-table thead {
                    @apply sticky top-14 bg-gray-950 text-white;
                }

                    #data-table thead th {
                        @apply p-1;
                    }

                        #data-table thead th > * {
                            @apply text-opacity-50 cursor-pointer hover:bg-gray-100 hover:text-gray-950 p-1 rounded;
                        }

                        #data-table thead th.active {
                            @apply text-opacity-100;
                        }

                            #data-table thead th.active i {
                                @apply visible;
                            }

                        #data-table thead th i {
                            @apply invisible;
                        }

                #data-table tbody tr {
                    @apply hover:bg-[#DBF0ED] cursor-pointer;
                }

                #data-table tbody td {
                    @apply p-2;
                }
            /*Pagination style*/
            .pagination {
                @apply flex justify-center my-2;
            }

                .pagination span {
                    @apply border border-black cursor-pointer hover:bg-[#E6F5F2] size-8 text-center leading-8;
                }

                    .pagination span.active {
                        @apply bg-[#94D4CA];
                    }

                    .pagination span:first-child {
                        @apply mr-2;
                    }

                    .pagination span:last-child {
                        @apply ml-2;
                    }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="mt-2">
        <!--Add New Staff-->
        <asp:HyperLink NavigateUrl='<%#"#" %>' CssClass="inline-block rounded hover:opacity-60 p-2 box-border bg-green-600 text-white" ID="hyperlinkAddProduct" runat="server">
            <i class="fa-solid fa-user-plus"></i>         
            New Staff
        </asp:HyperLink>

        <!-- Filter and add item -->
        <div class="flex justify-between items-center mt-8">
            <div>
                <h2>Staff List</h2>
            </div>

            <!-- Filter -->
            <div class="filter-item flex">
                <div class="item">
                    Role
                 <i class="fa-regular fa-layer-group"></i>
                </div>
                <div class="item">
                    Status
                    <i class="fa-regular fa-layer-group"></i>
                </div>
            </div>
        </div>

        <!-- Display Product -->
        <div class="mt-2">
            <!--Pagination-->
            <asp:DataPager PagedControlID="lvStaffs" ID="dpTopStaffs" class="pagination" runat="server" PageSize="2">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>

            <asp:ListView OnPagePropertiesChanged="lvStaffs_PagePropertiesChanged" ID="lvStaffs" runat="server" DataKeyNames="AdminId">
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
                                    <asp:LinkButton ID="lbName" runat="server">
                                     Name
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>

                                </th>
                                <th>
                                    <asp:LinkButton ID="lbCategory" runat="server">
                                     Role
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbColors" runat="server">
                                     Status
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>Edit?</th>
                            </tr>
                        </thead>
                        <tr runat="server" id="itemPlaceholder" class="data-table-item"></tr>
                    </table>

                </LayoutTemplate>
                <ItemTemplate>
                    <tr onclick="window.location='<%#Page.ResolveClientUrl(urls[StaffDetails] + "?id=" +  Eval("AdminId") )%>'">
                        <td><%# Eval("AdminId") %></td>
                        <td>
                            <%# Eval("AdminName") %>
                        </td>
                        <td><%# Eval("AdminRole") %></td>
                        <td><%# Eval("AdminStatus") %></td>
                        <td>
                            <asp:HyperLink NavigateUrl='<%#urls[StaffEdit] + "?id=" + Eval("AdminId") %>' runat="server" CssClass="button">
                             <i class="fa-regular fa-pen-to-square"></i>
                            </asp:HyperLink>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>


            <!--Pagination-->
            <asp:DataPager PagedControlID="lvStaffs" ID="dpBottomStaffs" class="pagination" runat="server" PageSize="2">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>
        </div>
    </div>

</asp:Content>
