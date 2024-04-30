﻿<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="Staffs.aspx.cs" Inherits="OutModern.src.Admin.Staffs.Staffs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {

            #data-table tbody tr {
                @apply cursor-default;
            }

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
        <!--Add New Staff-->
        <asp:LinkButton
            CssClass="inline-block rounded hover:opacity-60 p-2 box-border bg-green-600 text-white"
            ID="lbAddStaff" runat="server" OnClick="lbAddStaff_Click" CommandName="Insert">
            <i class="fa-solid fa-user-plus"></i>
            New Staff
        </asp:LinkButton>

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
            </div>
        </div>

        <!-- Display Product -->
        <div class="mt-2">
            <!--Pagination-->
            <asp:DataPager ID="dpTopStaffs" class="pagination" runat="server" PagedControlID="lvStaffs">
                <fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </fields>
            </asp:DataPager>

            <asp:ListView
                OnItemInserting="lvStaffs_ItemInserting"
                OnItemCanceling="lvStaffs_ItemCanceling"
                OnItemEditing="lvStaffs_ItemEditing"
                OnItemUpdating="lvStaffs_ItemUpdating"
                OnItemDataBound="lvStaffs_ItemDataBound"
                OnSorting="lvStaffs_Sorting"
                OnItemCommand="lvStaffs_ItemCommand"
                OnPagePropertiesChanged="lvStaffs_PagePropertiesChanged"
                DataKeyNames="AdminId"
                ID="lvStaffs" runat="server">
                <layouttemplate>
                    <table id="data-table" style="width: 100%; text-align: center;">
                        <thead>
                            <tr class="data-table-head">
                                <th class="active">
                                    <asp:LinkButton ID="lbId" runat="server" CommandName="Sort" CommandArgument="AdminId">
                                        ID
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbName" runat="server" CommandName="Sort" CommandArgument="AdminName">
                                        Name
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbUsername" runat="server" CommandName="Sort" CommandArgument="AdminUsername">
                                        Username
                                      <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbRole" runat="server" CommandName="Sort" CommandArgument="AdminRole">
                                        Role
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbEmail" runat="server" CommandName="Sort" CommandArgument="AdminEmail">
                                        Email
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbPhoneNo" runat="server" CommandName="Sort" CommandArgument="AdminPhoneNo">
                                        Phone No
                                     <i class="fa-solid fa-arrow-up"></i>
                                    </asp:LinkButton>
                                </th>
                                <th>
                                    <asp:LinkButton ID="lbStatus" runat="server" CommandName="Sort" CommandArgument="AdminStatus">
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

                </layouttemplate>
                <itemtemplate>
                    <tr>
                        <td><%# Eval("AdminId") %></td>
                        <td><%# Eval("AdminName") %></td>
                        <td><%# Eval("AdminUsername") %></td>
                        <td><%# Eval("AdminRole") %></td>
                        <td><%# Eval("AdminEmail") %></td>
                        <td><%# Eval("AdminPhoneNo") %></td>
                        <td><span runat="server" id="userStatus" class="user-status"><%# Eval("AdminStatus") %></span></td>
                        <td>
                            <asp:LinkButton ID="lbEdit" runat="server" CssClass="button" CommandName="Edit">
                                <i class="fa-regular fa-pen-to-square"></i>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </itemtemplate>
                <insertitemtemplate>
                    <tr class="bg-green-100">
                        <td>
                            <asp:Label ID="lblNewAdminId" runat="server" Text="-"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-28 px-2" ID="txtAddAdminName" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-28 px-2" ID="txtAddAdminUsername" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList CssClass="px-2" ID="ddlAddRole" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-28 px-2" ID="txtAddAdminEmail" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-28 px-2" ID="txtAddAdminPhoneNo" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList CssClass="px-2" ID="ddlAddStatus" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button UseSubmitBehavior="false" CssClass="button bg-green-500" ID="btnAdd" runat="server" Text="Add"
                               
                                CommandName="Insert" />
                            <asp:Button UseSubmitBehavior="false" ID="btnCancel" CssClass="button bg-red-500 mt-2"
                                runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                    </tr>
                </insertitemtemplate>
                <edititemtemplate>
                    <tr class="bg-amber-100">
                        <td>
                            <asp:Label ID="lblAdminId" runat="server" Text='<%# Eval("AdminId") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-28 px-2" ID="txtEditAdminName" runat="server" Text='<%# Eval("AdminName") %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-28 px-2" ID="txtEditAdminUsername" runat="server" Text='<%# Eval("AdminUsername") %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList CssClass="px-2" ID="ddlEditRole" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-28 px-2" ID="txtEditAdminEmail" runat="server" Text='<%# Eval("AdminEmail") %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox CssClass="w-28 px-2" ID="txtEditAdminPhoneNo" runat="server" Text='<%# Eval("AdminPhoneNo") %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:DropDownList CssClass="px-2" ID="ddlEditStatus" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button UseSubmitBehavior="false" CssClass="button bg-green-500" ID="btnUpdate" runat="server" Text="Update" CommandName="Update" />
                            <asp:Button UseSubmitBehavior="false" ID="btnCancel" CssClass="button bg-red-500 mt-2" runat="server" CommandName="Cancel" Text="Cancel" />
                        </td>
                    </tr>
                </edititemtemplate>
            </asp:ListView>

            <!--Pagination-->
            <asp:DataPager ID="dpBottomStaffs" class="pagination" runat="server" PageSize="10" PagedControlID="lvStaffs">
                <fields>
                    <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="False" ShowNextPageButton="False" ShowPreviousPageButton="True" PreviousPageText="<" />
                    <asp:NumericPagerField CurrentPageLabelCssClass="active" ButtonCount="10" />
                    <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="False" ShowNextPageButton="True" ShowPreviousPageButton="False" NextPageText=">" />
                </fields>
            </asp:DataPager>

        </div>
    </div>

    <script>

</script>

</asp:Content>
