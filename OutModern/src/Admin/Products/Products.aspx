<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="OutModern.src.Admin.Products.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {
            .filter-item .item {
                @apply cursor-pointer mr-2 border p-2 box-border;
            }

            .product-status {
                @apply rounded p-1;
            }

                .product-status.out-of-stock {
                    @apply bg-red-300;
                }

                .product-status.on-sales {
                    @apply bg-green-300;
                }

                .product-status.temp-unavailable {
                    @apply bg-amber-300;
                }

            table#data-table {
                @apply border-spacing-5 border-collapse text-center;
            }

            #data-table th > span {
                @apply opacity-50 cursor-pointer;
            }

                #data-table th > span > i {
                    @apply invisible;
                }

            #data-table tr {
                @apply border-b border-black;
            }
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h2>Products</h2>
    </div>
    <div>
        <!-- Filter and add item -->
        <div class="flex justify-between mt-5">

            <!--Add item-->
            <asp:HyperLink NavigateUrl="<%#urls[ProductAdd] %>" CssClass="hover:opacity-60 p-2 box-border border bg-green-600 text-white" ID="hyperlinkAddProduct" runat="server">
                <i class="fa-regular fa-plus"></i>
                New Product
            </asp:HyperLink>

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
        <div class="mt-5">
            <table id="data-table" style="width: 100%; text-align: center;">
                <tr>
                    <th>
                        <span data-header="id" style="opacity: 1;">id
                        <i class="fa-solid fa-arrow-up" style="visibility: visible;"></i>
                        </span>

                    </th>
                    <th>
                        <span data-header="id">Name
                        <i class="fa-solid fa-arrow-up"></i>
                        </span>
                    </th>
                    <th>
                        <span data-header="category">Category
                        <i class="fa-solid fa-arrow-up"></i>
                        </span>
                    </th>
                    <th>
                        <span data-header="colors">Colors
                        <i class="fa-solid fa-arrow-up"></i>
                        </span>
                    </th>
                    <th>
                        <span data-header="price">Price (RM)
                        <i class="fa-solid fa-arrow-up"></i>
                        </span>
                    </th>
                    <th>
                        <span data-header="quantity">Quantity
                        <i class="fa-solid fa-arrow-up"></i>
                        </span>
                    </th>
                    <th>
                        <span data-header="status">Status
                        <i class="fa-solid fa-arrow-up"></i>
                        </span>
                    </th>
                    <th>Action
                    </th>
                </tr>
                <tr>
                    <td>1</td>
                    <td>
                        <asp:Image ID="Image1" CssClass="mx-auto" runat="server" Width="5em" ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png" />
                        Premium Hoodie
                    </td>
                    <td>Hoodies</td>
                    <td>... ...</td>
                    <td>99.99</td>
                    <td>12</td>
                    <td>
                        <span class="product-status temp-unavailable">Unavailable</span>
                    </td>
                    <td>Edit</td>
                </tr>
                <tr>
                    <td>2</td>
                    <td>
                        <asp:Image ID="Image2" CssClass="mx-auto" runat="server" Width="5em" ImageUrl="~/images/product-img/hoodies/black-Hoodie/unisex-champion-tie-dye-hoodie-black-front-2-6116819deddd3.png" />
                        Champion Hoodies
                    </td>
                    <td>Hoodies</td>
                    <td>... ...</td>
                    <td>99.99</td>
                    <td>12</td>
                    <td><span class="product-status on-sales">On Sales</span></td>
                    <td>Edit</td>
                </tr>
                <tr>
                    <td>3</td>
                    <td>
                        <asp:Image ID="Image3" CssClass="mx-auto" runat="server" Width="5em" ImageUrl="~/images/product-img/hoodies/black-Hoodie/all-over-print-unisex-hoodie-white-left-611679bab84f3.png" />
                        Special Hoodie
                    </td>
                    <td>Hoodies</td>
                    <td>... ...</td>
                    <td>99.99</td>
                    <td>0</td>
                    <td><span class="product-status out-of-stock">Out of Stock</span></td>
                    <td>Edit</td>
                </tr>
                <tr>
                    <td>4</td>
                    <td>
                        <asp:Image ID="Image4" CssClass="mx-auto" runat="server" Width="5em" ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png" />
                        Premium Hoodie
                    </td>
                    <td>Hoodies</td>
                    <td>... ...</td>
                    <td>99.99</td>
                    <td>12</td>
                    <td>
                        <span class="product-status temp-unavailable">Unavailable</span>
                    </td>
                    <td>Edit</td>
                </tr>
                <tr>
                    <td>5</td>
                    <td>
                        <asp:Image ID="Image5" CssClass="mx-auto" runat="server" Width="5em" ImageUrl="~/images/product-img/hoodies/black-Hoodie/unisex-champion-tie-dye-hoodie-black-front-2-6116819deddd3.png" />
                        Champion Hoodies
                    </td>
                    <td>Hoodies</td>
                    <td>... ...</td>
                    <td>99.99</td>
                    <td>12</td>
                    <td><span class="product-status on-sales">On Sales</span></td>
                    <td>Edit</td>
                </tr>
                <tr>
                    <td>6</td>
                    <td>
                        <asp:Image ID="Image6" CssClass="mx-auto" runat="server" Width="5em" ImageUrl="~/images/product-img/hoodies/black-Hoodie/all-over-print-unisex-hoodie-white-left-611679bab84f3.png" />
                        Special Hoodie
                    </td>
                    <td>Hoodies</td>
                    <td>... ...</td>
                    <td>99.99</td>
                    <td>0</td>
                    <td><span class="product-status out-of-stock">Out of Stock</span></td>
                    <td>Edit</td>
                </tr>
            </table>

        </div>
    </div>

</asp:Content>
