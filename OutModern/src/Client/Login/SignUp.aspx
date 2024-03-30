<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="OutModern.src.Client.Login.SignUp1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>OutModern | Sign Up</title>

    <!-- import font type css-->
    <link href="<%=Page.ResolveClientUrl("~/lib/fonts/ChakraPetch/ChakraPetch.css") %>" rel="stylesheet" />

    <!-- import fontawesome css-->
    <link href="<%= Page.ResolveClientUrl("~/lib/fontawesome/css/all.min.css") %>" rel="stylesheet" />

    <link href="css/SignUp.css" rel="stylesheet" />

    <!-- import tailwind js-->
    <script src="<%= Page.ResolveClientUrl("~/lib/tailwind/tailwind.js") %>"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="signup-container">
            <div class="column1"></div>

            <div class="column2">
                <div class="rightBox">
                    <span class="title">Create an account</span>
                    <div class="nextLine">
                        <span class="title2">Make your outfit the statement now</span>
                    </div>

                    <div class="rightBoxBottom">
                        <div class="boxItem">
                            <asp:TextBox ID="txt_su_fullname" runat="server" class="SUTextBox" placeholder="Fullname"></asp:TextBox>
                        </div>

                        <div class="boxItem">
                            <asp:TextBox ID="txt_su_username" runat="server" class="SUTextBox" placeholder="Username"></asp:TextBox>
                        </div>

                        <div class="boxItem">
                            <asp:TextBox ID="txt_su_email" runat="server" class="SUTextBox" placeholder="Email" TextMode="Email"></asp:TextBox>
                        </div>

                        <div class="boxItem">
                            <asp:TextBox ID="txt_su_password" runat="server" class="SUTextBox" TextMode="Password" placeholder="Password"></asp:TextBox>
                        </div>

                        <div class="boxItem">
                            <asp:TextBox ID="txt_su_reenter_password" runat="server" class="SUTextBox" TextMode="Password" placeholder="Re-enter Password"></asp:TextBox>
                        </div>

                        <div class="boxItem3">
                            <asp:CheckBox ID="chkbox_policy" runat="server" Text="&nbsp;I agree to the terms and" class="policyText"/> 
                            <asp:HyperLink ID="hl_policy" runat="server" class="policyText1" NavigateUrl="~/src/Client/Login/Policy.aspx"><u>privacy policy</u></asp:HyperLink>
                        </div>

                        <div class="boxItem1">
                            <asp:Button ID="btn_sign_up" runat="server" class="SUButton" Text="Register" Style="background-color: black;" OnClick="btn_sign_up_Click" />
                        </div>

                        <div class="boxItem2">
                            <div style="padding-top: 10px; text-align: center;">
                                <span href="#" style="margin-top: 20px; font-family: sans-serif; font-size: 15px; color: #bfbfbf;">Already have account?</span>
                                <asp:HyperLink ID="HyperLink1" runat="server" Style="margin-top: 20px; font-family: sans-serif; font-size: 15px; font-weight: bold; color: #94d4ca; padding-right: 15px; cursor: pointer;" NavigateUrl="~/src/Client/Login/Login.aspx">Login</asp:HyperLink>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
    </form>
</body>
</html>
