<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="OutModern.src.Client.Login.AdminLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>OutModern | Login</title>

    <!-- import font type css-->
    <link href="<%=Page.ResolveClientUrl("~/lib/fonts/ChakraPetch/ChakraPetch.css") %>" rel="stylesheet" />

    <!-- import fontawesome css-->
    <link href="<%= Page.ResolveClientUrl("~/lib/fontawesome/css/all.min.css") %>" rel="stylesheet" />

    <link href="css/AdminLogin.css" rel="stylesheet" />

    <!-- import tailwind js-->
    <script src="<%= Page.ResolveClientUrl("~/lib/tailwind/tailwind.js") %>"></script>
</head>
<body>
    <form id="form1" runat="server">


        <div class="column1">
            <div class="rightBox">
                <span class="title">Log In&nbsp</span>
                <span class="title2">ADMIN</span>

                <div class="loginBoxItem">
                    <asp:TextBox ID="txt_email" runat="server" class="loginTextBox" placeholder="Email" TextMode="Email"></asp:TextBox>
                </div>
                <div class="loginBoxItem">
                    <asp:TextBox ID="txt_password" runat="server" class="loginTextBox" TextMode="Password" placeholder="Password"></asp:TextBox>
                </div>

                <div class="loginBoxButton">
                    <asp:Button ID="btn_login" runat="server" class="loginButton" Text="Log In" Style="background-color: black;"/>
                </div>

                <div style="padding-top: 3px; padding-bottom: 30px;">
                    <asp:HyperLink ID="hl_forget_password" runat="server" Style="font-family: sans-serif; font-size: 17px; color: #94d4ca; cursor: pointer;" NavigateUrl="~/src/Client/Login/ForgetPassword.aspx">Forget Password</asp:HyperLink>
                </div>

                <div style="padding: 10px; color: darkgrey;">
                    <hr />
                </div>


                <div style="padding-top: 10px; padding-bottom: 25px;" class="loginBoxBottom">
                    <span style="margin-top: 20px; padding-left: 85px; font-family: sans-serif; font-size: 15px; color: #b3b3b3;">New to Out Modern?</span>
                    <asp:HyperLink ID="hl_signup" runat="server" Style="margin-top: 20px; font-family: sans-serif; font-size: 1rem; font-weight: bold; color: #94d4ca; cursor: pointer;" NavigateUrl="~/src/Client/Login/SignUp.aspx">Sign Up</asp:HyperLink>
                </div>

            </div>

        </div>

        <div class="column2"></div>
    </form>
</body>
</html>
