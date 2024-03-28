<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="EditUserProfile.aspx.cs" Inherits="OutModern.src.Client.UserProfile.EditUserProfile" %>

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

                <!--Edit Profile-->
                <div class="section_edit">

                    <div class="topBox">
                        <div class="titleBox">
                            <span class="title">My Profile</span>
                        </div>

                        <div class="titleBox2">
                            <asp:HyperLink ID="hl_back_to_user_profile" runat="server" NavigateUrl="~/src/Client/UserProfile/UserProfile.aspx">Back ></asp:HyperLink>
                        </div>

                    </div>

                    <div class="borderLine"></div>

                    <div class="bigBox">
                        <div class="boxItem">
                            <span class="labelData">Username</span>
                            <asp:TextBox ID="txt_edit_username" runat="server" value="Prochoros" class="edit_data"></asp:TextBox>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Fullname</span>
                            <asp:TextBox ID="txt_edit_fullname" runat="server" value="Prochoros Robert" class="edit_data"></asp:TextBox>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Email</span>
                            <asp:TextBox ID="txt_edit_email" runat="server" value="Prochoros@gmail.com" class="edit_data" TextMode="Email"></asp:TextBox>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Phone Number</span>
                            <asp:TextBox ID="txt_edit_phone_number" runat="server" value="0123456789" class="edit_data" TextMode="Phone"></asp:TextBox>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Address</span>
                            <asp:TextBox ID="txt_edit_address" runat="server" value="Address: 67, Jln Madrasah, Gombak Setia, 53100 Kuala Lumpur, Selangor" class="edit_data"></asp:TextBox>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Password</span>
                            <asp:TextBox ID="txt_edit_password" runat="server" class="edit_data" value="0123456789" TextMode="Password"></asp:TextBox>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Reset Password</span>
                            <asp:TextBox ID="txt_edit_reset_password" runat="server" class="edit_data" TextMode="Password"></asp:TextBox>
                        </div>

                    </div>


                    <div class="EPBoxButton">
                        <asp:Button ID="btn_save" runat="server" class="EPButton" Text="Save" OnClick="btn_save_Click" Style="background-color: black; border-radius: 30px;" />
                    </div>


                </div>
            </div>
        </div>
    </div>
</asp:Content>
