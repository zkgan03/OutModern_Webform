<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="OutModern.src.Client.Home.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>OutModern | Home</title>

    <!-- import font type css-->
    <link href="<%=Page.ResolveClientUrl("~/lib/fonts/ChakraPetch/ChakraPetch.css") %>" rel="stylesheet" />

    <!-- import fontawesome css-->
    <link href="<%= Page.ResolveClientUrl("~/lib/fontawesome/css/all.min.css") %>" rel="stylesheet" />

    <link href="css/Home.css" rel="stylesheet" />

    <!-- import tailwind js-->
    <script src="<%= Page.ResolveClientUrl("~/lib/tailwind/tailwind.js") %>"></script>
</head>
<body>
    <form id="form1" runat="server">

        <!--main img-->
        <div class="level1">
            <asp:Image ID="home_img1" runat="server" ImageUrl="~/images/home-img/home2.jpg" />

            <div class="level1_content">
                <span class="level1_text">Make Your Outfit The Statement</span>
                <span class="level1_text2">ACCESSORIES</span>

                <div class="level1_content2">
                    <asp:HyperLink ID="hl_level1_shopnow" runat="server" class="level1HL">Shop Now</asp:HyperLink>
                </div>

            </div>
        </div>

        <!--Content-->
        <div class="level2">
            <span class="level2_text">Browse The Range</span>
            <span class="level2_text2">Discover your style in our curated collections.</span>
        </div>

        <div class="cat-container">
            <div class="cat-col1">
                <asp:HyperLink ID="hl_hoodies" runat="server">
                    <div class="cat-hoodie cat-box">
                        <asp:Image ID="img_hoodies" runat="server" ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png" />
                    </div>
                    <span class="cat-name">Hoodies</span>
                </asp:HyperLink>

                <asp:HyperLink ID="hl_sweaters" runat="server">
                    <div class="cat-sweater cat-box">
                        <asp:Image ID="img_sweaters" runat="server" ImageUrl="~/images/product-img/sweater/beige-Sweater/mens-long-sleeve-shirt-sand-front-60e812b79d219.png" />
                    </div>
                    <span class="cat-name">Sweaters</span>
                </asp:HyperLink>

            </div>

            <div class="cat-col2">
                <asp:HyperLink ID="hl_teeshirts" runat="server">
                    <div class="cat-tee cat-box">
                        <asp:Image ID="img_teeshirts" runat="server" ImageUrl="~/images/product-img/teeShirt/beige-Tee/adult-quality-tee-light-beige-front-2-60e814c22cf48.png" />
                    </div>
                    <span class="cat-name">Tee Shirts</span>
                </asp:HyperLink>
            </div>

        </div>

        <div class="cat-container">
            <div class="cat-col2">
                <asp:HyperLink ID="hl_accessories" runat="server">
                    <div class="cat-accessories cat-box">
                        <asp:Image ID="img_accessories" runat="server" ImageUrl="~/images/product-img/accessories/all-over-print-premium-face-mask-white-front-610f63226db7f.png" />
                    </div>
                    <span class="cat-name">Accessories</span>
                </asp:HyperLink>
            </div>

            <div class="cat-col1">
                <asp:HyperLink ID="hl_shortsandpant" runat="server">
                    <div class="cat-SnP cat-box">
                        <asp:Image ID="img_shortsandpants" runat="server" ImageUrl="~/images/product-img/shorts/black-Short/mens-fleece-shorts-black-front-611920673f190.png" />
                    </div>
                    <span class="cat-name">Shorts and Pants</span>
                </asp:HyperLink>

                <asp:HyperLink ID="hl_trousers" runat="server">
                    <div class="cat-trousers cat-box">
                        <asp:Image ID="img_trousers" runat="server" ImageUrl="~/images/product-img/trousers/black-Trousers/all-over-print-mens-joggers-white-front-611e7b4cb3af6.png" />
                    </div>
                    <span class="cat-name">Trousers</span>
                </asp:HyperLink>
            </div>
        </div>

        <!--Content 2-->
        <div class="content2">
            <div class="content2left">
                <div class="content2center">
                    <span class="content2text">+50 Product Trending Now</span>
                    <span class="content2text2">"From essential everyday basics to bold, standout statement pieces, our extensive range offers a myriad of options catered to your unique style preferences. Explore our collection and make your choice confidently, knowing that there's something perfect for every occasion and taste."</span>
                    <asp:HyperLink ID="hl_explore_more" runat="server" class="btn_content2">Explore More</asp:HyperLink>
                </div>
            </div>

            <div class="content2right">
                <asp:HyperLink ID="hl_content2_img" runat="server">
                        <asp:Image ID="img_content2" runat="server" ImageUrl="~/images/product-img/hoodies/black-Hoodie/unisex-champion-tie-dye-hoodie-black-front-2-6116819deddd3.png" />
                </asp:HyperLink>
            </div>

        </div>

        <!--Content 3-->

        <div class="section-container">
            <div class="button-bar">
                <span class="content2Text">New Arrivals</span>
                <span class="content2Text2">From casual to formal, we have something for everyone.</span>
            </div>

            <div id="New Arrivals" class="fading sections">
                <div class="sections-inner">
                    <asp:HyperLink ID="hl_new_arrival_1" runat="server">
                        <asp:Image ID="img_new_arrival_1" runat="server" class="productImg" ImageUrl="~/images/product-img/accessories/bucket-hat-i-big-accessories-b3-black-front-60e71fa93e72b.png" />
                    </asp:HyperLink>

                    <div class="productInfo">
                        <span class="productTxt">OutModern Hat</span>
                    </div>
                </div>

                <div class="sections-inner">
                    <asp:HyperLink ID="hl_new_arrival_2" runat="server">
                        <asp:Image ID="img_new_arrival_2" runat="server" class="productImg" ImageUrl="~/images/product-img/shorts/black-Short/mens-fleece-shorts-black-front-611920673f190.png" />
                    </asp:HyperLink>

                    <div class="productInfo">
                        <span class="productTxt">OutModern Black Short</span>
                    </div>
                </div>

                <div class="sections-inner">
                    <asp:HyperLink ID="hl_new_arrival_3" runat="server">
                        <asp:Image ID="img_new_arrival_3" runat="server" class="productImg" ImageUrl="~/images/product-img/hoodies/lightGray-Hoodie/unisex-premium-hoodie-carbon-grey-front-61167fab1b5c3.png" />
                    </asp:HyperLink>

                    <div class="productInfo">
                        <span class="productTxt">OutModern Premium Hoodie</span>
                    </div>
                </div>



            </div>
        </div>

    </form>
</body>
</html>
