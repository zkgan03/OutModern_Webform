<%@ Page Title="" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="OutModern.src.Client.Home.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="css/Home.css" rel="stylesheet" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!--main img-->
    <div class="level1">
        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/home-img/home2.jpg" />

        <div class="level1_content">
            <span class="level1_text">Make Your Outfit The Statement</span>
            <span class="level1_text2">ACCESSORIES</span>

            <div class="level1_content2">
                <asp:HyperLink ID="hl_shop_now" runat="server" class="level1HL" NavigateUrl="~/src/Client/Products/Products.aspx">Shop Now</asp:HyperLink>
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
            <asp:HyperLink ID="hl_1" runat="server" NavigateUrl="~/src/Client/Products/Products.aspx">
                <div class="cat-hoodie cat-box">
                    <asp:Image ID="Image2" runat="server" ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png" />
                </div>
                <span class="cat-name">Hoodies</span>
            </asp:HyperLink>

            <asp:HyperLink ID="hl_2" runat="server" NavigateUrl="~/src/Client/Products/Products.aspx">
                <div class="cat-sweater cat-box">
                    <asp:Image ID="Image3" runat="server" ImageUrl="~/images/product-img/sweater/beige-Sweater/mens-long-sleeve-shirt-sand-front-60e812b79d219.png" />
                </div>
                <span class="cat-name">Sweaters</span>
            </asp:HyperLink>

        </div>

        <div class="cat-col2">
            <asp:HyperLink ID="hl_3" runat="server" NavigateUrl="~/src/Client/Products/Products.aspx">
                <div class="cat-tee cat-box">
                    <asp:Image ID="Image4" runat="server" ImageUrl="~/images/product-img/teeShirt/beige-Tee/adult-quality-tee-light-beige-front-2-60e814c22cf48.png" />
                </div>
                <span class="cat-name">Tee Shirts</span>
            </asp:HyperLink>
        </div>

    </div>

    <div class="cat-container">
        <div class="cat-col2">
            <asp:HyperLink ID="hl_4" runat="server" NavigateUrl="~/src/Client/Products/Products.aspx">
                <div class="cat-accessories cat-box">
                    <asp:Image ID="Image5" runat="server" ImageUrl="~/images/product-img/accessories/all-over-print-premium-face-mask-white-front-610f63226db7f.png" />
                </div>
                <span class="cat-name">Accessories</span>
            </asp:HyperLink>
        </div>

        <div class="cat-col1">
            <asp:HyperLink ID="hl_5" runat="server" NavigateUrl="~/src/Client/Products/Products.aspx">
                <div class="cat-SnP cat-box">
                    <asp:Image ID="Image6" runat="server" ImageUrl="~/images/product-img/shorts/black-Short/mens-fleece-shorts-black-front-611920673f190.png" />
                </div>
                <span class="cat-name">Shorts and Pants</span>
            </asp:HyperLink>

            <asp:HyperLink ID="hl_6" runat="server" NavigateUrl="~/src/Client/Products/Products.aspx">
                <div class="cat-trousers cat-box">
                    <asp:Image ID="Image7" runat="server" ImageUrl="~/images/product-img/trousers/black-Trousers/all-over-print-mens-joggers-white-front-611e7b4cb3af6.png" />
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
                <asp:HyperLink ID="hl_explore" runat="server" class="btn_content2" NavigateUrl="~/src/Client/Products/Products.aspx">Explore More</asp:HyperLink>
            </div>
        </div>

        <div class="content2right">
            <asp:HyperLink ID="hl_img" runat="server" NavigateUrl="~/src/Client/Products/Products.aspx">
                <asp:Image ID="Image8" runat="server" ImageUrl="~/images/product-img/hoodies/black-Hoodie/unisex-champion-tie-dye-hoodie-black-front-2-6116819deddd3.png" />
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
                <asp:HyperLink ID="hl_new1" runat="server" NavigateUrl="~/src/Client/Products/Products.aspx">
                    <asp:Image ID="Image9" runat="server" class="productImg" ImageUrl="~/images/product-img/accessories/bucket-hat-i-big-accessories-b3-black-front-60e71fa93e72b.png" />
                </asp:HyperLink>

                <div class="productInfo">
                    <span class="productTxt">OutModern Hat</span>
                </div>
            </div>

            <div class="sections-inner">
                <asp:HyperLink ID="hl_new2" runat="server" NavigateUrl="~/src/Client/Products/Products.aspx">
                    <asp:Image ID="Image10" runat="server" class="productImg" ImageUrl="~/images/product-img/shorts/black-Short/mens-fleece-shorts-black-front-611920673f190.png" />
                </asp:HyperLink>

                <div class="productInfo">
                    <span class="productTxt">OutModern Black Short</span>
                </div>
            </div>

            <div class="sections-inner">
                <asp:HyperLink ID="hl_new3" runat="server" NavigateUrl="~/src/Client/Products/Products.aspx">
                    <asp:Image ID="Image11" runat="server" class="productImg" ImageUrl="~/images/product-img/hoodies/lightGray-Hoodie/unisex-premium-hoodie-carbon-grey-front-61167fab1b5c3.png" />
                </asp:HyperLink>

                <div class="productInfo">
                    <span class="productTxt">OutModern Premium Hoodie</span>
                </div>
            </div>



        </div>

        <div id="orderModal" class="modal z-10 fixed inset-0 flex hidden items-center justify-center overflow-y-auto">
            <div class="modal-overlay absolute h-full w-full bg-gray-900 opacity-50"></div>
            <div class="modal-container -translate-x-1/2 -translate-y-1/2 w-[30%] fixed left-1/2 top-1/2 w-1/3 transform rounded-lg bg-white p-6 shadow-lg">
                <div class="mb-4 flex justify-center text-4xl">
                    <asp:Image ID="Image12" ImageUrl="~/images/tick-mark.png" CssClass="h-[30%] w-[30%] ml-4" runat="server" />
                </div>

                <div class="flex flex-col items-center justify-center px-8">
                    <h2 class="mb-2 text-center text-2xl font-bold">Your order is confirmed</h2>
                    <p class="mb-6 text-center text-gray-600">Thanks for shopping! Your order hasn't shipped yet, but we will send you an email when it's done.</p>
                </div>


                <div class="modal-buttons flex flex-col justify-center">
                    <asp:Button ID="BtnViewOrder" runat="server" Text="View Order" CssClass="bg-[#131118] mb-2 w-full cursor-pointer rounded-xl px-4 py-2 font-semibold text-white hover:bg-white hover:text-black hover:border hover:border-black" OnClick="BtnViewOrder_Click" />
                    <asp:Button ID="ButtonHome" runat="server" Text="Back to Home" CssClass="w-full cursor-pointer rounded-xl border border-black bg-white px-4 py-2 font-semibold text-black hover:bg-black hover:text-white" OnClick="ButtonHome_Click" />
                </div>
            </div>
        </div>
    </div>


    <script>

        // Check for the status parameter in the URL
        var urlParams = new URLSearchParams(window.location.search);

        if (urlParams.get('status') === 'success') {
            var modal = document.getElementById("orderModal");
            modal.classList.remove('hidden');
        }

    </script>
</asp:Content>
