<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="StaffDetails.aspx.cs" Inherits="OutModern.src.Admin.StaffDetails.StaffDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        @layer components {
            #staffDetails > div {
                @apply odd:bg-gray-50 even:bg-gray-100 p-2 rounded;
            }

            .desc-title {
                @apply inline-block w-28 float-left;
            }
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--Edit product btn-->
    <div>
        <asp:HyperLink CssClass="inline-block text-white p-2 rounded bg-amber-500 hover:opacity-50" ID="HyperLink1" runat="server" NavigateUrl='<%#urls[StaffEdit] %>'>
          <i class="fa-regular fa-pen-to-square"></i>
          Edit Staff
        </asp:HyperLink>
    </div>

    <!-- Products Desc -->
    <div class="flex mt-8">
        <!-- staff details-->
        <div>
            <div class="text-[1.5rem] font-bold">Staff Details</div>
            <div id="staffDetails" class="mt-2 ml-2 text-xl rounded border">
                <div>
                    <span class="desc-title">Staff ID</span>
                    <span>:
                          <asp:Label ID="lblStaffId" runat="server" Text="S1001"></asp:Label></span>
                </div>
                <div>
                    <span class="desc-title">Username</span>
                    <span>:
                        <asp:Label ID="lblStaffUsername" runat="server" Text="zhikengan"></asp:Label></span>
                </div>
                <div>
                    <span class="desc-title">Role</span>
                    <span>:
                        <asp:Label ID="lblRole" runat="server" Text="Admin"></asp:Label></span>
                </div>
                <div>
                    <span class="desc-title">Name</span>
                    <span>:
                          <asp:Label ID="lblStaffName" runat="server" Text="Gan Zhi Ken"></asp:Label></span>
                </div>
                <div>
                    <span class="desc-title">Email</span>
                    <span>:
                          <asp:Label ID="lblEmail" runat="server" Text="ganzk-wm21@student.tarc.edu.my"></asp:Label></span>
                </div>
                <div>
                    <span class="desc-title">Tel</span>
                    <span>:
                          <asp:Label ID="lblTel" runat="server" Text="0101234567"></asp:Label></span>
                </div>
                <div>
                    <span class="desc-title">Address</span>
                    <span>:
                          <asp:Label ID="lblAddress" runat="server" Text="34, Jalan Mewah"></asp:Label></span>
                </div>
                <div>
                    <span class="desc-title">Status</span>
                    <span>:
                          <asp:Label ID="lblStatus" runat="server" Text="Active"></asp:Label></span>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
