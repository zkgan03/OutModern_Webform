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
            <div class="flex justify-center items-center flex-col w-full">

                <div class="self-start m-4">
                <span id="ContentPlaceHolder1_SiteMapPath1" class="">
                    <a href="#ContentPlaceHolder1_SiteMapPath1_SkipLink" style="position: absolute; left: -10000px; top: auto; width: 1px; height: 1px; overflow: hidden;">Skip Navigation Links
                    </a>
                    <span>
                        <a></a>
                    </span><span>&gt; 
                    </span><span>
                        <span title="User Profile">Profile
                        </span></span></span>

                </div>

                    <div class="column2A">
                        <!--Profile-->
                        <div class="section1" id="profile-section">

                            <div class="topBox">
                                <div class="titleBox">
                                    <span class="title">My Profile</span>
                                </div>

                            </div>

                            <asp:Label ID="lbl_custId" runat="server" Visible="false"></asp:Label>

                            <div class="borderLine"></div>

                            <div class="bigBox">
                                <div class="boxItem">
                                    <span class="labelData">Username</span>
                                    <asp:Label ID="lbl_up_username" runat="server" class="data"></asp:Label>
                                </div>

                                <div class="boxItem">
                                    <span class="labelData">Fullname</span>
                                    <asp:Label ID="lbl_up_fullname" runat="server" class="data"></asp:Label>
                                </div>

                                <div class="boxItem">
                                    <span class="labelData">Email</span>
                                    <asp:Label ID="lbl_up_email" runat="server" class="data"></asp:Label>
                                </div>

                                <div class="boxItem">
                                    <span class="labelData">Phone Number</span>
                                    <asp:Label ID="lbl_up_phoneNumber" runat="server" class="data"></asp:Label>
                                </div>

                                <div class="boxItem">
                                    <span class="labelData">Address Name</span>
                                    <asp:DropDownList ID="ddl_address_name" runat="server" class="ddl_address" DataSourceID="SqlDataSource1" AutoPostBack="True" DataTextField="AddressName" DataValueField="AddressName"></asp:DropDownList>
                                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [AddressName] FROM [Address] WHERE ([CustomerId] = @CustomerId)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lbl_custId" Name="CustomerId" PropertyName="Text" Type="Int32" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>

                                <div class="boxItem">
                                    <span class="labelData">Address</span>
                                    <asp:Label ID="lbl_addressLine" runat="server" class="data"></asp:Label>
                                </div>

                                <div class="boxItem">
                                    <span class="labelData">Country</span>
                                    <asp:Label ID="lbl_country" runat="server" class="data"></asp:Label>
                                </div>

                                <div class="boxItem">
                                    <span class="labelData">State</span>
                                    <asp:Label ID="lbl_state" runat="server" class="data"></asp:Label>
                                </div>

                                <div class="boxItem">
                                    <span class="labelData">Postal Code</span>
                                    <asp:Label ID="lbl_postaCode" runat="server" class="data"></asp:Label>
                                </div>
                            </div>

                            <div class="EPBoxButton">
                                <asp:Button ID="btn_edit_profile" runat="server" class="EPButton" Text="Edit Profile" CssClass="bg-black hover:bg-gray-700" Style="border-radius: 2rem; width: 50%; margin-top: 5vh; padding: 0.5rem 1rem; font-weight: bold; border: 1px solid #f5f5f5; cursor: pointer; color: whitesmoke;"
                                    OnClick="btn_edit_profile_Click" />
                            </div>

                        </div>

                        <div class="delectAccount">
                            <asp:Button ID="btn_dlt_acc" runat="server" class="EPButton1" Text="Delete Account" CssClass="bg-black hover:bg-red-500" Style="float: right; width: 20%; margin-top: 1vh; margin-bottom: 4vh; padding: 0.5rem 1rem; font-weight: bold; border: 1px solid #f5f5f5; cursor: pointer; color: whitesmoke; border-radius: 1rem;" OnClick="btn_dlt_acc_Click" />
                        </div>
                    </div>
            </div>

        </div>
    </div>

</asp:Content>

