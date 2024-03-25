﻿<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="OutModern.src.Client.Products.Products" %>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Wrapper of whole webpage -->
    <div class="w-full left-0 mb-8">
        <!--Page Content and product-->
        <div class="text-center w-3/4 m-[auto] mb-10">
            <h1 class="">HOODIES 
            </h1>
        </div>
        <div class="flex">
            <div class="w-1/5 mb-3">
                <h3 class="text-center font-light">Search Filter <i class="fa fa-filter"></i></h3>
            </div>
            <div class="w-4/5 border-b-2 border-gray-200 mr-4">
                <asp:Label ID="lblTotalProducts" runat="server">
                    
                </asp:Label>
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
                    <li></li>
                </ul>
            </div>
            <div class="w-4/5 ml-5 mr-8 py-4">
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-5 gap-x-6 gap-y-6">
                    <!-- Product 1 -->
                    <asp:Repeater ID="ProductRepeater" runat="server">
                        <ItemTemplate>
                            <div onclick='<%# Eval("productID", "window.location.href = \"ProductDetails.aspx?productID={0}\";") %>' class="bg-white rounded-lg shadow-md overflow-hidden hover:bg-yellow-200 hover:shadow-md hover:-translate-x-2 hover:-translate-y-2 transition duration-100 z-0">
                                <asp:Image ImageUrl='<%# Eval("productImageUrl1", "{0}") %>' ID="Image1" runat="server" class="w-full h-100 object-cover bg-gray-200 hover:cursor-pointer"/>
                                <div class="p-4">
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
                                        <span class="text-gray-600 ml-2">(<%# Eval("TotalReview") %> Sold)</span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        <div class="mt-8 flex items-center justify-center space-x-1.5">
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
</asp:Content>
