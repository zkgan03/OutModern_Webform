<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Cancelled.aspx.cs" Inherits="OutModern.src.Client.UserProfile.Cancelled" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/MyOrder.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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

                <div class="boxRightTop">
                    <asp:Button ID="btn_to_ship" runat="server" Text="To Ship" class="btn_myOrder" OnClick="btn_to_ship_Click" />
                    <asp:Button ID="btn_to_receive" runat="server" Text="To Receive" class="btn_myOrder" OnClick="btn_to_receive_Click" />
                    <asp:Button ID="btn_completed" runat="server" Text="Completed" class="btn_myOrder" OnClick="btn_completed_Click" />
                    <asp:Button ID="btn_cancelled" runat="server" Text="Cancelled" class="btn_myOrder1" Style="background-color: black;" OnClick="btn_cancelled_Click" />
                </div>


                <!-- Repeater here-->
                <div class="boxRightBottom">


                    <div class="repeater_items">
                        <div class="box1">
                            <asp:Image ID="img_items" runat="server" ImageUrl="~/images/product-img/hoodies/black-Hoodie/unisex-heavy-blend-hoodie-black-front-60e815eedacd3.png" class="box2_product_img" />
                        </div>

                        <div class="box2">
                            <div class="box2small1">
                                <asp:Label ID="lbl_product_name" runat="server" Text="Unisex Heavy Hoodie" class="box2_product_name"></asp:Label>
                            </div>

                            <div class="box2small">
                                <asp:Label ID="lbl_product_colour" runat="server" Text="Colour: Black" class="box2_product_colour"></asp:Label>
                            </div>

                            <div class="box2small">
                                <asp:Label ID="lbl_product_size" runat="server" Text="Size: XL" class="box2_product_size"></asp:Label>
                            </div>

                            <div class="box2small">
                                <asp:Label ID="lbl_product_quantity" runat="server" Text="Quantity: 1" class="box2_product_quantity"></asp:Label>
                            </div>

                        </div>

                        <div class="box3">
                            <div class="box2small2">
                                <asp:Label ID="lbl_product_price" runat="server" Text="RM49.99" class="box2_product_price"></asp:Label>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>

    </div>

</asp:Content>
