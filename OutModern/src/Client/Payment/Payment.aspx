<%@ Page Title="Payment" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="OutModern.Client.Payment.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .auto-style1 {
            margin-left: 40px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <p class="p-6">

    This is Payment TESTING PAGE

    </p>

    <div class="border border-black rounded-md p-2 mb-2 flex">
        <!--Left Container-->
        <div class="w-3/5 p-4">
            <div id="paymentMethod" runat="server" class="p-4 bg-white shadow-md rounded-md">



            </div>
        </div>

        <!--Right Container-->
        <div class="w-2/5 p-4">

            <!-- Order Summary -->
            <div id="orderSummary" runat="server" class="p-4 bg-white shadow-md rounded-md">
                    
            
            </div>

        </div>
        <!-- Add more input fields as needed -->
    </div>


</asp:Content>

