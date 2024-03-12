<%@ Page Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="OutModern.src.Client.Products.Products" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
 
     </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <!-- Wrapper of whole webpage -->
 <div class="w-full left-[0]">
     <!--Page Content and product-->
     <div class="content">
         <!--PAGE TITLE-->
         <div class="text-center w-3/4 m-[auto]">
             <h1 class="m-[20px]"> HOODIES 
             </h1>
         </div>

         <div class="w-[17%] block overflow-hidden relative">
             <ul>
                 <h3 class="text-center m-[20px] font-[lighter]">Filter and Sort <i class="fa fa-filter"></i></h3>
                 <li class="list-none border-b border-gray-300">
                     <div class="p-[10px] hover:bg-[#f8efd6] hover:cursor-pointer hover:[transition:0.3s]" onclick="openSortList();invertIcon(this)">
                         Sort by<i class="fa fa-caret-down !font-black float-right"></i>
                     </div>
                     <ul class="leftFilterDropDown" id="leftFilterSortBy">
                         <li class="list-none p-[10px]">
                             <input type="radio" name="sortBy" id="rmd" class="rmd" checked />
                             <label for="rmd">Recommended</label>
                         </li>
                         <li class="list-none p-[10px]">
                             <input type="radio" name="sortBy" id="lowestPrice" class="lowestPrice" />
                             <label for="lowestPrice">Lowest Price</label>
                         </li>
                         <li class="list-none p-[10px]">
                             <input type="radio" name="sortBy" id="highestPrice" class="highestPrice" />
                             <label for="highestPrice">Highest Price</label>
                         </li>
                     </ul>
                 </li>
                 <li class="list-none border-b border-gray-300">
                     <div class="p-[10px] hover:bg-[#f8efd6] hover:cursor-pointer hover:[transition:0.3s]" onclick="openPriceList();invertIcon(this)">
                         Price<i class="fa fa-caret-down !font-black float-right"></i>
                     </div>
                     <ul class="leftFilterDropDown" id="leftFilterPrice">
                         <li class="list-none p-[10px]">
                             <input type="radio" name="price" id="below150" class="below150" checked />
                             <label for="below150">Below RM150</label>
                         </li>
                         <li class="list-none p-[10px]">
                             <input type="radio" name="price" id="below100" class="below100" />
                             <label for="below100">Below RM100</label>
                         </li>
                         <li class="list-none p-[10px]">
                             <input type="radio" name="price" id="below50" class="below50" />
                             <label for="below50">Below RM50</label>
                         </li>
                     </ul>
                 </li>
             </ul>
         </div>
     </div>     
 </div>


</asp:Content>
