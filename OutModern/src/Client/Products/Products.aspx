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
            cursor:pointer;
        }
       
     </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Wrapper of whole webpage -->
    <div class="w-full left-0">
        <!--Page Content and product-->
        <div class="text-center w-3/4 m-[auto] mb-10">
            <h1 class="">HOODIES 
            </h1>
        </div>
        <div class="flex">
            <div class="w-1/5 mb-3">
                  <h3 class="text-center font-light">Filter and Sort <i class="fa fa-filter"></i></h3>
            </div>
            <div class="w-4/5 border-b-2 border-gray-200 mr-4">
                35 Products Found
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
                                <asp:TextBox class="text-center" Type="Number" ID="minPrice" runat="server" Style="width: 45%" placeholder="minPrice"></asp:TextBox>
                                -
                                <asp:TextBox class="text-center" Type="Number" placeholder="maxPrice" ID="maxPrice" runat="server" Style="width: 45%"></asp:TextBox>
                            </li>
                        </ul>
                    </li>
                    <li class="list-none border-b border-gray-300">
                        <div class="p-5 hover:bg-[#f8efd6] hover:cursor-pointer hover:[transition:0.3s]" onclick="openSortList();invertIcon(this)">
                            Sort by<i class="fa fa-caret-down !font-black float-right"></i>
                        </div>
                        <ul class="pb-5 pl-5">
                            <li class="list-none pb-5 pl-5">
                                <input type="radio" name="sortBy" id="rmd" class="rmd" checked />
                                <label for="rmd">Recommended</label>
                            </li>
                            <li class="list-none pb-5 pl-5">
                                <input type="radio" name="sortBy" id="lowestPrice" class="lowestPrice" />
                                <label for="lowestPrice">Lowest Price</label>
                            </li>
                            <li class="list-none pb-5 pl-5">
                                <input type="radio" name="sortBy" id="highestPrice" class="highestPrice" />
                                <label for="highestPrice">Highest Price</label>
                            </li>
                        </ul>
                    </li>
                    <li class="list-none border-b border-gray-300">
                        <div class="p-5 hover:bg-[#f8efd6] hover:cursor-pointer hover:[transition:0.3s]" onclick="openSortList();invertIcon(this)">
                            Category<i class="fa fa-caret-down !font-black float-right"></i>
                        </div>
                        <ul class="pb-5 pl-5" id="">
                            <li class="list-none pb-5 pl-5">
                                <asp:CheckBox ID="chckHoodies" runat="server" Text="   Hoodies" />
                            </li>
                            <li class="list-none pb-5 pl-5">
                                <asp:CheckBox ID="chckShorts" runat="server" Text="    Shorts" />
                            </li>
                            <li class="list-none pb-5 pl-5">
                                <asp:CheckBox ID="chckSweater" runat="server" Text="   Sweater" />
                            </li>
                            <li class="list-none pb-5 pl-5">
                                <asp:CheckBox ID="chckTeeShirt" runat="server" Text="  TeeShirt" />
                            </li>
                            <li class="list-none pb-5 pl-5">
                                <asp:CheckBox ID="chcktrousers" runat="server" Text="  Trousers" />
                            </li>
                        </ul>
                    </li>
                    <li class="list-none border-b border-gray-300">
                        <div class="p-5 hover:bg-[#f8efd6] hover:cursor-pointer hover:[transition:0.3s]" onclick="openSortList();invertIcon(this)">
                            Customer Ratings<i class="fa fa-caret-down !font-black float-right"></i>
                        </div>
                        <ul class="pb-5 pl-5">
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
                </ul>
            </div>
            <div class="w-4/5 ml-3 mr-4 py-4">
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                    <!-- Product 1 -->
                    <div class="bg-white rounded-lg shadow-md overflow-hidden hover:bg-yellow-200 hover:shadow-md hover:-translate-x-2 hover:-translate-y-2 transition duration-100 z-0">
                        <img src="../../../images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png" alt="" class="w-full h-100 object-cover bg-gray-200 hover:cursor-pointer">
                        <div class="p-4">
                            <h2 class="mb-2"><asp:Label class="text-gray-800 font-bold text-xl hover:cursor-pointer hover:underline" ID="lblName" runat="server" Text="Product 1"></asp:Label></h2>
                            <p class="mb-2"><asp:Label ID="lblPrice" class="text-gray-700 font-bold text-xl" runat="server" Text="RM19.99"></asp:Label></p>
                            <div class="flex items-center mb-2">
                                <span><i class="fas fa-star"></i></span>
                                <span><i class="fas fa-star"></i></span>
                                <span><i class="fas fa-star"></i></span>
                                <span><i class="fas fa-star"></i></span>
                                <span>
                                    <i class="fas fa-star-half-alt"></i>
                                </span>
                                <span class="text-gray-600 ml-2">(100 sold)</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
