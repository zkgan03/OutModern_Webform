<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="OutModern.src.Admin.Products.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {

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

        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="mt-2">
        <!--Add item-->
        <asp:HyperLink NavigateUrl="<%#urls[ProductAdd] %>" CssClass="inline-block rounded hover:opacity-60 p-2 box-border bg-green-600 text-white" ID="hyperlinkAddProduct" runat="server">
            <i class="fa-regular fa-plus"></i>
            New Product
        </asp:HyperLink>

        <!-- Filter and add item -->
        <div class="flex justify-between items-center mt-8">
            <div>
                <h2>Product List</h2>
            </div>

            <!-- Filter -->
            <div class="filter-item flex">
                <div class="item">
                    Category
                    <i class="fa-regular fa-layer-group"></i>
                </div>
                <div class="item">
                    Price Range
                    <i class="fa-regular fa-sliders-simple"></i>
                </div>
            </div>
        </div>

        <!-- Display Product -->
        <div class="mt-2">
            <!--Pagination-->
            <asp:DataPager PagedControlID="lvProducts" ID="dpTopProducts" class="pagination" runat="server" PageSize="2">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>

            <asp:ListView OnItemCommand="lvProducts_ItemCommand" OnPagePropertiesChanged="lvProducts_PagePropertiesChanged" ID="lvProducts" runat="server" DataKeyNames="Id" OnItemDataBound="lvProducts_ItemDataBound">
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
                                        Category
                                        <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbColors" runat="server">
                                        Colors
                                        <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbPrice" runat="server">
                                        Price (RM)
                                        <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbQuantity" runat="server">
                                        Quantity
                                        <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="LinkButton1" runat="server">
                                        Status
                                        <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="LinkButton2" runat="server">
                                        Reviews
                                        <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tr runat="server" id="itemPlaceholder" class="data-table-item"></tr>
                    </table>

                </LayoutTemplate>
                <ItemTemplate>
                    <tr onclick="window.location='<%# Page.ResolveClientUrl(urls[ProductDetails] + "?id=" +  Eval("Id") )%>'">
                        <td><%# Eval("Id") %></td>
                        <td>
                            <asp:Image ID="imgPath" CssClass="mx-auto" runat="server" Width="5em" ImageUrl='<%# Eval("Path") %>' />
                            <%# Eval("Name") %>
                        </td>
                        <td><%# Eval("Category") %></td>
                        <td>...</td>
                        <td><%# Eval("Price", "{0:0.00}") %></td>
                        <td><%# Eval("Quantity") %></td>
                        <td>
                            <span runat="server" id="productStatus" class="product-status"><%# Eval("Status") %></span>
                        </td>
                        <td><%# Eval("Reviews") %></td>
                        <td>
                            <asp:HyperLink NavigateUrl='<%#urls[ProductEdit] + "?id=" + Eval("Id") %>' runat="server" CssClass="button">
                                <i class="fa-regular fa-pen-to-square"></i>
                            </asp:HyperLink>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:ListView>


            <!--Pagination-->
            <asp:DataPager PagedControlID="lvProducts" ID="dpBottomProducts" class="pagination" runat="server" PageSize="2">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>
        </div>
    </div>

</asp:Content>
