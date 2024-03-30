<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="CustomerEdit.aspx.cs" Inherits="OutModern.src.Admin.CustomerEdit.CustomerEdit" %>

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
    <div class="mt-2 mb-10">
        <div class="flex justify-between">
            <!--Discard change btn-->
            <asp:LinkButton
                OnClientClick="return confirm('Are you sure you want to discard? The changes will be lost');"
                CssClass="text-white p-2 rounded bg-red-500 hover:opacity-50"
                ID="lbDiscard" runat="server" OnClick="lbDiscard_Click">
            <i class="fa-regular fa-trash"></i>  
            Discard Change
            </asp:LinkButton>

            <!--Update btn-->
            <asp:LinkButton
                OnClientClick="return confirm('Are you sure you want to update?')"
                OnClick="lbUpdate_Click"
                CssClass="text-white p-2 rounded bg-green-500 hover:opacity-50"
                ID="lbUpdate" runat="server">
             <i class="fa-regular fa-pen-to-square"></i>
             Update
            </asp:LinkButton>
        </div>

        <!-- Cus Desc -->
        <div id="edit-form" class="flex mt-4 gap-40">
            <!--Left-->
            <div class="">
                <!--Customer ID-->
                <div class="edit-section">
                    <div class="edit-label">Customer ID</div>
                    <div>
                        <asp:Label ID="lblId" CssClass="edit-item disabled" runat="server" Text="C12"></asp:Label>
                    </div>
                </div>

                <!--Customer NAme-->
                <div class="edit-section">
                    <div class="edit-label">Customer FullName</div>
                    <div>
                        <asp:TextBox ID="txtFullName" CssClass="edit-item" runat="server" Text="CustomerA"></asp:TextBox>
                    </div>
                </div>

                <!--Customer Username-->
                <div class="edit-section">
                    <div class="edit-label">Username</div>
                    <div>
                        <asp:TextBox ID="txtUsername" CssClass="edit-item" runat="server" Text="cus123"></asp:TextBox>

                    </div>
                </div>


                <!--Customer Status-->
                <div class="edit-section">
                    <div class="edit-label">Status</div>
                    <div>
                        <asp:DropDownList ID="ddlStatus" CssClass="edit-item" runat="server">
                            <asp:ListItem>Activated</asp:ListItem>
                            <asp:ListItem>Locked</asp:ListItem>
                            <asp:ListItem>Deleted</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <!--Right-->
            <div>

                <!-- Customer Email -->
                <div class="edit-section">
                    <div class="edit-label">Email</div>
                    <div>
                        <asp:TextBox ID="txtPrice" CssClass="edit-item" runat="server" Text="cus123@mail.com"></asp:TextBox>
                    </div>
                </div>

                <!-- Customer Phone Num -->
                <div class="edit-section">
                    <div class="edit-label">Phone No</div>
                    <div>
                        <asp:TextBox ID="txtPhoneNo" CssClass="edit-item" runat="server" Text="012-1234567"></asp:TextBox>
                    </div>
                </div>
            </div>
        </div>

        <!--Customer Address-->
        <div class="mt-10 p-2">
            <div class="font-[600]">Addresses</div>

            <!--List of Addresses-->
            <div class="flex flex-wrap ml-2 gap-4">
                <asp:Repeater ID="rptAddresses" runat="server">
                    <ItemTemplate>
                        <div class="border border-gray-700 drop-shadow bg-white p-3">
                            <div>
                                <asp:Label CssClass="text-gray-500" ID="lblAddressName" runat="server"
                                    Text='<%# Eval("AddressName") %>'></asp:Label>
                            </div>
                            <!--Address Line-->
                            <div class="ml-2 mt-3">
                                <div>Address Line</div>
                                <div>
                                    <asp:TextBox ID="txtAddressLine" runat="server"
                                        Text='<%# Eval("AddressLine") %>'></asp:TextBox>
                                </div>
                            </div>

                            <!--Postal code and City-->
                            <div class="ml-2 mt-3 flex gap-4">
                                <div>
                                    <div>PostalCode</div>
                                    <div>
                                        <asp:TextBox ID="txtPostalCode" runat="server" CssClass="w-32"
                                            Text='<%# Eval("PostalCode") %>'></asp:TextBox>
                                    </div>
                                </div>
                                <div>
                                    <div>City</div>
                                    <div>
                                        <asp:TextBox ID="txtCity" runat="server" CssClass="w-32"
                                            Text='<%# Eval("City") %>'></asp:TextBox>
                                    </div>
                                </div>
                            </div>

                            <!--State and Country-->
                            <div class="ml-2 mt-3 flex gap-4">
                                <div>
                                    <div>State</div>
                                    <div>
                                        <asp:TextBox ID="txtState" runat="server" CssClass="w-32"
                                            Text='<%# Eval("State") %>'></asp:TextBox>
                                    </div>
                                </div>
                                <div>
                                    <div>Country</div>
                                    <div>
                                        <asp:TextBox ID="txtCountry" runat="server" CssClass="w-32"
                                            Text='<%# Eval("Country") %>'></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>

        <!--Reset Password-->
        <div class="mt-10">
            <asp:Button ID="btnResetPassword" CssClass="button bg-red-600" runat="server" Text="Reset Customer's Password" />
        </div>
    </div>
</asp:Content>
