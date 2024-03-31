<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="ProductReviewReply.aspx.cs" Inherits="OutModern.src.Admin.ProductReviewReply.ProductReviewReply" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {
            .review-item {
                @apply leading-4 opacity-80 text-sm [&>*]:leading-4 [&>*]:opacity-80 [&>*]:text-sm;
            }

            .review-time {
                @apply text-sm italic mb-2 [&>*]:text-sm [&>*]:italic;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div>
        <!-- Customer Review -->
        <div>
            <div class="text-[1.5rem] font-bold">Replying To : </div>

            <div class="mt-2 flex items-center gap-10 bg-[#E6F5F2] p-5 rounded">
                <!--Customer Details-->
                <div class="p-2 flex-shrink-0">
                    <div class="text-lg">
                        <asp:Label ID="lblCustomerName" runat="server" Text="Customer A"></asp:Label>
                    </div>
                    <div class="review-time">
                        <asp:Label ID="lblCustomerReviewDateTime" runat="server" Text="<%# DateTime.Now %>"></asp:Label>
                    </div>
                    <div class="review-item">
                        Rate :
                    <asp:Label ID="lblRating" runat="server" Text="3.0"></asp:Label>
                    </div>
                    <div class="review-item">
                        Color : 
                    <asp:Label ID="lblColor" runat="server" Text="Black"></asp:Label>
                    </div>
                    <div class="review-item">
                        Quantity :                    
                    <asp:Label ID="lblQuantity" runat="server" Text="12"></asp:Label>
                    </div>
                </div>


                <!-- Review Given -->
                <div class="border-l border-black p-2 pl-4">
                    <asp:Label ID="lblCustomerReview" runat="server" Text="This is some Review Given"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Replies -->
        <div class="max-w-screen-lg">
            <div class="text-[1.5rem] font-bold mt-10">
                Replies
            (<asp:Label ID="lblReplyNum" CssClass="text-[1.5rem] font-bold" runat="server" Text="2"></asp:Label>) :
            </div>

            <!--Reply input-->
            <div class="mt-2 overflow-hidden">
                <asp:TextBox ID="txtReply" TextMode="MultiLine" runat="server"
                    CssClass="resize-none w-full h-32 leading-5 border border-black p-2 rounded"
                    PlaceHolder="Write your reply here..."></asp:TextBox>
                <asp:Button ID="btnReplySend" CssClass="float-right text-white p-1 hover:cursor-pointer hover:opacity-50 bg-gray-400" runat="server" Text="Send" />
            </div>

            <!--Reply by other staff-->
            <div class="mt-5">
                <asp:Repeater ID="repeaterReviewReplies" runat="server">
                    <ItemTemplate>
                        <div class="reply rounded even:bg-gray-50 odd:bg-gray-100">
                            <div class="flex items-center gap-10 p-5">
                                <!--Staff Details-->
                                <div class="p-2 flex-shrink-0">
                                    <div class="text-lg"><%# Eval("AdminName") %>, <%# Eval("AdminRole") %></div>
                                    <div class="review-time"><%# Eval("ReviewReplyDateTime") %></div>
                                </div>
                                <!-- Reply Given -->
                                <div class="border-l border-black p-2 pl-4">
                                    <div>
                                        <%# Eval("ReviewReply") %>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>


        </div>
    </div>
</asp:Content>
