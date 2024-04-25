﻿<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="OutModern.src.Client.Products.Products"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        i.fas {
            color: #fbbf24;
        }

        .radio-no-bullet input[type="radio"]:checked + label {
            background-color: #ebebeb;
            border-radius: 5px;
            font-weight: 500;
        }

        .radio-no-bullet input[type="radio"] + label {
            cursor: pointer;
        }

        .colorGrp input[type="radio"],
.sizeGrp input[type="radio"] {
    position: absolute;
    opacity: 0;
    pointer-events: none;
}
     
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Wrapper of whole webpage -->
    <div class="left-0 mb-8 mt-8 w-full">
        <div class="m-[auto] p-5 text-center">
            <div class="flex space-x-2">
                <span class="text-black">
                    <asp:HyperLink ID="HyperLink1" NavigateUrl="~/src/Client/Home/Home.aspx" runat="server" CssClass="text-sm text-black hover:underline">Home</asp:HyperLink>
                    >
                </span>
                <span class="text-black">
                    <asp:HyperLink ID="HyperLink2" NavigateUrl="~/src/Client/Products/Products.aspx" runat="server" CssClass="text-sm text-black hover:underline">Products</asp:HyperLink>
                </span>
            </div>
        </div>
        <div class="flex items-center">
            <div class="mb-2 w-1/5">
                <h3 class="text-center font-light">Search Filter <i class="fa fa-filter"></i></h3>
            </div>
            <div class="border-b-2 mr-3 flex w-4/5 items-center justify-between border-gray-200 px-2 py-0.5">
                <asp:Label ID="lblTotalProducts" runat="server" class="flex items-center">
                    
                </asp:Label>
                <div class="mb-1 flex items-center space-x-4">
                    <div class="relative" style="">
                        <select id="sortSelect" class="w-full appearance-none rounded-md border border-gray-300 bg-white py-2 pl-3 pr-10 text-sm font-medium text-gray-700 shadow-sm focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500">
                            <option value="Featured">Sort By:&nbsp;Featured</option>
                             <option value="Customer Ratings"> Customer Ratings</option>
                             <option value="Best Seller"> Best Seller</option>
                        </select>
                        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2">
                            <svg class="h-5 w-5 text-gray-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                                <path fill-rule="evenodd" d="M10 3a1 1 0 01.707.293l3 3a1 1 0 01-1.414 1.414L10 5.414 7.707 7.707a1 1 0 01-1.414-1.414l3-3A1 1 0 0110 3zm-3.707 9.293a1 1 0 011.414 0L10 14.586l2.293-2.293a1 1 0 011.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clip-rule="evenodd" />
                            </svg>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="flex">
            <!--PAGE TITLE-->
            <div class="relative block w-1/5 overflow-hidden">
                <ul>
                    <li class="list-none border-b border-gray-300">
                        <div class="p-5 hover:bg-[#f8efd6] hover:cursor-pointer hover:[transition:0.3s]" onclick="openPriceList();invertIcon(this)">
                            Price Range<i class="fa fa-caret-down !font-black float-right"></i>
                        </div>
                        <ul class="pb-5 pl-5">
                            <li class="list-none">
                                <asp:TextBox class="text-center" Type="Number" ID="minPrice" runat="server" Style="width: 45%" placeholder="Min Price"></asp:TextBox>
                                -
                                <asp:TextBox class="text-center" Type="Number" placeholder="Max Price" ID="maxPrice" runat="server" Style="width: 45%"></asp:TextBox>
                            </li>
                        </ul>
                    </li>
                    <li class="list-none border-b border-gray-300">
                        <div class="p-5 hover:bg-[#f8efd6] hover:cursor-pointer hover:[transition:0.3s]" onclick="openSortList();invertIcon(this)">
                            Sort by<i class="fa fa-caret-down !font-black float-right"></i>
                        </div>
                        <ul class="pb-2 pl-5">
                            <li class="list-none pb-4 pl-5">
                                <input type="radio" name="sortBy" id="rmd" class="rmd" checked />
                                <label for="rmd">Recommended</label>
                            </li>
                            <li class="list-none pb-4 pl-5">
                                <input type="radio" name="sortBy" id="lowestPrice" class="lowestPrice" />
                                <label for="lowestPrice">Lowest Price</label>
                            </li>
                            <li class="list-none pb-4 pl-5">
                                <input type="radio" name="sortBy" id="highestPrice" class="highestPrice" />
                                <label for="highestPrice">Highest Price</label>
                            </li>
                        </ul>
                    </li>
                    <li class="list-none border-b border-gray-300">
                        <div class="p-5 hover:bg-[#f8efd6] hover:cursor-pointer hover:[transition:0.3s]" onclick="openSortList();invertIcon(this)">
                            By Category<i class="fa fa-caret-down !font-black float-right"></i>
                        </div>
                        <ul class="pb-2 pl-5" id="">
                            <li class="list-none pb-4 pl-5">
                                <asp:CheckBox ID="chckHoodies" runat="server" Text="   Hoodies" />
                            </li>
                            <li class="list-none pb-4 pl-5">
                                <asp:CheckBox ID="chckShorts" runat="server" Text="    Shorts" />
                            </li>
                            <li class="list-none pb-4 pl-5">
                                <asp:CheckBox ID="chckSweater" runat="server" Text="   Sweater" />
                            </li>
                            <li class="list-none pb-4 pl-5">
                                <asp:CheckBox ID="chckTeeShirt" runat="server" Text="  TeeShirt" />
                            </li>
                            <li class="list-none pb-4 pl-5">
                                <asp:CheckBox ID="chcktrousers" runat="server" Text="  Trousers" />
                            </li>
                        </ul>
                    </li>
                    <li class="list-none border-b border-gray-300">
                        <div class="p-5 hover:bg-[#f8efd6] hover:cursor-pointer hover:[transition:0.3s]" onclick="openSortList();invertIcon(this)">
                            Customer Ratings<i class="fa fa-caret-down !font-black float-right"></i>
                        </div>
                        <ul class="pl-5">
                            <li class="radio-no-bullet list-none pb-5 pl-5">
                                <asp:RadioButtonList runat="server" ID="rbRatings">
                                    <asp:ListItem Value="5s">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i> 
                                    </asp:ListItem>
                                    <asp:ListItem Value="4s">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i> 
                                    </asp:ListItem>
                                    <asp:ListItem Value="3s">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </asp:ListItem>
                                    <asp:ListItem Value="2s">
                                        <i class="fas fa-star"></i>
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </asp:ListItem>
                                    <asp:ListItem Value="1s">
                                        <i class="fas fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                        <i class="far fa-star"></i>
                                    </asp:ListItem>
                                </asp:RadioButtonList>
                            </li>
                        </ul>
                    </li>
                    <li class="list-none border-b border-gray-300">
                        <div class="p-5 hover:bg-[#f8efd6] hover:cursor-pointer hover:[transition:0.3s]" onclick="openSortList();invertIcon(this)">
                            Colors<i class="fa fa-caret-down !font-black float-right"></i>
                        </div>
                        <ul class="w-4/5 pl-5">
                            <li class="radio-no-bullet flex list-none flex-wrap gap-3.5 pb-5 pl-5 pt-2">
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="radioBeige" value="Beige" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: beige"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="radioLightGray" value="LightGray" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: lightgray"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="radioBlack" value="Black" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: black"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton1" value="Beige" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: red"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton2" value="LightGray" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: orange"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton3" value="Black" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: orangered"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton4" value="Beige" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: blueviolet"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton5" value="LightGray" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: blue"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton6" value="Black" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: aqua"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton7" value="Beige" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: beige"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton8" value="LightGray" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: lightgray"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton9" value="Black" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: black"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton10" value="Beige" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: red"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton11" value="LightGray" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: orange"></span>
                                </label>
                                <label class="colorGrp inline-flex cursor-pointer items-center">
                                    <asp:RadioButton ID="RadioButton12" value="Black" runat="server" GroupName="colorSelection" />
                                    <span class="border-opacity-10 h-6 w-6 rounded-full border border-gray-600" style="background-color: orangered"></span>
                                </label>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="ml-5 mr-8 w-4/5 py-4">
                <div class="grid-cols-1 grid gap-x-6 gap-y-6 sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 3xl:grid-cols-5">
                    <!-- Product 1 -->
                    <asp:Repeater ID="ProductRepeater" runat="server">
                        <ItemTemplate>
                            <div onclick='<%# Eval("productID", "window.location.href = \"/src/Client/ProductDetails/ProductDetails.aspx?ProductId={0}\";") %>'  class="cursor-pointer bg-white rounded-lg shadow-md overflow-hidden hover:bg-yellow-100 hover:shadow-md hover:-translate-x-2 hover:-translate-y-2 transition duration-100 z-0">
                                <asp:Image ImageUrl='<%# Eval("productImageUrl1", "{0}") %>' ID="Image1" runat="server" class="w-full h-100 object-cover bg-gray-200 hover:cursor-pointer" style="transition: transform 0.5s ease-in-out;"
                                     onmouseover='<%# "changeImage(this, \"" + ResolveClientUrl(Eval("productImageUrl2").ToString()) + "\")" %>'
    onmouseout='<%# "changeImage(this, \"" + ResolveClientUrl(Eval("productImageUrl1").ToString()) + "\")" %>'/>
                                <div class="p-4 pr-0">
                                    <h2 class="mb-2">
                                        <asp:Label class="text-xl font-bold text-gray-800 hover:cursor-pointer hover:underline" ID="lblName" runat="server">
                                            <%# Eval("ProductName") %>
                                        </asp:Label></h2>
                                    <p class="mb-2">
                                        <asp:Label ID="lblPrice" class="text-xl font-bold text-gray-700" runat="server">
                                            RM<%# Eval("UnitPrice") %>
                                        </asp:Label>
                                    </p>
                                    <div class="mb-2 flex items-center">
                                        <span><i class="fas fa-star"></i></span>
                                        <span><i class="fas fa-star"></i></span>
                                        <span><i class="fas fa-star"></i></span>
                                        <span><i class="fas fa-star"></i></span>
                                        <span>
                                            <i class="fas fa-star-half-alt"></i>
                                        </span>
                                        <span class="ml-2 text-gray-600">(<%# Eval("TotalReview") %> Reviews)</span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        <div class="mb-2 mt-6 flex items-center justify-center space-x-1.5">
            <a href="#" class="flex items-center rounded-md px-2 py-2 text-gray-500 hover:bg-gray-100">
                <svg class="h-4 w-4 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M7.707 14.707a1 1 0 01-1.414 0L2.293 10.707a1 1 0 010-1.414l4-4a1 1 0 111.414 1.414L5.414 10l2.293 2.293a1 1 0 010 1.414z" clip-rule="evenodd" />
                </svg>
            </a>
            <a href="#" class="rounded-md bg-black px-4 py-2 text-white hover:bg-gray-700">1</a>
            <a href="#" class="rounded-md bg-white px-4 py-2 text-gray-700 hover:bg-gray-100">2</a>
            <a href="#" class="rounded-md bg-white px-4 py-2 text-gray-700 hover:bg-gray-100">3</a>
            <a href="#" class="rounded-md bg-white px-4 py-2 text-gray-700 hover:bg-gray-100">4</a>
            <a href="#" class="rounded-md bg-white px-4 py-2 text-gray-700 hover:bg-gray-100">5</a>

            <a href="#" class="flex items-center rounded-md px-2 py-2 text-gray-500 hover:bg-gray-100">
                <svg class="h-4 w-4 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M12.293 5.293a1 1 0 011.414 0l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414-1.414L15.586 10l-3.293-3.293a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
            </a>
        </div>
    </div>
 <script>
     function changeImage(image, imageUrl) {
         setTimeout(function () {
             image.src = imageUrl;
         }, 200);
     }
     const sortSelect = document.getElementById("sortSelect");

     sortSelect.addEventListener("change", function () {
         const selectedOption = sortSelect.options[sortSelect.selectedIndex];

         selectedOption.textContent = "Sort By: " + selectedOption.textContent;
         for (var i = 0; i < sortSelect.options.length; i++) {
             if (sortSelect.selectedIndex !== i) {
                 sortSelect.options[i].textContent = sortSelect.options[i].value;
             }
         }
     });
 </script>
</asp:Content>