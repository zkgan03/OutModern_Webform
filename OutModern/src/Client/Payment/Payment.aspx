<%@ Page Title="Payment" Language="C#" MasterPageFile="~/src/Client/ClientMaster/Client.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="OutModern.Client.Payment.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    This is Payment TESTING PAGE
    <div class="border border-black rounded-md p-2 mb-2 flex">
        <div class="w-1/2 p-4">
            <!-- Adjust the width as needed -->
            <!-- Input fields for the first side -->
            <input type="text" class="border rounded-md p-2 mb-2" placeholder="Input 1">
            <input type="text" class="border rounded-md p-2 mb-2" placeholder="Input 2">
            <!-- Add more input fields as needed -->
        </div>
        <div class="w-1/2 p-4">
            <!-- Adjust the width as needed -->
            <!-- Input fields for the second side -->
            <input type="text" class="border rounded-md p-2 mb-2" placeholder="Input 3">
            <input type="text" class="border rounded-md p-2 mb-2" placeholder="Input 4">
            <table class="table-auto border border-separate">
                <thead>
                    <tr>
                        <th class="border">Song</th>
                        <th class="border">Artist</th>
                        <th class="border">Year</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="border">The Sliding Mr. Bones (Next Stop, Pottersville)</td>
                        <td class="border">Malcolm Lockyer</td>
                        <td class="border">1961</td>
                    </tr>
                    <tr>
                        <td class="border">Witchy Woman</td>
                        <td class="border">The Eagles</td>
                        <td class="border">1972</td>
                    </tr>
                    <tr>
                        <td class="border">Shining Star</td>
                        <td class="border">Earth, Wind, and Fire</td>
                        <td class="border">1975</td>
                    </tr>
                </tbody>
            </table>
            <!-- Add more input fields as needed -->
        </div>

    </div>


</asp:Content>

