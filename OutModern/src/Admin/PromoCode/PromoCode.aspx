﻿<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="PromoCode.aspx.cs" Inherits="OutModern.src.Admin.PromoCode.PromoCode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {
            #data-table tbody tr {
                @apply cursor-default;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="mt-2">
        <!--Add New Promo Code-->
        <asp:LinkButton
            CssClass="inline-block rounded hover:opacity-60 p-2 box-border bg-green-600 text-white"
            ID="lbAddPromoCode" runat="server" OnClick="lbAddPromoCode_Click">
                <i class="fa-regular fa-plus"></i>      
            New Promo Code
        </asp:LinkButton>

        <!-- Filter and add item -->
        <div class="flex justify-between items-center mt-8">
            <div>
                <h2>Promo Code List</h2>
            </div>

            <!-- Filter -->
            <div class="filter-item flex">
                <div class="item">
                    Date
                    <i class="fa-regular fa-calendar"></i>
                </div>
            </div>
        </div>

        <!-- Display Product -->
        <div class="mt-2">
            <!--Pagination-->
            <asp:DataPager ID="dpTopPromoCodes" class="pagination" runat="server" PagedControlID="lvPromoCodes">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>

            <asp:Label ID="lblMsg" runat="server"
                CssClass="block my-5"
                Text="**" Visible="false"></asp:Label>

            <asp:ListView
                OnItemInserting="lvPromoCodes_ItemInserting"
                OnItemCanceling="lvPromoCodes_ItemCanceling"
                OnItemEditing="lvPromoCodes_ItemEditing"
                OnItemUpdating="lvPromoCodes_ItemUpdating"
                OnItemCommand="lvPromoCodes_ItemCommand"
                OnPagePropertiesChanged="lvPromoCodes_PagePropertiesChanged"
                DataKeyNames="PromoId, PromoCode"
                OnSorting="lvPromoCodes_Sorting"
                ID="lvPromoCodes" runat="server">
                <LayoutTemplate>
                    <table id="data-table" style="width: 100%; text-align: center;">
                        <thead>
                            <tr class="data-table-head">
                                <th class="active">
                                    <asp:LinkButton ID="lbId" runat="server" CommandName="Sort" CommandArgument="PromoId">
                                     ID
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbCode" runat="server" CommandName="Sort" CommandArgument="PromoCode">
                                     Code
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbDiscountRate" runat="server" CommandName="Sort" CommandArgument="DiscountRate">
                                      Discount Rate (%)
                                      <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbStartDate" runat="server" CommandName="Sort" CommandArgument="StartDate">
                                     Start Date
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbEndDate" runat="server" CommandName="Sort" CommandArgument="EndDate">
                                     End Date
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbQuantity" runat="server" CommandName="Sort" CommandArgument="Quantity">
                                     Quantity
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
                    <tr>
                        <td><%# Eval("PromoId") %></td>
                        <td><%# Eval("PromoCode") %></td>
                        <td><%# Eval("DiscountRate") %></td>
                        <td><%# Eval("StartDate", "{0:dd/MM/yyyy </br> h:mm tt}") %></td>
                        <td><%# Eval("EndDate","{0:dd/MM/yyyy </br> h:mm tt}") %></td>
                        <td><%# Eval("Quantity") %></td>
                        <td>
                            <asp:LinkButton ID="lbEdit" runat="server" CssClass="button" CommandName="Edit">
                                <i class="fa-regular fa-pen-to-square"></i>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <InsertItemTemplate>
                    <tr class="bg-green-100">
                        <td>
                            <asp:Label ID="lblNewPromoId" runat="server" Text="-"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-28 px-2" ID="txtAddPromoCode" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-14 px-2" ID="txtAddDiscountRate" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-fit px-2" ID="txtStartDate" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-fit px-2" ID="txtEndDate" runat="server" TextMode="DateTimeLocal"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-14 px-2" ID="txtAddQuantity" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button UseSubmitBehavior="false" CssClass="button bg-green-500" ID="btnAdd" runat="server" Text="Add" CommandName="Insert" />
                            <asp:Button UseSubmitBehavior="false" ID="btnCancel" CssClass="button bg-red-500 mt-2" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                    </tr>
                </InsertItemTemplate>
                <EditItemTemplate>
                    <tr class="bg-amber-100">
                        <td>
                            <asp:Label ID="lblPromoId" runat="server" Text='<%# Eval("PromoId") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-28 px-2" ID="txtAddPromoCode" runat="server" Text='<%# Eval("PromoCode") %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-14 px-2" ID="txtAddDiscountRate" runat="server" Text='<%# Eval("DiscountRate") %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-fit px-2" ID="txtStartDate" runat="server" TextMode="DateTimeLocal"
                                Text='<%# Eval("StartDate", "{0:yyyy-MM-ddTHH:mm}") %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-fit px-2" ID="txtEndDate" runat="server" TextMode="DateTimeLocal"
                                Text='<%# Eval("EndDate", "{0:yyyy-MM-ddTHH:mm}")  %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-14 px-2" ID="txtAddQuantity" runat="server" Text='<%# Eval("Quantity") %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button UseSubmitBehavior="false" CssClass="button bg-green-500" ID="btnAdd" runat="server" Text="Update" CommandName="Update" />
                            <asp:Button UseSubmitBehavior="false" ID="btnCancel" CssClass="button bg-red-500 mt-2" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                    </tr>
                </EditItemTemplate>
            </asp:ListView>

            <!--Pagination-->
            <asp:DataPager ID="dpBottomPromoCodes" class="pagination" runat="server" PageSize="4" PagedControlID="lvPromoCodes">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>


        </div>
    </div>

</asp:Content>
