<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="PromoCode.aspx.cs" Inherits="OutModern.src.Admin.PromoCode.PromoCode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {
            #data-table tbody tr {
                @apply cursor-default;
            }

            .filter-model {
                @apply items-center justify-center fixed w-full h-full m-auto inset-0 bg-black bg-opacity-50 z-10;
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
                <div>
                    <div id="filter-date" class="item">
                        Date
                        <i class="fa-regular fa-calendar"></i>
                    </div>

                    <asp:Panel runat="server" ID="panelDateFilterModel" class="filter-model hidden">
                        <div class="relative rounded bg-white size-fit px-10 py-5">
                            <div id="btnCloseDateFilter" class="absolute top-0 right-2 text-xl cursor-pointer font-bold text-red-500">X</div>
                            <div class="m-auto">
                                <div>
                                    <div class="font-bold">
                                        Start Date
                                    </div>
                                    <div class="flex gap-5">
                                        <div>
                                            <div>
                                                From : 
                                            </div>
                                            <asp:TextBox ID="txtStartDateFrom" TextMode="Date" runat="server"></asp:TextBox>
                                        </div>
                                        <div>
                                            <div>
                                                To : 
                                            </div>
                                            <asp:TextBox ID="txtStartDateTo" TextMode="Date" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-5">
                                    <div class="font-bold">
                                        End Date
                                    </div>
                                    <div class="flex gap-5">
                                        <div>
                                            <div>
                                                From : 
                                            </div>
                                            <asp:TextBox ID="txtEndDateFrom" TextMode="Date" runat="server"></asp:TextBox>
                                        </div>
                                        <div>
                                            <div>
                                                To : 
                                            </div>
                                            <asp:TextBox ID="txtEndDateTo" TextMode="Date" runat="server"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="mt-5 overflow-hidden">
                                    <asp:Button ID="btnClear" runat="server"
                                        OnClick="btnClear_Click"
                                        Text="Clear" CssClass="float-left button bg-red-500" />
                                    <asp:Button ID="btnFilter" runat="server"
                                        OnClick="btnFilter_Click"
                                        Text="Filter" CssClass="float-right button bg-green-500" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
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
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbCode" runat="server" CommandName="Sort" CommandArgument="PromoCode">
                                     Code
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbDiscountRate" runat="server" CommandName="Sort" CommandArgument="DiscountRate">
                                      Discount Rate (%)
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbStartDate" runat="server" CommandName="Sort" CommandArgument="StartDate">
                                     Start Date
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbEndDate" runat="server" CommandName="Sort" CommandArgument="EndDate">
                                     End Date
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbQuantity" runat="server" CommandName="Sort" CommandArgument="Quantity">
                                     Quantity
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
                <EmptyDataTemplate>
                    No data..
                </EmptyDataTemplate>
            </asp:ListView>

            <!--Pagination-->
            <asp:DataPager ID="dpBottomPromoCodes" class="pagination" runat="server" PageSize="10" PagedControlID="lvPromoCodes">
                <Fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </Fields>
            </asp:DataPager>


        </div>
    </div>
    <script>

        //show model when click on date filte
        document.getElementById('filter-date').addEventListener('click', function () {
            document.getElementById('<%= panelDateFilterModel.ClientID%>').style.display = 'flex';
        });

        //close model when click on close button
        document.getElementById('btnCloseDateFilter').addEventListener('click', function () {
            document.getElementById('<%= panelDateFilterModel.ClientID%>').style.display = 'none';
        });
    </script>
</asp:Content>
