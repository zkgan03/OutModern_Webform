<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="CustomerEdit.aspx.cs" Inherits="OutModern.src.Admin.CustomerEdit.CustomerEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        #cus-edit-form #edit-from-item > div {
            @apply mt-1;
        }

        .desc-title {
            @apply inline-block w-28 float-left;
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

        <!-- General Desc -->
        <div id="cus-edit-form" class="mt-8">

            <div class="text-2xl font-bold">
                Edit Customer
            </div>
            <div id="edit-from-item" class="mt-2 ml-2 text-xl">
                <div>
                    <span class="desc-title">Customer ID</span>
                    <span>:
                  <asp:Label ID="lblCustomerId" runat="server" Text="C1001"></asp:Label>
                    </span>
                </div>
                <div>
                    <span class="desc-title">FullName</span>
                    <span>:                        
                  <asp:TextBox ID="txtProdName" runat="server" Text="Customer A"></asp:TextBox>
                    </span>
                </div>
                <div>
                    <span class="desc-title">Username</span>
                    <span>:                        
                    <asp:TextBox ID="txtUsername" runat="server" Text="cus123"></asp:TextBox>
                    </span>
                </div>

                <div>
                    <span class="desc-title">Email </span>
                    <span>:                        
                        <asp:TextBox ID="txtEmail" runat="server" Text="cus123@mail.com"></asp:TextBox>
                    </span>
                </div>
                <div>
                    <span class="desc-title">Phone No</span>
                    <span>:                        
                  <asp:TextBox ID="txtPhoneNo" runat="server" Text="1231231231"></asp:TextBox>
                    </span>
                </div>
                <div>
                    <span class="desc-title">Address </span>
                    <span>:                     
                  <asp:TextBox ID="txtProdQuantity"
                      CssClass="resize-none w-72 h-32 leading-5 border border-black p-2 rounded"
                      TextMode="MultiLine" runat="server"
                      Text="Jalan mewah mewah, &#13;&#10; dawawd &#13;&#10;  awd  &#13;&#10; awdawd"></asp:TextBox>
                    </span>
                </div>
                <div>
                    <span class="desc-title">Status</span>
                    <span>:
                  <asp:DropDownList ID="ddlProdStatus" AppendDataBoundItems="true" runat="server">
                      <asp:ListItem>Activated</asp:ListItem>
                      <asp:ListItem>Locked</asp:ListItem>
                      <asp:ListItem>Deleted</asp:ListItem>
                  </asp:DropDownList>
                    </span>
                </div>

            </div>

            <div class="mt-20">
                <asp:Button ID="btnResetPassword"
                    OnClientClick="return confirm('Are you sure you want to reset Customer Password?')"
                    OnClick="btnResetPassword_Click"
                    CssClass="button text-black bg-gray-200 py-1" runat="server" Text="Reset Customer's Password" />
            </div>
        </div>

    </div>
</asp:Content>
