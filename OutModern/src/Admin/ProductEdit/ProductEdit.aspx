<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="ProductEdit.aspx.cs" Inherits="OutModern.src.Admin.ProductEdit.ProductEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        .button {
            @apply text-black text-center px-1 py-0 cursor-pointer hover:opacity-50 bg-gray-200 border border-gray-400;
        }

        /*Edit form*/
        #edit-form {
            @apply w-56;
        }

            #edit-form .edit-section {
                @apply mt-2 ml-2;
            }

            #edit-form .edit-label {
                @apply font-[600];
            }

            #edit-form .edit-item {
                @apply block px-4 py-1 border border-gray-600 rounded;
            }

                #edit-form .edit-item.disabled {
                    @apply text-gray-400 border-gray-300;
                }

        /*Variation*/
        #variation-form {
            @apply mb-10 ml-2 mt-10;
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



        .color-varient {
            @apply cursor-pointer size-5 rounded-full border drop-shadow border-gray-300 box-border hover:opacity-50;
        }

            .color-varient.active {
                @apply outline outline-black outline-1 hover:opacity-100;
            }


            .color-varient.add-color {
                @apply outline outline-black outline-1 cursor-default hover:opacity-100;
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
                ID="lbDiscard" runat="server" OnClick="lbDiscard_Click">
                <i class="fa-regular fa-trash"></i>  
                Discard Change
            </asp:LinkButton>

            <!--Update btn-->
            <asp:LinkButton
                OnClientClick="return confirm('Are you sure you want to update?')"
                OnClick="lbUpdate_Click"
                CssClass="text-white p-2 rounded bg-green-500 hover:opacity-50"
                ID="lbUpdate" runat="server" NavigateUrl='#'>
                 <i class="fa-regular fa-pen-to-square"></i>
                 Update
            </asp:LinkButton>
        </div>

        <div class="text-2xl font-bold mt-8">Edit Product</div>

        <div class="">
            <!-- Prod Desc -->
            <div id="edit-form" class="mt-4">

                <!--Prod ID-->
                <div class="edit-section">
                    <div class="edit-label">Prodcut ID</div>
                    <div>
                        <asp:Label ID="lblProdId" CssClass="edit-item disabled" runat="server" Text="P1001"></asp:Label>
                    </div>
                </div>

                <!--Prod NAme-->
                <div class="edit-section">
                    <div class="edit-label">Prodcut Name</div>
                    <div>
                        <asp:TextBox ID="txtProdName" CssClass="edit-item" runat="server" Text="Premium Hoodie"></asp:TextBox>
                    </div>
                </div>

                <!--Prod Category-->
                <div class="edit-section">
                    <div class="edit-label">Category</div>
                    <div>
                        <asp:DropDownList ID="ddlCategory" CssClass="edit-item" runat="server">
                            <asp:ListItem>Hoodie</asp:ListItem>
                            <asp:ListItem>Tee Shirt</asp:ListItem>
                            <asp:ListItem>Shorts</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <!--Prod Price-->
                <div class="edit-section">
                    <div class="edit-label">Price (RM)</div>
                    <div>
                        <asp:TextBox ID="txtPrice" CssClass="edit-item" runat="server" Text="99.99"></asp:TextBox>

                    </div>
                </div>

                <!--Prod Status-->
                <div class="edit-section">
                    <div class="edit-label">Status</div>
                    <div>
                        <asp:DropDownList ID="ddlStatus" CssClass="edit-item" runat="server">
                            <asp:ListItem>In Stock</asp:ListItem>
                            <asp:ListItem>Unavailable</asp:ListItem>
                            <asp:ListItem>Out Of Stock</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
            </div>

            <!-- Variation -->
            <div id="variation-form">
                <div class="text-2xl font-[600]">Variation</div>

                <!--Size and quantity-->
                <div class="flex mt-4 items-center gap-7">

                    <!--Size selection-->
                    <div>
                        <div class="font-[600]">Size</div>
                        <div>
                            <asp:DropDownList ID="ddlSize" runat="server">
                                <asp:ListItem>S</asp:ListItem>
                                <asp:ListItem>M</asp:ListItem>
                                <asp:ListItem>L</asp:ListItem>
                                <asp:ListItem>XL</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="">
                        <div class="font-[600]">Quantity</div>
                        <div>
                            <asp:TextBox CssClass="w-16" TextMode="Number" ID="txtProdQuantity" runat="server" Text="123"></asp:TextBox>
                        </div>
                    </div>

                    <div class="opacity-50 mt-4">
                        **Specify quantity for each size
                    </div>
                </div>

                <!--Colors-->
                <div class=" mt-4">
                    <div class="flex gap-7 items-center">
                        <div class="font-[600]">Colors </div>
                        <!--Add color-->
                        <div class="flex gap-2 items-center">
                            <asp:DropDownList ID="ddlColor" runat="server">
                                <asp:ListItem>navy</asp:ListItem>
                                <asp:ListItem>green</asp:ListItem>
                                <asp:ListItem>blue</asp:ListItem>
                            </asp:DropDownList>
                            <div class="color-varient add-color"></div>
                            <asp:Button ID="btnAddColor" CssClass="button" runat="server" Text="Add" />
                        </div>

                    </div>
                    <!--Color selection-->
                    <div class="flex gap-2 items-center">
                        <asp:Button ID="btnColor1" Style="background: black;" CssClass="color-varient" runat="server" Text="" />
                        <asp:Button ID="btnColor2" Style="background: white;" CssClass="color-varient" runat="server" Text="" />
                        <asp:Button ID="btnColor3" Style="background: beige;" CssClass="color-varient active" runat="server" Text="" />
                    </div>
                </div>

                <!-- Images -->
                <div class="mt-5 ">
                    <div class="font-[600]">Image : </div>
                    <div class="flex items-center">
                        <div class="flex flex-wrap gap-2 items-center">
                            <asp:Image ID="imgProd1" runat="server" Width="10em"
                                CssClass="product-img"
                                ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png" />
                            <asp:Image ID="imgProd2" runat="server" Width="10em"
                                CssClass="product-img"
                                ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de644282.png" />
                            <asp:Image ID="imgProd3" runat="server" Width="10em"
                                CssClass="product-img"
                                ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-zoomed-in-61167de6440a2.png" />
                        </div>
                        <div class="add-image">
                            <asp:FileUpload ID="fileImgUpload" CssClass="hidden" runat="server" accept=".png,.jpg,.jpeg,.webp" />
                            <i class="fa-regular fa-plus"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>

        //img upload
        (function () {
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
                }
                else {
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
