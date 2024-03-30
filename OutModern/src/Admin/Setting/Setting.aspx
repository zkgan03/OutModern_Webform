<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="Setting.aspx.cs" Inherits="OutModern.src.Admin.Setting.Setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        /*Edit form*/
        #edit-form {
        }

            #edit-form .edit-section {
                @apply mt-2 ml-2;
            }

            #edit-form .edit-label {
                @apply font-[600];
            }

            #edit-form .edit-item {
                @apply block px-4 py-1 border border-gray-600 rounded w-56;
            }

                #edit-form .edit-item.disabled {
                    @apply text-gray-400 border-gray-300;
                }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mt-2 flex gap-5">

        <!-- my Info -->
        <div id="edit-form" class="mt-4 w-fit border border-gray-700 rounded  p-4 relative">

            <div class="absolute top-2 right-2">
                <asp:LinkButton CssClass="button bg-green-500" ID="lbUpdateInfo" runat="server">Update</asp:LinkButton>
            </div>

            <div class="text-2xl mt-5 font-[600]">
                General Info
            </div>

            <div class="">
                <!--u ID-->
                <div class="edit-section">
                    <div class="edit-label">Your ID</div>
                    <div>
                        <asp:Label ID="lblId" CssClass="edit-item disabled" runat="server" Text="S12"></asp:Label>
                    </div>
                </div>

                <!--u NAme-->
                <div class="edit-section">
                    <div class="edit-label">Your FullName</div>
                    <div>
                        <asp:TextBox ID="txtFName" CssClass="edit-item" runat="server" Text="Gan"></asp:TextBox>
                    </div>
                </div>

                <!--u Username-->
                <div class="edit-section">
                    <div class="edit-label">Your Username</div>
                    <div>
                        <asp:TextBox ID="txtUsername" CssClass="edit-item" runat="server" Text="cus123"></asp:TextBox>
                    </div>
                </div>

                <!-- u Email -->
                <div class="edit-section">
                    <div class="edit-label">Email</div>
                    <div>
                        <asp:TextBox ID="txtPrice" CssClass="edit-item" runat="server" Text="cus123@mail.com"></asp:TextBox>
                    </div>
                </div>

                <!-- u Phone Num -->
                <div class="edit-section">
                    <div class="edit-label">Phone No</div>
                    <div>
                        <asp:TextBox ID="txtPhoneNo" CssClass="edit-item" runat="server" Text="012-1234567"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>

        <!-- change password-->
        <div class="mt-4 w-fit  border border-gray-700 rounded p-4 relative">

            <div class="absolute top-2 right-2">
                <asp:LinkButton ID="lbUpdatePassword" CssClass="button bg-green-500" runat="server">Change</asp:LinkButton>
            </div>
            <div class="font-[600] text-xl mt-5">
                Change Password
            </div>

            <div class="px-2">
                <!--current Pass-->
                <div class="mt-2">
                    <div class="edit-label">Current Password</div>
                    <div>
                        <asp:TextBox ID="txtCurrPass" CssClass="px-2" TextMode="Password" runat="server" Text=""></asp:TextBox>
                    </div>
                </div>

                <!--New Pass-->
                <div class="edit-section">
                    <div class="edit-label">New Password</div>
                    <div>
                        <asp:TextBox ID="Textbox1" CssClass="px-2" TextMode="Password" runat="server" Text=""></asp:TextBox>
                    </div>
                </div>

                <!--Repeat Pass-->
                <div class="edit-section">
                    <div class="edit-label">Repeat Password</div>
                    <div>
                        <asp:TextBox ID="Textbox2" CssClass="px-2" TextMode="Password" runat="server" Text=""></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
