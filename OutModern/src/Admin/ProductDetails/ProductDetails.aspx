﻿<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="OutModern.src.Admin.ProductDetails.ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/tailwindcss">
        @layer components {
            .desc-grp {
                @apply mb-2 leading-5;
            }

                .desc-grp .desc-title {
                }

                .desc-grp div:nth-child(n+2) {
                    @apply px-4 py-1 border border-gray-300 rounded;
                }

            .product-img {
                @apply border border-black;
            }

            .color-varient {
                @apply cursor-pointer size-5 rounded-full border drop-shadow border-gray-300 box-border hover:opacity-50;
            }

                .color-varient.active {
                    @apply outline outline-black outline-1 hover:opacity-100;
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
                @apply text-sm italic mb-2 [&>*]:text-sm [&>*]:italic;
            }

            .reply-time {
                @apply text-sm italic mb-2 [&>*]:text-sm [&>*]:italic;
            }

            .review-reply-btn {
                @apply p-1 border border-black rounded bg-gray-500 text-white cursor-pointer hover:opacity-50;
            }

            .reply-container {
                @apply mt-8;
            }

            .reply {
                @apply ml-10 border-t border-black pb-7 p-2;
            }

            .reply-container .reply:nth-child(2n+1) {
                @apply bg-gray-100;
            }

            .reply-container .reply:nth-child(2n) {
                @apply bg-gray-50;
            }

            .reply .reply-given {
                @apply ml-5;
            }
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-2">

        <!--Edit product btn-->
        <div class="flex items-center gap-2">
            <asp:Label CssClass="text-2xl font-extrabold" ID="lblTitleProductName" runat="server" Text="Premium Hoodie"></asp:Label>
            <asp:HyperLink
                CssClass="inline-block text-white px-2 py-1 rounded bg-amber-500 hover:opacity-50" ID="hlEditProduct" runat="server"
                NavigateUrl='<%#urls[ProductEdit] + "?id=" + Request.QueryString["id"] %>'>
            <i class="fa-regular fa-pen-to-square"></i>
            </asp:HyperLink>
        </div>

        <!-- Product Container-->
        <div class="flex mt-8 gap-20">
            <!-- Product Details -->
            <div class="w-56">
                <div class="text-xl font-[600]">Product Info</div>
                <div class="mt-4 ml-2 text-xl">
                    <div class="desc-grp">
                        <div class="desc-title">Product ID</div>
                        <div>
                            <asp:Label ID="lblProductId" runat="server" Text="P1001"></asp:Label>
                        </div>
                    </div>
                    <div class="desc-grp">
                        <div class="desc-title">Category</div>
                        <div>
                            <asp:Label ID="lblCategory" runat="server" Text="Hoodie"></asp:Label>
                        </div>
                    </div>
                    <div class="desc-grp">
                        <div class="desc-title">Price (RM)</div>
                        <div>
                            <asp:Label ID="lblPrice" runat="server" Text="99.99"></asp:Label>
                        </div>
                    </div>
                    <div class="desc-grp">
                        <div class="desc-title">Status</div>
                        <div>
                            <asp:Label ID="lblStatus" runat="server" Text="In Stock"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Variation -->
            <div class="flex-1">
                <div class="text-xl font-[600]">Variation</div>

                <div class="mt-4">

                    <div class="flex mt-4 items-center gap-7">

                        <!--Size selection-->
                        <div>
                            <div>Size</div>
                            <div>
                                <asp:DropDownList ID="ddlSize" runat="server">
                                    <asp:ListItem>S</asp:ListItem>
                                    <asp:ListItem>M</asp:ListItem>
                                    <asp:ListItem>L</asp:ListItem>
                                    <asp:ListItem>XL</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                        </div>
                        <div class="">
                            <div>Quantity</div>
                            <div>
                                <asp:Label CssClass="w-16 border border-gray-300 px-2 rounded" TextMode="Number" ID="lblQuantity" runat="server" Text="123"></asp:Label>
                            </div>
                        </div>
                    </div>

                    <!--Colors-->
                    <div class="mb-2 mt-2">
                        <div>Color</div>
                        <div class="flex items-center gap-2">
                            <asp:Repeater ID="repeaterColors" OnItemDataBound="repeaterColors_ItemDataBound" OnItemCommand="repeaterColors_ItemCommand" runat="server">
                                <ItemTemplate>
                                    <asp:Button ID="btnColor" runat="server" UseSubmitBehavior="false"
                                        CommandName="ChangeColor" CommandArgument='<%# Eval("Color") %>'
                                        Style='<%# "background:" + Eval("Color") +";" %>' CssClass='<%# "color-varient" + (Container.ItemIndex == 0 ? " active" : "") %>' />
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </div>

                    <!-- Images -->
                    <div class="flex gap-2 mt-2">
                        <asp:Repeater ID="repeaterImg" runat="server">
                            <ItemTemplate>
                                <asp:Image ID="imgProd" runat="server" Width="10em"
                                    CssClass="product-img"
                                    ImageUrl='<%# Eval("path") %>' />
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
        </div>

        <!-- Review and Rating -->
        <div class="mt-10">
            <div class="text-xl font-[600]">
                Reviews (<asp:Label CssClass="text-3xl font-bold text-amber-500" ID="lblOverallRating" runat="server" Text="4.0"></asp:Label>/5.0)
            </div>

            <!--Top Pagination-->
            <asp:DataPager PagedControlID="lvReviews" class="pagination" ID="dpTopReviews" runat="server" PageSize="2">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField NumericButtonCssClass="datapagerStyle" CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonCssClass="test" ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>

            <asp:ListView ID="lvReviews" OnPagePropertiesChanged="lvReviews_PagePropertiesChanged" runat="server" DataKeyNames="CustomerName">
                <LayoutTemplate>
                    <div>
                        <table id="review-table" style="margin-top: 1em; padding: 1em; border: 1px solid black; width: 100%; border-spacing: 1px; text-align: center; border-collapse: collapse;">
                            <tr>
                                <th style="border: 1px solid black" class="auto-style1">Customer Info</th>
                                <th style="border: 1px solid black">Review Given</th>
                                <th style="border: 1px solid black" class="auto-style2">Action</th>
                            </tr>
                            <asp:PlaceHolder ID="itemPlaceHolder" runat="server"></asp:PlaceHolder>
                        </table>
                    </div>

                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td style="padding: 1em; border: 1px solid black; text-align: left" aria-multiline="True" class="auto-style1">
                            <div class="text-lg font-[600]">
                                <%# Eval("CustomerName") %>
                            </div>
                            <div class="review-time"><%# Eval("ReviewTime") %></div>
                            <div class="review-item">rate : <%# Eval("ReviewRating","{0:0.0}") %></div>
                            <div class="review-item">color : <%# Eval("ReviewColor") %></div>
                            <div class="review-item">quantity : <%#Eval("ReviewQuantity") %></div>
                        </td>
                        <td style="padding: 1em; border: 1px solid black; text-align: left" aria-multiline="True">
                            <div class="review-gien">
                                <%# Eval("ReviewText") %>
                            </div>

                            <!-- Reply for review -->
                            <div class="reply-container">
                                <asp:Repeater ID="replyRepeater" runat="server" DataSource='<%# Eval("Replies") %>'>
                                    <ItemTemplate>
                                        <div class="reply">
                                            <div class="mb-2 text-sm opacity-60">reply</div>
                                            <div class="reply-name"><%# Eval("AdminName") %>, <%# Eval("AdminRole") %></div>
                                            <div class="reply-time"><%# Eval("ReplyTime") %></div>
                                            <div class="reply-given"><%# Eval("ReplyText") %></div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>

                        </td>
                        <td style="border: 1px solid black" class="auto-style2">
                            <asp:HyperLink ID="hlReply" CssClass="review-reply-btn" runat="server" NavigateUrl='<%#urls[ProductReviewReply] +"?id=" + Eval("CustomerName") %>'>Reply</asp:HyperLink>
                        </td>
                    </tr>
                </ItemTemplate>
                <EmptyDataTemplate>
                    <p>No review yet...</p>
                </EmptyDataTemplate>
            </asp:ListView>

            <!--Pagination Bottom-->
            <asp:DataPager PagedControlID="lvReviews" class="pagination" ID="dpBottomReviews" runat="server" PageSize="2">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField NumericButtonCssClass="datapagerStyle" CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonCssClass="test" ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>
        </div>
    </div>
</asp:Content>