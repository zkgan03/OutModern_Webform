<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="ProductAdd.aspx.cs" Inherits="OutModern.src.Admin.ProductAdd.ProductAdd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        .button {
            @apply text-center px-1 cursor-pointer hover:opacity-50 bg-gray-200 border border-black;
        }

        #prod-edit-form #edit-from-item > div {
            @apply mt-1;
        }

        .desc-title {
            @apply inline-block w-28 float-left;
        }

        /*Variation*/
        #variation-form {
            @apply mb-10 ml-2 mt-5;
        }

            #variation-form .size-added {
                @apply rounded-full bg-black text-white size-5 inline-flex justify-center items-center;
            }

            #variation-form .product-img {
                @apply border border-black;
            }

            #variation-form .add-image {
                @apply size-40 border border-black hover:opacity-50 cursor-pointer rounded-3xl flex justify-center items-center ml-5;
            }

                #variation-form .add-image i {
                    @apply text-[4em];
                }

            #variation-form .color-varient {
                @apply cursor-pointer size-5 rounded-full border drop-shadow border-white box-border;
            }

                #variation-form .color-varient.active {
                    @apply outline outline-black outline-1;
                }

                #variation-form .color-varient.add-color {
                    @apply outline outline-black outline-1 cursor-default;
                }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="mt-2">
        <div class="flex justify-between">
            <!--Discard change btn-->
            <asp:LinkButton
                OnClientClick="return confirm('Are you sure you want to discard? The changes will be lost');"
                CssClass="text-white p-2 rounded bg-red-500 hover:opacity-50"
                ID="lbDiscard" runat="server"
                OnClick="lbDiscard_Click">
                <i class="fa-regular fa-trash"></i>  
                Discard Change
            </asp:LinkButton>

            <!--Update btn-->
            <asp:LinkButton
                OnClientClick="return confirm('Are you sure you want to Add?')"
                OnClick="lbAdd_Click"
                CssClass="text-white p-2 rounded bg-green-500 hover:opacity-50"
                ID="lbAdd" runat="server">
                <i class="fa-regular fa-plus"></i>     Add
            </asp:LinkButton>
        </div>

        <!-- General Desc -->
        <div id="prod-edit-form" class="mt-8">

            <div class="text-[1.5rem] font-bold">Add New Product</div>
            <div id="edit-from-item" class="mt-2 ml-2 text-xl">
                <div>
                    <span class="desc-title">Product ID</span>
                    <span>:
                        <asp:Label ID="lblProdId" runat="server" Text="123"></asp:Label>
                    </span>
                </div>
                <div>
                    <span class="desc-title">Product Name</span>
                    <span>:                        
                        <asp:TextBox ID="txtProdName" runat="server" Text=""></asp:TextBox>
                    </span>
                </div>
                <div>
                    <span class="desc-title">Category</span>
                    <span>: 
                        <asp:DropDownList ID="ddlProdCat" AppendDataBoundItems="true" runat="server">
                            <asp:ListItem>Hoodie</asp:ListItem>
                            <asp:ListItem>Test</asp:ListItem>
                            <asp:ListItem>Shirt</asp:ListItem>
                        </asp:DropDownList>
                    </span>
                </div>
                <div>
                    <span class="desc-title">Price (RM)</span>
                    <span>:                        
                        <asp:TextBox ID="txtProdPrice" runat="server" Text=""></asp:TextBox>
                    </span>
                </div>
                <div>
                    <span class="desc-title">Current Status</span>
                    <span>:
                        <asp:DropDownList ID="ddlProdStatus" AppendDataBoundItems="true" runat="server">
                            <asp:ListItem>In Stock</asp:ListItem>
                            <asp:ListItem>Unavailable</asp:ListItem>
                            <asp:ListItem>Out of Stock</asp:ListItem>
                        </asp:DropDownList></span>
                </div>
            </div>
        </div>

        <!-- Variation -->
        <div id="variation-form">
            <div class="text-[1.5rem] font-bold">Variation</div>
            <div class="flex mt-2 items-center">
                <div>Size : none <%--<span class="size-added">S</span>--%></div>
                <div class="ml-20">
                    Add Size : 
         <asp:DropDownList ID="ddlSize" runat="server">
             <asp:ListItem>S</asp:ListItem>
             <asp:ListItem>M</asp:ListItem>
             <asp:ListItem>L</asp:ListItem>
             <asp:ListItem>XL</asp:ListItem>
         </asp:DropDownList>
                    <asp:Button ID="btnAddSize" CssClass="button text-black py-0" runat="server" Text="Add" />
                </div>
            </div>
            <div class="mt-2">
                <span>Quantity : </span>
                <span>
                    <asp:TextBox CssClass="w-20" TextMode="Number" ID="TextBox1" runat="server" Text="0"></asp:TextBox>
                </span>
            </div>
            <div class="flex mt-2 items-center">
                <div class="flex gap-2 justify-center items-center">
                    <div>Colors : </div>
                    <div>none</div>
                </div>
                <!--Choose color-->
                <div class="flex ml-20 gap-2 justify-center items-center">
                    Add Color : 
                    <asp:DropDownList ID="ddlColor" runat="server">
                        <asp:ListItem>navy</asp:ListItem>
                        <asp:ListItem>green</asp:ListItem>
                        <asp:ListItem>blue</asp:ListItem>
                    </asp:DropDownList>
                    <div class="color-varient add-color">
                    </div>
                    <button id="add-color-btn" type="button" class="button text-black py-0">Add</button>
                </div>
            </div>

            <!-- Images -->
            <div class="flex flex-wrap gap-2 mt-5 items-center">
                <div>Image : </div>
                <div>none</div>
                <div class="add-image">
                    <asp:FileUpload ID="fileImgUpload" CssClass="hidden" runat="server" accept=".png,.jpg,.jpeg,.webp" />
                    <i class="fa-regular fa-plus"></i>
                </div>
            </div>
        </div>
    </div>

    <script>
        //img upload
        (() => {
            const imgUpload = document.querySelector("#<%= fileImgUpload.ClientID %>");
            const imgUploadContainer = document.querySelector("#variation-form .add-image");

            imgUploadContainer.onclick = () => {
                imgUpload.click();
            }

            // validate the files type uploaded
            imgUpload.onchange = () => {
                validateFileUpload();
            }

            function validateFileUpload() {
                const FileUploadPath = imgUpload.value;

                //To check if user upload any file 
                if (FileUploadPath == '') {
                    alert("Please upload an image");
                } else {
                    const Extension = FileUploadPath.substring(
                        FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

                    //The file uploaded is an image
                    if (Extension == "webp" || Extension == "png"
                        || Extension == "jpeg" || Extension == "jpg") {

                        //// To Display
                        //if (fuData.files && fuData.files[0]) {
                        //    const reader = new FileReader();

                        //    reader.onload = function (e) {
                        //        document.getElementById('#blah');
                        //    }

                        //    reader.readAsDataURL(fuData.files[0]);
                        //}

                    }
                    //The file upload is NOT an image
                    else {
                        alert("Photo only allows file types of GIF, PNG, JPG, JPEG and BMP. ");
                    }
                }
            }
        })();

        //color choser
        (() => {
            const ddlColor = document.querySelector("#<%= ddlColor.ClientID %>");
            const addColorBtn = document.querySelector(".color-varient.add-color");
            addColorBtn.style.backgroundColor = `${ddlColor.value}`

            ddlColor.onchange = () => {
                addColorBtn.style.backgroundColor = `${ddlColor.value}`
            }
        })();
    </script>
</asp:Content>
