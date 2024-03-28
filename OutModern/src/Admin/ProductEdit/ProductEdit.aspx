<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="ProductEdit.aspx.cs" Inherits="OutModern.src.Admin.ProductEdit.ProductEdit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/tailwindcss">
        .button {
            @apply text-black text-center px-1 py-0 cursor-pointer hover:opacity-50 bg-gray-200 border border-gray-400;
        }

        #prod-edit-form #edit-from-item > div {
            @apply mt-1;
        }

        .desc-title {
            @apply inline-block w-28 float-left;
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

        <!-- General Desc -->
        <div id="prod-edit-form" class="mt-8">

            <div class="text-2xl font-bold">Edit Product</div>
            <div id="edit-from-item" class="mt-2 ml-2 text-xl">
                <div>
                    <span class="desc-title">Product ID</span>
                    <span>:
                        <asp:Label ID="lblProdId" runat="server" Text="P1001"></asp:Label>
                    </span>
                </div>
                <div>
                    <span class="desc-title">Product Name</span>
                    <span>:                        
                        <asp:TextBox ID="txtProdName" runat="server" Text="Premium Hoodie"></asp:TextBox>
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
                        <asp:TextBox ID="txtProdPrice" runat="server" Text="99.99"></asp:TextBox>
                    </span>
                </div>
                <div>
                    <span class="desc-title">Status</span>
                    <span>:
                        <asp:DropDownList ID="ddlProdStatus" AppendDataBoundItems="true" runat="server">
                            <asp:ListItem>In Stock</asp:ListItem>
                            <asp:ListItem>Unavailable</asp:ListItem>
                            <asp:ListItem>Out of Stock</asp:ListItem>
                        </asp:DropDownList>
                    </span>
                </div>
            </div>
        </div>

        <!-- Variation -->
        <div id="variation-form">
            <div class="text-2xl font-[600]">Variation</div>

            <div class="flex mt-2 items-center">
                <!--Size selection-->
                <div>Size : <span class="size-added">S</span></div>
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
                    <asp:TextBox CssClass="w-20" TextMode="Number" ID="txtProdQuantity" runat="server" Text="123"></asp:TextBox>
                </span>
            </div>
            <!--Colors-->
            <%-- 
                Beige, black, white, 
                blue, lightblue, darkblue, navy
                lightgray,  
                militaryGreen ==> darkolivegreen
                red
            --%>
            <div class="flex mt-2 items-center">
                <div class="flex gap-2 justify-center items-center">
                    <div>Colors :</div>
                    <div data-color="white" class="color-varient bg-white"></div>
                    <div data-color="black" class="color-varient bg-black"></div>
                    <div data-color="beige" class="color-varient active bg-[#E0CCBC]"></div>
                </div>
                <!--Choose color-->
                <div class="flex ml-20 gap-2 justify-center items-center">
                    <div>
                        Add Color : 
                    </div>
                    <asp:DropDownList ID="ddlColor" runat="server">
                        <asp:ListItem>navy</asp:ListItem>
                        <asp:ListItem>green</asp:ListItem>
                        <asp:ListItem>blue</asp:ListItem>
                    </asp:DropDownList>
                    <div class="color-varient add-color"></div>
                    <asp:Button ID="btnAddColor" CssClass="button" runat="server" Text="Add" />
                </div>
            </div>

            <!-- Images -->
            <div class="flex flex-wrap gap-2 mt-5 items-center">
                <div>Image : </div>
                <asp:Image ID="imgProd1" runat="server" Width="10em"
                    CssClass="product-img"
                    ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png" />
                <asp:Image ID="imgProd2" runat="server" Width="10em"
                    CssClass="product-img"
                    ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de644282.png" />
                <asp:Image ID="imgProd3" runat="server" Width="10em"
                    CssClass="product-img"
                    ImageUrl="~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-zoomed-in-61167de6440a2.png" />
                <div class="add-image">
                    <asp:FileUpload ID="fileImgUpload" CssClass="hidden" runat="server" accept=".png,.jpg,.jpeg,.webp" />
                    <i class="fa-regular fa-plus"></i>
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
