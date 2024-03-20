<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="OutModern.src.Admin.ProductDetails.ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/tailwindcss">
        @layer components {
            .desc-title {
                @apply inline-block w-28 float-left;
            }

            .product-img {
                @apply border border-black;
            }

            .color-varient {
                @apply cursor-pointer size-5 rounded-full border drop-shadow border-white box-border;
            }

                .color-varient.active {
                    @apply outline outline-black outline-1;
                }
            /*Table style*/
            #review-table tr:first-child {
                @apply sticky top-14 bg-gray-950 text-white;
            }

            #review-table tr:nth-child(n+2) {
                @apply hover:bg-[#E6F5F2];
            }

            .review-item {
                @apply leading-4 opacity-80 text-sm [&>*]:leading-4 [&>*]:opacity-80 [&>*]:text-sm;
            }

            .review-time {
                @apply text-sm italic mb-2;
            }

            .reply-time {
                @apply text-sm italic mb-2;
            }

            .review-reply-btn {
                @apply p-1 border border-black rounded bg-gray-500 text-white cursor-pointer hover:opacity-50;
            }

            .reply {
                @apply ml-10 border-t border-black mt-7 p-1;
            }

                .reply .reply-given {
                    @apply ml-5;
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

        .auto-style1 {
            width: 200px;
        }

        .auto-style2 {
            width: 150px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-2">
        <!--Edit product btn-->
        <div>
            <asp:HyperLink CssClass="text-white p-2 rounded bg-amber-500 hover:opacity-50" ID="HyperLink1" runat="server" NavigateUrl='<%#urls[ProductEdit] %>'>
            <i class="fa-regular fa-pen-to-square"></i>
            Edit Product
            </asp:HyperLink>
        </div>
        <!-- Products Desc -->
        <div class="flex mt-5">
            <!-- General Desc -->
            <div>
                <div class="text-[1.5rem] font-bold">General Description</div>
                <div class="mt-2 ml-2 text-xl">
                    <div>
                        <span class="desc-title">Product ID</span>
                        <span>: P1001</span>
                    </div>
                    <div>
                        <span class="desc-title">Product Name</span>
                        <span>: Premium Hoodie</span>
                    </div>
                    <div>
                        <span class="desc-title">Category</span>
                        <span>: Hoodie</span>
                    </div>
                    <div>
                        <span class="desc-title">Price (RM)</span>
                        <span>: 99.99</span>
                    </div>
                    <div>
                        <span class="desc-title">Quantity</span>
                        <span>: 123</span>
                    </div>
                    <div>
                        <span class="desc-title">Current Status</span>
                        <span>: In stock</span>
                    </div>
                </div>
            </div>

            <!-- Variation -->
            <div class="flex-1 ml-36">
                <div class="text-[1.5rem] font-bold">Variation</div>

                <!--Colors-->
                <div class="flex gap-2 mt-2">
                    <div>colors :</div>
                    <div data-color="white" class="color-varient bg-white"></div>
                    <div data-color="black" class="color-varient bg-black"></div>
                    <div data-color="beige" class="color-varient active bg-[#E0CCBC]"></div>
                </div>

                <!-- Images -->
                <div class="flex gap-2 mt-2">
                    <asp:Image ID="imgProd1" runat="server" Width="10em"
                        CssClass="product-img"
                        ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png" />
                    <asp:Image ID="imgProd2" runat="server" Width="10em"
                        CssClass="product-img"
                        ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de644282.png" />
                    <asp:Image ID="imgProd3" runat="server" Width="10em"
                        CssClass="product-img"
                        ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-zoomed-in-61167de6440a2.png" />
                </div>
            </div>
        </div>

        <!-- Review and Rating -->
        <div class="mt-10">
            <div>
                <div class="text-[1.5em] font-bold">
                    Reviews and Ratings (<span class="text-[1em] font-bold ">4.0</span>/5.0)
                </div>
            </div>

            <table id="review-table" style="margin-top: 1em; padding: 1em; border: 1px solid black; width: 100%; border-spacing: 1px; text-align: center; border-collapse: collapse;">
                <tr>
                    <td style="border: 1px solid black" class="auto-style1">Customer Info</td>
                    <td style="border: 1px solid black">Review Given</td>
                    <td style="border: 1px solid black" class="auto-style2">Response?</td>
                </tr>
                <tr>
                    <td style="padding: 1em; border: 1px solid black; text-align: left" aria-multiline="True" class="auto-style1">
                        <div class="text-lg">Customer A</div>
                        <div class="review-time"><%= DateTime.Now %></div>
                        <div class="review-item">rate : 4.0</div>
                        <div class="review-item">color : black</div>
                        <div class="review-item">quantity : 30</div>
                    </td>
                    <td style="padding: 1em; border: 1px solid black; text-align: left" aria-multiline="True">
                        <div class="review-gien">
                            This is amazing !
                        </div>
                    </td>
                    <td style="border: 1px solid black" class="auto-style2">
                        <asp:Button CssClass="review-reply-btn" ID="btnReply" runat="server" Text="Reply" />
                    </td>
                </tr>

                <tr>
                    <td style="padding: 1em; border: 1px solid black; text-align: left" aria-multiline="True" class="auto-style1">
                        <div class="text-lg">Customer B</div>
                        <div class="review-time mb-2"><%= DateTime.Now %></div>
                        <div class="review-item">rate : 2.0</div>
                        <div class="review-item">color : white</div>
                        <div class="review-item">quantity : 2</div>
                    </td>
                    <td style="padding: 1em; border: 1px solid black; text-align: left" aria-multiline="True">
                        <div class="review-given">
                            ? WTH is this
                        </div>
                        <div class="reply">
                            <div class="mb-2 text-sm opacity-60">reply</div>
                            <div class="reply-name">Gan, Admin </div>
                            <div class="reply-time"><%= DateTime.Now %></div>
                            <div class="reply-given">
                                Hi, please edit your question to specify the probelm you faced
                            </div>
                        </div>
                        <div class="reply">
                            <div class="mb-2 text-sm opacity-60">reply</div>
                            <div class="reply-name">Su, Associate</div>
                            <div class="reply-time"><%= DateTime.Now %></div>
                            <div class="reply-given">
                                This should not be a problem
                            </div>
                        </div>
                    </td>
                    <td style="border: 1px solid black" class="auto-style2">
                        <asp:Button CssClass="review-reply-btn" ID="Button1" runat="server" Text="Edit Reply" />
                    </td>
                </tr>
            </table>

            <!--Pagination-->
            <div class="pagination">
                <span>&lt;</span>
                <span class="active">1</span>
                <span>2</span>
                <span>3</span>
                <span>&gt;</span>
            </div>

        </div>
    </div>
</asp:Content>
