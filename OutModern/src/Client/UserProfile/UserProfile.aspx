<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="OutModern.src.Client.Profile.UserProfile" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head" runat="server">
    <link href="css/UserProfile.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="containColumn">
        <div class="columns-containColumn">
            <!-- left column-->
            <div class="column1">
                <div class="sectionLeft">
                    <div class="leftBox">
                        <asp:Image ID="img_profile" runat="server" class="imgProfile" ImageUrl="~/images/login-img/login-background13.jpg" />
                    </div>

                    <div class="rightBox">
                        <asp:Label ID="lbl_username" runat="server" class="username" Text="Prochorus"></asp:Label>
                    </div>

                    <div class="borderLine"></div>

                    <div class="boxBottom">

                        <asp:Button ID="btn_togo_profile" runat="server" class="button" Text="My Profile" OnClick="btn_togo_profile_Click" />
                        <asp:Button ID="btn_togo_my_order" runat="server" class="button" Text="My Order" OnClick="btn_togo_my_order_Click" />

                    </div>

                </div>
            </div>

            <!-- right column-->
            <div class="column2">

                <!--Profile-->
                <div class="section1" id="profile-section">

                    <div class="topBox">
                        <div class="titleBox">
                            <span class="title">My Profile</span>
                        </div>

                    </div>

                    <div class="borderLine"></div>

                    <div class="bigBox">
                        <div class="boxItem">
                            <span class="labelData">Username</span>
                            <asp:Label ID="lbl_up_username" runat="server" Text="Prochoros" class="data"></asp:Label>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Fullname</span>
                            <asp:Label ID="lbl_up_fullname" runat="server" Text="Prochoros Robert" class="data"></asp:Label>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Email</span>
                            <asp:Label ID="lbl_up_email" runat="server" Text="Prochoros@gmail.com" class="data"></asp:Label>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Phone Number</span>
                            <asp:Label ID="lbl_up_phoneNumber" runat="server" Text="0123456789" class="data"></asp:Label>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Address Name</span>
                            <asp:Label ID="lbl_addressName" runat="server" Text="Home" class="data"></asp:Label>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Address</span>
                            <asp:Label ID="lbl_addressLine" runat="server" Text="67, Jln Madrasah, Gombak Setia, 53100 Kuala Lumpur, Selangor" class="data"></asp:Label>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Country</span>
                            <asp:Label ID="lbl_country" runat="server" Text="Malaysia" class="data"></asp:Label>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">State</span>
                            <asp:Label ID="lbl_state" runat="server" Text="Kuala Lumpur" class="data"></asp:Label>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Postal Code</span>
                            <asp:Label ID="lbl_postaCode" runat="server" Text="53100" class="data"></asp:Label>
                        </div>
                    </div>

                    <div class="EPBoxButton">
                        <asp:Button ID="btn_edit_profile" runat="server" class="EPButton" Text="Edit Profile" CssClass="bg-black hover:bg-gray-700" Style="width: 50%; margin-top: 50px; padding: 0.50rem 1rem; font-family: sans-serif; font-weight: bold; border: 1px solid #f5f5f5; cursor: pointer; color: whitesmoke; border-radius: 30px;"
                            OnClick="btn_edit_profile_Click" />
                    </div>


                </div>

                <div class="delectAccount">
                    <asp:Button ID="btn_dlt_acc" runat="server" class="EPButton1" Text="Delete Account" CssClass="bg-black hover:bg-red-500" Style="float: right; width: 20%; margin-top: 0px; margin-bottom: 40px; margin-right: 210px; padding: 0.50rem 1rem; font-family: sans-serif; font-weight: bold; border: 1px solid #f5f5f5; cursor: pointer; color: whitesmoke; border-radius: 10px;" />
                </div>

            </div>
        </div>
    </div>

</asp:Content>

