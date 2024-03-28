<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="OutModern.src.Client.Products.Products" %>

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
    <div class="w-full left-0 mb-8 mt-8">
        <!--Page Content and product-->
        <div class="text-center w-3/4 m-[auto] mb-8">
            <h1 class="">Products
            </h1>
        </div>
        <div class="flex items-center">
            <div class="w-1/5 mb-2">
                <h3 class="text-center font-light">Search Filter <i class="fa fa-filter"></i></h3>
            </div>
            <div class="w-4/5 border-b-2 border-gray-200 flex items-center justify-between py-0.5 px-2 mr-3">
                <asp:Label ID="lblTotalProducts" runat="server" class="flex items-center">
                    
                </asp:Label>
                <div class="flex items-center space-x-4 mb-1">
                    <div class="relative" style="">
                        <select id="sortSelect" class="appearance-none bg-white border border-gray-300 rounded-md shadow-sm pl-3 pr-10 py-2 text-sm font-medium text-gray-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 w-full">
                            <option value="Featured">Sort By:&nbsp;Featured</option>
                             <option value="Customer Ratings"> Customer Ratings</option>
                             <option value="Best Seller"> Best Seller</option>
                        </select>
                        <div class="absolute inset-y-0 right-0 flex items-center px-2 pointer-events-none">
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
            <div class="block overflow-hidden relative w-1/5">
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
                            <li class="list-none pb-5 pl-5 radio-no-bullet">
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
                        <ul class="pl-5 w-4/5">
                            <li class="list-none pb-5 pl-5 pt-2 radio-no-bullet flex flex-wrap gap-3.5">
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="radioBeige" value="Beige" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: beige"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="radioLightGray" value="LightGray" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: lightgray"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="radioBlack" value="Black" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: black"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton1" value="Beige" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: red"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton2" value="LightGray" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: orange"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton3" value="Black" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: orangered"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton4" value="Beige" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: blueviolet"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton5" value="LightGray" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: blue"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton6" value="Black" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: aqua"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton7" value="Beige" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: beige"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton8" value="LightGray" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: lightgray"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton9" value="Black" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: black"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton10" value="Beige" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: red"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton11" value="LightGray" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: orange"></span>
                                </label>
                                <label class="inline-flex items-center cursor-pointer colorGrp">
                                    <asp:RadioButton ID="RadioButton12" value="Black" runat="server" GroupName="colorSelection" />
                                    <span class="w-6 h-6 border border-gray-600 rounded-full border-opacity-10" style="background-color: orangered"></span>
                                </label>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <div class="w-4/5 ml-5 mr-8 py-4">
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 xl:grid-cols-4 3xl:grid-cols-5 gap-x-6 gap-y-6">
                    <!-- Product 1 -->
                    <asp:Repeater ID="ProductRepeater" runat="server">
                        <ItemTemplate>
                            <div onclick='<%# Eval("productID", "window.location.href = \"/src/Client/ProductDetails/ProductDetails.aspx?productID={0}\";") %>'  class="bg-white rounded-lg shadow-md overflow-hidden hover:bg-yellow-200 hover:shadow-md hover:-translate-x-2 hover:-translate-y-2 transition duration-100 z-0">
                                <asp:Image ImageUrl='<%# Eval("productImageUrl1", "{0}") %>' ID="Image1" runat="server" class="w-full h-100 object-cover bg-gray-200 hover:cursor-pointer" style="transition: transform 0.5s ease-in-out;"
                                     onmouseover='<%# "changeImage(this, \"" + ResolveClientUrl(Eval("productImageUrl2").ToString()) + "\")" %>'
    onmouseout='<%# "changeImage(this, \"" + ResolveClientUrl(Eval("productImageUrl1").ToString()) + "\")" %>'/>
                                <div class="p-4 pr-0">
                                    <h2 class="mb-2">
                                        <asp:Label class="text-gray-800 font-bold text-xl hover:cursor-pointer hover:underline" ID="lblName" runat="server">
                                            <%# Eval("productName") %>
                                        </asp:Label></h2>
                                    <p class="mb-2">
                                        <asp:Label ID="lblPrice" class="text-gray-700 font-bold text-xl" runat="server">
                                            RM<%# Eval("price") %>
                                        </asp:Label>
                                    </p>
                                    <div class="flex items-center mb-2">
                                        <span><i class="fas fa-star"></i></span>
                                        <span><i class="fas fa-star"></i></span>
                                        <span><i class="fas fa-star"></i></span>
                                        <span><i class="fas fa-star"></i></span>
                                        <span>
                                            <i class="fas fa-star-half-alt"></i>
                                        </span>
                                        <span class="text-gray-600 ml-2">(<%# Eval("TotalReview") %> Reviews)</span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        <div class="mt-6 flex items-center justify-center space-x-1.5 mb-2">
            <a href="#" class="flex items-center px-2 py-2 text-gray-500  rounded-md hover:bg-gray-100">
                <svg class="w-4 h-4 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M7.707 14.707a1 1 0 01-1.414 0L2.293 10.707a1 1 0 010-1.414l4-4a1 1 0 111.414 1.414L5.414 10l2.293 2.293a1 1 0 010 1.414z" clip-rule="evenodd" />
                </svg>
            </a>
            <a href="#" class="px-4 py-2 text-white bg-black rounded-md hover:bg-gray-700">1</a>
            <a href="#" class="px-4 py-2 text-gray-700 bg-white rounded-md hover:bg-gray-100">2</a>
            <a href="#" class="px-4 py-2 text-gray-700 bg-white rounded-md hover:bg-gray-100">3</a>
            <a href="#" class="px-4 py-2 text-gray-700 bg-white rounded-md hover:bg-gray-100">4</a>
            <a href="#" class="px-4 py-2 text-gray-700 bg-white rounded-md hover:bg-gray-100">5</a>

            <a href="#" class="flex items-center px-2 py-2 text-gray-500 rounded-md hover:bg-gray-100">
                <svg class="w-4 h-4 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
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
