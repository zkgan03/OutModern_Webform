<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="UserReivew.aspx.cs" Inherits="OutModern.src.Client.UserProfile.UserReivew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .datapagerStyle {
            padding: 8px 12px;
            margin: 0 3px;
            border: 1px solid black;
            border-radius: 4px;
            color: #333;
            background-color: #fff;
            cursor: pointer;
        }

            .datapagerStyle:hover, .active {
                padding: 8px 12px;
                margin: 0 3px;
                border: 1px solid black;
                border-radius: 4px;
                background-color: black;
                color: #fff;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mx-auto py-8">
        <h1 class="mb-6 text-3xl font-bold">User Review History</h1>
        <div class="rounded-lg bg-white p-6 shadow-md">
            <h2 class="mb-4 text-xl font-bold">Recent 5 Reviews</h2>
            <div class="overflow-x-auto">
                <div class="mb-5 flex space-x-4">
                    <asp:Repeater ID="rptReviews" runat="server">
                        <ItemTemplate>
                            <div class="min-w-[400px] flex-shrink-0 mr-4 rounded-lg bg-white p-4 shadow-md">
                                <asp:Image ImageUrl='<%# Eval("ProductImageUrl") %>' alt="Product Image" class="w-full h-52 object-cover cursor-pointer rounded-lg mb-4" ID="Image1" runat="server" onclick='<%# Eval("productID", "window.location.href = \"/src/Client/ProductDetails/ProductDetails.aspx?ProductId={0}\";") %>' />
                                <h3 class="mb-2 text-lg font-bold hover:underline hover:cursor-pointer" onclick='<%# Eval("productID", "window.location.href = \"/src/Client/ProductDetails/ProductDetails.aspx?ProductId={0}\";") %>'><%# Eval("ProductName") %></h3>
                                <p class="mb-2 text-gray-600">
                                    Color: <%# Eval("ColorName") %>
                                    | Size: <%# Eval("SizeName") %>
                                </p>
                                <p class="mb-2 text-gray-600">Your Rating: <%# GenerateStars(Convert.ToDouble(Eval("Rating"))) %></p>
                                <p class="mb-2 text-gray-700"><%# Eval("ReviewDescription") %></p>
                                <p class="text-gray-600"><%# Eval("ReviewDateTime") %></p>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        <div class="mt-8 rounded-lg bg-white p-6 shadow-md">
            <h1 class="mb-6 text-3xl font-semibold">My Reviews</h1>

            <div class="grid-cols-1 grid gap-5">
                <!-- Review Item -->
                <asp:ListView ID="lvReviews" runat="server" OnPagePropertiesChanged="lvReviews_PagePropertiesChanged">
                    <LayoutTemplate>
                        <div runat="server" id="itemPlaceholder"></div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <div class="mb-4 flex items-start rounded-lg bg-white p-6 shadow-md">
                            <!-- Product Image -->
                            <asp:Image ImageUrl='<%# Eval("ProductImageUrl") %>' alt="Product Image" class="w-48 h-48 object-cover rounded-md mr-9" ID="Image1" runat="server" onclick='<%# Eval("ProductID", "window.location.href = \"/src/Client/ProductDetails/ProductDetails.aspx?ProductId={0}\";") %>' />

                            <!-- Review Details -->
                            <div>
                                <h2 class="mb-2 text-xl font-semibold"><%# Eval("ProductName") %></h2>
                                <p class="mb-2 text-gray-600">Size: <%# Eval("SizeName") %></p>
                                <p class="mb-2 text-gray-600">Color: <%# Eval("ColorName") %></p>
                                <p class="mb-2 text-gray-600">Rating: <%# GenerateStars(Convert.ToDouble(Eval("Rating"))) %></p>
                                <p class="mb-2 text-gray-800"><%# Eval("ReviewDescription") %></p>
                                <p class="text-gray-600">Review Date: <%# Eval("ReviewDateTime", "{0:MMMM dd, yyyy}") %></p>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:ListView>
                <div class="flex justify-center">
                    <asp:DataPager ID="ddpReviews" CssClass="data-pager" runat="server" PageSize="8" PagedControlID="lvReviews">
                        <Fields>
                            <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="datapagerStyle" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                            <asp:NumericPagerField NumericButtonCssClass="datapagerStyle" CurrentPageLabelCssClass="active" ButtonCount="5" />
                            <asp:NextPreviousPagerField ButtonType="Button" ButtonCssClass="datapagerStyle" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                        </Fields>
                    </asp:DataPager>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

