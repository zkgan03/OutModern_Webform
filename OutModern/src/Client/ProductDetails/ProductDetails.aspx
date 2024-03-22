<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="OutModern.src.Client.NewFolder1.ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>/**/
    
        .colorChosen {
             box-shadow: 0 0 0 2px whitesmoke, 0 0 0 4px black;
        }
            
        .size-chart tbody > :nth-child(odd) {
            background-color: rgb(255, 255, 255);
        }

        .size-chart thead th {
            background-color: rgb(255, 220, 227);
            font-weight: bold;
            width: 12ch;
        }

        .size-chart tr :first-child {
            text-align: center;
            position: sticky;
            left: 0;
            background-color: rgb(255, 220, 227);
            width: 12ch;
            font-weight: bold;
        }

        .image-modal {
            display: none;
            position: fixed;
            z-index: 98;
            padding-top: 50px;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background-color: rgba(143, 143, 143, 0.8);
        }

        .image-modal-content {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            margin: auto;
            width: 80%;
            max-width: 700px;
        }

        .image-modal-content {
            -webkit-animation-name: zoom;
            -webkit-animation-duration: 0.6s;
            animation-name: zoom;
            animation-duration: 0.6s;
        }

        .close-modal {
            position: absolute;
            top: 15px;
            right: 35px;
            color: #f1f1f1;
            font-size: 60px;
            text-shadow: 0px 0px 5px rgb(0, 0, 0);
            transition: 0.1s;
            cursor: pointer;
        }

            .close-modal:hover,
            .close-modal:active {
                color: whitesmoke;
                text-shadow: 0px 0px 10px black;
            }

        .opacity,
        .hover-opacity:hover {
            opacity: 0.6;
        }

        .opacity-off,
        .hover-opacity-off:hover {
            opacity: 1;
        }

        .column img {
            background-color: rgba(211, 211, 211, 0.5);
            border: 2px solid rgb(138, 138, 138);
            border-radius: 5px;
        }

        .opacity.hover-opacity-off.opacity-off {
            border: 2px solid #000;
            border-radius: 5px;
        }
        .color_grp input[type="radio"]:checked + label {
              box-shadow: 0 0 0 2px whitesmoke, 0 0 0 4px black;
        }
    </style>
    <script src="<%= Page.ResolveClientUrl("product-details.js") %>"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="flex flex-col mx-auto w-full p-30 md:p-15 mt-14">
        <div class="flex">
            <div class="w-2/5 flex justify-center flex-wrap items-center ml-10">
                <div class="w-4/5 min-w-[320px]">
                    <div id="myModal" class="image-modal">
                        <span class="close-modal">&times;</span>
                        <img class="image-modal-content" id="modal-img">
                    </div>
                    <div class="max-w-7xl relative bg-opacity-50 bg-gray-300" style="max-width: 1200px">
                        <img id="productImg" class="slides"
                            src="../../../images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png"
                            style="width: 100%; cursor: pointer">
                        <img id="productImg" class="slides"
                            src="../../../images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-zoomed-in-61167de6440a2.png"
                            style="width: 100%; display: none; cursor: pointer">
                        <img id="productImg" class="slides"
                            src="../../../images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de644282.png"
                            style="width: 100%; display: none; cursor: pointer">
                        <img class="absolute top-2 right-2 pointer-events-none" src="../../../images/product-img/zoom-in.png" alt="Zoom In">
                        <a class="cursor-pointer absolute top-1/2 px-4 py-2 mt-[-22px] text-white font-bold text-lg transition duration-300 select-none bg-black left-0 rounded-r-lg" onclick="plusSlides(-1)">&#10094;</a>
                        <a class="cursor-pointer absolute top-1/2 px-4 py-2 mt-[-22px] text-white font-bold text-lg transition duration-300 select-none bg-black right-0 rounded-r-lg" onclick="plusSlides(1)">&#10095;</a>

                        <div class="px-2 mt-4 mb-4">
                            <div class="px-2 float-left w-1/3">
                                <img class="demo opacity hover-opacity-off"
                                    src="../../../images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png"
                                    style="width: 100%; cursor: pointer" onclick="currentDiv(1)">
                            </div>
                            <div class="px-2 float-left w-1/3">
                                <img class="demo opacity hover-opacity-off"
                                    src="../../../images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-zoomed-in-61167de6440a2.png"
                                    style="width: 100%; cursor: pointer" onclick="currentDiv(2)">
                            </div>

                            <div class="px-2 float-left w-1/3">
                                <img class="demo opacity hover-opacity-off"
                                    src="../../../images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de644282.png"
                                    style="width: 100%; cursor: pointer" onclick="currentDiv(3)">
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="w-3/5">
                <div>
                    <h3 class="text-lg font-semibold mb-2">Color: <asp:Label ID="lblColor" runat="server" Text="Beige"></asp:Label></h3>
                    <div class="flex space-x-2">
                        
                            <asp:RadioButton ID="radColor" value="" runat="server" name="color-choice" class="sr-only"  />
                            <span style="background-color:beige" class="h-8 w-8 rounded-full border border-black border-opacity-10"></span>                      
                        
                            
                       
                    </div>
                </div>

                <div class="mt-4">
                    <h3 class="text-lg font-semibold mb-2">Size:</h3>
                    <div class="flex space-x-2">
                        <span class="px-6 py-2.5 rounded-md bg-gray-800 text-white cursor-pointer border-2 border-white hover:border-gray-500">XS</span>
                        <span class="px-4 py-2 rounded-md bg-gray-200 cursor-not-allowed opacity-50">S</span>
                        <span class="px-4 py-2 rounded-md bg-gray-200 cursor-pointer border-2 border-transparent hover:border-gray-500">M</span>
                    </div>
                </div>

                <div class="mt-4">
                    <label for="quantity" class="text-gray-700 font-semibold">Quantity:</label>
                    <div class="inline-flex items-center">
                        <select id="quantity" class="form-select rounded-md py-1 px-2">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <!-- Add more options as needed -->
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="mt-12">
            <div class="border-t-2 border-black">
                <span class="">
                    <p class="text-center text-xl mt-4 font-bold mx-auto underline" style="line-height: 3.75;">Description</p>
                </span>
            </div>
            <div class="w-30 min-w-[300px] mx-auto my-4 grid place-items-center">
                <ul class="product-desc-ul">
                    <li class="list-disc">100% cotton fabric is both soft and gentle on the skin.</li>
                    <li class="list-disc">Simple, sleek design to match any occasion.</li>
                    <li class="list-disc">Four sizes available for a perfect fit.</li>
                    <li class="list-disc">Two pockets: one on either side of the shirt; as well as one chest pocket to keep your
                            valuables secure and close at hand.</li>
                </ul>
            </div>
            <img src="../../../images/product-img/hoodie-size-guide.png" alt="hoodie-size-guide"
                style="width: 100%; max-width: 320px; margin: 1em auto; display: block;">
            <div class="w-full overflow-auto mt-6">
                <table class="w-full min-w-[500px] max-w-[1100px] mx-auto border border-gray-300 bg-whitesmoke size-chart">
                    <thead>
                        <tr class="bg-gray-200">
                            <th class="px-4 py-2 text-center">Size</th>
                            <th class="px-4 py-2 text-center">EUR</th>
                            <th class="px-4 py-2 text-center">US (inch)</th>
                            <th class="px-4 py-2 text-center">Height (cm)</th>
                            <th class="px-4 py-2 text-center">Chest (cm)</th>
                            <th class="px-4 py-2 text-center">Waist (cm)</th>
                            <th class="px-4 py-2 text-center">Neckline (cm)</th>
                            <th class="px-4 py-2 text-center">Sleeve (cm)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="text-center">
                            <th class="px-4 py-2 text-center">XS</th>
                            <td class="px-4 py-2 text-center">34</td>
                            <td class="px-4 py-2 text-center">32</td>
                            <td class="px-4 py-2 text-center">160</td>
                            <td class="px-4 py-2 text-center">88</td>
                            <td class="px-4 py-2 text-center">72</td>
                            <td class="px-4 py-2 text-center">36</td>
                            <td class="px-4 py-2 text-center">61</td>
                        </tr>
                        <tr class="text-center">
                            <th class="px-4 py-2 text-center">S</th>
                            <td class="px-4 py-2 text-center">36</td>
                            <td class="px-4 py-2 text-center">34</td>
                            <td class="px-4 py-2 text-center">165</td>
                            <td class="px-4 py-2 text-center">92</td>
                            <td class="px-4 py-2 text-center">76</td>
                            <td class="px-4 py-2 text-center">37</td>
                            <td class="px-4 py-2 text-center">62</td>
                        </tr>
                        <tr class="text-center">
                            <th class="px-4 py-2 text-center">M</th>
                            <td class="px-4 py-2 text-center">38</td>
                            <td class="px-4 py-2 text-center">36</td>
                            <td class="px-4 py-2 text-center">170</td>
                            <td class="px-4 py-2 text-center">96</td>
                            <td class="px-4 py-2 text-center">80</td>
                            <td class="px-4 py-2 text-center">38</td>
                            <td class="px-4 py-2 text-center">63</td>
                        </tr>
                        <tr class="text-center">
                            <th class="px-4 py-2 text-center">L</th>
                            <td class="px-4 py-2 text-center">40</td>
                            <td class="px-4 py-2 text-center">38</td>
                            <td class="px-4 py-2 text-center">175</td>
                            <td class="px-4 py-2 text-center">100</td>
                            <td class="px-4 py-2 text-center">84</td>
                            <td class="px-4 py-2 text-center">39</td>
                            <td class="px-4 py-2 text-center">64</td>
                        </tr>
                        <tr class="text-center">
                            <th class="px-4 py-2 text-center">XL</th>
                            <td class="px-4 py-2 text-center">42</td>
                            <td class="px-4 py-2 text-center">40</td>
                            <td class="px-4 py-2 text-center">180</td>
                            <td class="px-4 py-2 text-center">104</td>
                            <td class="px-4 py-2 text-center">88</td>
                            <td class="px-4 py-2 text-center">40</td>
                            <td class="px-4 py-2 text-center">65</td>
                        </tr>
                        <tr class="text-center">
                            <th class="px-4 py-2 text-center">2XL</th>
                            <td class="px-4 py-2 text-center">44</td>
                            <td class="px-4 py-2 text-center">42</td>
                            <td class="px-4 py-2 text-center">185</td>
                            <td class="px-4 py-2 text-center">108</td>
                            <td class="px-4 py-2 text-center">92</td>
                            <td class="px-4 py-2 text-center">41</td>
                            <td class="px-4 py-2 text-center">66</td>
                        </tr>
                        <tr class="text-center">
                            <th class="px-4 py-2 text-center">3XL</th>
                            <td class="px-4 py-2 text-center">46</td>
                            <td class="px-4 py-2 text-center">44</td>
                            <td class="px-4 py-2 text-center">190</td>
                            <td class="px-4 py-2 text-center">112</td>
                            <td class="px-4 py-2 text-center">96</td>
                            <td class="px-4 py-2 text-center">42</td>
                            <td class="px-4 py-2 text-center">67</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <p style="text-align: center;">*Difference of 1-2cm may occur</p>
            <p style="text-align: center; margin-top: 1em; font-size: 1.1rem;"><b>Size Chart</b></p>
        </div>
        <div class="mt-5 mx-auto flex justify-center flex-wrap gap-8 w-4/5 max-w-1200">
            <div class="items-center flex justify-center flex-col gap-5 text-lg shadow-lg rounded-lg p-6">
                <p class="text-black text-2xl">Average User Rating</p>
                <p class="text-gray-500">
                    <asp:Label ID="lblAvgRatings" runat="server" Text="4.0" class="font-bold text-black text-2xl"></asp:Label>
                    / 5.0
                </p>
                <div class="flex gap-4">
                    <i class="fas fa-star text-lg p-2 rounded-lg text-yellow-300 bg-black" style="font-weight: bold !important;"></i>
                    <i class="fas fa-star text-lg p-2 rounded-lg text-yellow-300 bg-black" style="font-weight: bold !important;"></i>
                    <i class="fas fa-star text-lg p-2 rounded-lg text-yellow-300 bg-black" style="font-weight: bold !important;"></i>
                    <i class="fas fa-star text-lg p-2 rounded-lg text-yellow-300 bg-black" style="font-weight: bold !important;"></i>
                    <i class="far fa-star text-lg p-2 rounded-lg text-yellow-300 bg-black"></i>
                </div>
                <div class="text-xs flex items-center gap-4">
                    <i class="fas fa-user text-black" style="font-weight: bold !important;"></i>
                    <span class="text-black text-lg">
                    <asp:Label ID="lblTotalReview" runat="server" Text="238" class="text-black text-lg"></asp:Label>
                    Total Reviews</span>
                </div>
            </div>
            <div class="flex justify-center flex-col text-lg shadow-lg rounded-lg p-6 flex-1 min-w-[300px]">
                <div class="flex items-center gap-4 text-base mb-3">
                    <p style="width: 10px">5</p>
                    <i class="fas fa-star text-black" style="font-weight: bold !important;"></i>
                    <span class="w-full bg-opacity-50 bg-gray-400 rounded-full relative" style="height: 12.5px;">
                        <span class="absolute w-4/5 bg-green-500 h-full rounded-full"></span>
                    </span>
                    <p class="text-left">
                        <asp:Label ID="lbl5star" runat="server" Text="80"></asp:Label>%</p>
                </div>
                <div class="flex items-center gap-4 text-base mb-3">
                    <p style="width: 10px" class="text-center">4</p>
                    <i class="fas fa-star text-black" style="font-weight: bold !important;"></i>
                    <span class="w-full bg-opacity-50 bg-gray-400 rounded-full relative" style="height: 12.5px;">
                        <span class="absolute w-3/5 bg-blue-500 h-full rounded-full"></span>
                    </span>
                    <p class="text-left">
                        <asp:Label ID="lbl4star" runat="server" Text="60"></asp:Label>%</p>
                </div>
                <div class="flex items-center gap-4 text-base mb-3">
                    <p style="width: 10px" class="text-center">3</p>
                    <i class="fas fa-star text-black" style="font-weight: bold !important;"></i>
                    <span class="w-full bg-opacity-50 bg-gray-400 rounded-full relative" style="height: 12.5px;">
                        <span class="absolute w-2/5 bg-blue-300 h-full rounded-full"></span>
                    </span>
                    <p class="text-left">
                        <asp:Label ID="lbl3star" runat="server" Text="40"></asp:Label>%</p>
                </div>
                <div class="flex items-center gap-4 text-base mb-3">
                    <p style="width: 10px" class="text-center">2</p>
                    <i class="fas fa-star text-black" style="font-weight: bold !important;"></i>
                    <span class="w-full bg-opacity-50 bg-gray-400 rounded-full relative" style="height: 12.5px;">
                        <span class="absolute w-1/5 bg-yellow-500 h-full rounded-full"></span>
                    </span>
                    <p class="text-center">
                        <asp:Label ID="lbl2star" runat="server" Text="20"></asp:Label>%
                    </p>
                </div>
                <div class="flex items-center gap-4 text-base">
                    <p style="width: 10px" class="text-center">1</p>
                    <i class="fas fa-star text-black" style="font-weight: bold !important;"></i>
                    <span class="w-full bg-opacity-50 bg-gray-400 rounded-full relative" style="height: 12.5px;">
                        <span class="absolute w-1/6 bg-red-600 h-full rounded-full"></span>
                    </span>
                    <p class="text-center">
                        <asp:Label ID="lbl1star" runat="server" Text="15"></asp:Label>%
                    </p>
                </div>
            </div>
        </div>

        <div class="mx-auto shadow-lg mt-5 p-4 rounded-lg">
            <div class="flex items-center flex-wrap p-4 font-bold text-lg">
                <p>All Ratings and Reviews</p>
                <div style="margin-left: auto">
                    <button class="bg-black text-white border border-black px-4 py-2 select-none cursor-pointer transition duration-200 text-base" id="latestBtn" onclick="
                    sortFromLatest()">
                        Latest</button>
                    <button class="bg-transparent border border-black px-4 py-2 select-none cursor-pointer transition duration-200 text-base" id="topRatedBtn" onclick="
                    sortFromTopRated()"
                        onmouseenter="this.style.color = 'whitesmoke'; this.style.backgroundColor = 'black'"
                        onmouseleave="this.style.color = 'black'; this.style.backgroundColor = 'whitesmoke'">
                        Top
                            Rated</button>
                </div>
            </div>

            <div class="flex p-4 relative">
                <div class="border-b-gray-300 border-b-2 flex">
                    <div class="py-4">
                        <img src="../../../images/person1.jpg" alt="user-pic" width="55px" class="rounded-full">
                    </div>
                    <div class="p-4 w-full flex flex-col gap-4">
                        <div class="flex items-center flex-wrap">
                            <div class="flex flex-col">
                                    <asp:Label ID="lblName" runat="server" Text="MantouYYDS" class="text-black font-bold"></asp:Label>
                                <p class="text-sm italic text-gray-500">
                                    <asp:Label ID="lblTime" runat="server" Text="Sun, 12 Sept 2021"></asp:Label>
                                </p>
                                <p class="text-sm italic text-gray-500">
                                    <asp:Label ID="lblVariation" runat="server" Text="Variation: Black, XL size"></asp:Label>
                                </p>
                            </div>
                            <div class="ml-auto">
                                <i class="fas fa-star text-black" style="font-weight: bold !important;"></i>
                                <i class="fas fa-star text-black" style="font-weight: bold !important;"></i>
                                <i class="fas fa-star text-black" style="font-weight: bold !important;"></i>
                                <i class="fas fa-star text-black" style="font-weight: bold !important;"></i>
                                <i class="far fa-star text-black"></i>
                            </div>

                        </div>
                        <div class="flex flex-col gap-4">
                            <p class="pr-5">
                                <asp:Label ID="lblComment" runat="server" Text="                I love this product so much! It's the perfect thickness and I really like
the drawstring. I can't say enough about how great it is! I am convinced that this
product is the best one on the market."></asp:Label>
                            </p>
                        </div>
                        <div class="flex gap-4">
                            <button class="p-2 px-4 border border-black rounded-lg cursor-pointer bg-white hover:bg-gray-600 hover:text-white transition duration-200">
                                <i class="fas fa-thumbs-up"></i>
                                <span id="like-count">124</span>
                            </button>
                            <button class="p-2 px-4 border border-black rounded-lg cursor-pointer bg-white hover:bg-gray-600">
                                <i class="fas fa-thumbs-down"></i>
                                <span id="dislike-count">3</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        
    <script src="<%= Page.ResolveClientUrl("product-details.js") %>"></script>
 
</asp:Content>

