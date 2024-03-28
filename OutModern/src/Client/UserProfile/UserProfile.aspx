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
                <div class="section" id="profile-section">

                    <div class="topBox">
                        <div class="titleBox">
                            <span class="title">My Profile</span>
                        </div>

                    </div>

                    <div class="borderLine"></div>

                    <div class="bigBox">
                        <div class="boxItem">
                            <span class="labelData">Username</span>
                            <span class="data">Prochoros</span>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Fullname</span>
                            <span class="data">Prochoros Robert</span>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Email</span>
                            <span class="data">Prochoros@gmail.com</span>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Phone Number</span>
                            <span class="data">0123456789</span>
                        </div>

                        <div class="boxItem">
                            <span class="labelData">Address</span>
                            <span class="data">Address: 67, Jln Madrasah, Gombak Setia, 53100 Kuala Lumpur, Selangor</span>
                        </div>

                    </div>


                    <div class="EPBoxButton">
                        <asp:Button ID="btn_edit_profile" runat="server" class="EPButton" Text="Edit Profile" Style="background-color: black; border-radius: 30px;" OnClick="btn_edit_profile_Click" />
                    </div>


                </div>
            </div>
        </div>
    </div>

</asp:Content>

