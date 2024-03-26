using System;
using System.Collections.Generic;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OutModern.src.Admin.ProductDetails
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        protected static readonly string ProductEdit = "ProductEdit";
        protected static readonly string ProductReviewReply = "ProductReviewReply";

        // Side menu urls
        protected Dictionary<string, string> urls = new Dictionary<string, string>()
        {
            { ProductEdit , "~/src/Admin/ProductEdit/ProductEdit.aspx" },
            { ProductReviewReply , "~/src/Admin/ProductReviewReply/ProductReviewReply.aspx" }

        };
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lvReviews.DataSource = GetReviewList();
                lvReviews.DataBind();

                Page.DataBind();
            }
            repeaterColors.DataSource = GetColor();
            repeaterColors.DataBind();

            repeaterImg.DataSource = GetBeigeImg();
            repeaterImg.DataBind();
        }

        private List<ReviewData> GetReviewList()
        {
            List<ReviewData> reviewList = new List<ReviewData>
                {
                    new ReviewData
                    {
                        CustomerName = "Customer A",
                        ReviewTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm"), // Format for display
                        ReviewRating = 3.0,
                        ReviewColor = "white",
                        ReviewQuantity = 1,
                        ReviewText = "This has problems!",
                        Replies = new List<ReplyData>()
                        {
                            new ReplyData {
                                AdminName = "Gan",
                                AdminRole = "Admin",
                                ReplyTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm"),
                                ReplyText = "Hi, please edit your question..." },
                            new ReplyData {
                                AdminName = "Su",
                                AdminRole = "Associate",
                                ReplyTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm"),
                                ReplyText = "This should not be a problem" }
                        }
                    },
                    new ReviewData // Add more reviews with replies
                    {
                        CustomerName = "Customer B",
                        ReviewTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm"), // Format for display
                        ReviewRating = 4.0,
                        ReviewColor = "black",
                        ReviewQuantity = 3,
                        ReviewText = "This is amazing!",
                        //Replies = new List<ReplyData>()
                        //    {
                        //        new ReplyData {
                        //            ReplyBy = "Manager",
                        //            ReplyTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm"),
                        //            ReplyText = "Thanks!" }
                        //    }
                    },
                    new ReviewData
                    {
                        CustomerName = "Customer C",
                        ReviewTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm"), // Format for display
                        ReviewRating = 3.0,
                        ReviewColor = "white",
                        ReviewQuantity = 1,
                        ReviewText = "This is review 3",
                        Replies = new List<ReplyData>()
                        {
                            new ReplyData {
                                AdminName = "Staff C",
                                AdminRole = "Manager",
                                ReplyTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm"),
                                ReplyText = "Thanks for rating!" }
                        }
                    },
                    new ReviewData // Add more reviews with replies
                    {
                        CustomerName = "Customer D",
                        ReviewTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm"), // Format for display
                        ReviewRating = 4.0,
                        ReviewColor = "black",
                        ReviewQuantity = 3,
                        ReviewText = "Test Review",
                        Replies = new List<ReplyData>()
                            {
                                new ReplyData {
                                    AdminName = "Staff D",
                                    AdminRole = "Some position",
                                    ReplyTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm"),
                                    ReplyText = "This is a reply"
                                }
                            }
                    }
                };
            return reviewList;
        }

        private List<ImageData> GetBeigeImg()
        {
            List<ImageData> list = new List<ImageData>(){
                new ImageData{
                    ImageId = "123",
                    path = "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de6441b1.png"
                },
                new ImageData{
                    ImageId = "123",
                    path = "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-front-61167de644282.png"
                },
                new ImageData{
                    ImageId = "123",
                    path = "~/images/product-img/hoodies/beige-Hoodie/unisex-sueded-fleece-hoodie-heather-oat-zoomed-in-61167de6440a2.png"
                }
            };

            return list;
        }

        private List<ImageData> GetBlackImg()
        {
            List<ImageData> list = new List<ImageData>(){
                new ImageData{
                    ImageId = "123",
                    path = "~/images/product-img/hoodies/black-Hoodie/all-over-print-unisex-hoodie-white-front-611679bab7dfd.png"
                },
                new ImageData{
                    ImageId = "123",
                    path = "~/images/product-img/hoodies/black-Hoodie/all-over-print-unisex-hoodie-white-front-611679bab7dfd.png"

                },
                new ImageData{
                    ImageId = "123",
                    path = "~/images/product-img/hoodies/black-Hoodie/all-over-print-unisex-hoodie-white-front-611679bab7dfd.png"

                }
            };

            return list;
        }

        private List<ColorData> GetColor()
        {
            List<ColorData> list = new List<ColorData>()
            {
                new ColorData
                {
                    Color="Beige"
                },
                new ColorData
                {
                    Color="White"
                },
                new ColorData
                {
                    Color="Black"
                }
            };

            return list;
        }

        public class ReviewData
        {
            public string CustomerName { get; set; }
            public string ReviewTime { get; set; } // Consider using DateTime for formatting
            public double ReviewRating { get; set; } // Consider using DateTime for formatting
            public string ReviewColor { get; set; } // Consider using DateTime for formatting
            public int ReviewQuantity { get; set; } // Consider using DateTime for formatting
            public string ReviewText { get; set; }
            public List<ReplyData> Replies { get; set; }
        }

        public class ReplyData
        {
            public string AdminName { get; set; }
            public string AdminRole { get; set; }

            public string ReplyTime { get; set; } // Consider using DateTime for formatting
            public string ReplyText { get; set; }
        }

        public class ColorData
        {
            public string Color { get; set; } // Consider using DateTime for formatting
        }

        public class ImageData
        {
            public string ImageId { get; set; }
            public string path { get; set; }
        }

        protected void lvReviews_PagePropertiesChanged(object sender, EventArgs e)
        {
            bindData();
        }

        private void bindData()
        {
            lvReviews.DataSource = GetReviewList();
            lvReviews.DataBind();

            repeaterColors.DataSource = GetColor();
            repeaterColors.DataBind();

            repeaterImg.DataSource = GetBeigeImg();
            repeaterImg.DataBind();
        }

        protected void repeaterColors_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "ChangeColor")
            {
                // Remove active class
                foreach (RepeaterItem item in repeaterColors.Items)
                {
                    var button = item.FindControl("btnColor") as Button; // Replace with your button ID
                    if (button != null)
                    {
                        button.CssClass = button.CssClass.Replace(" active", ""); // Remove "active"
                    }
                }

                Button btn = (Button)e.CommandSource;
                btn.CssClass += " active";

                if (e.CommandArgument.ToString() == "Black")
                {
                    repeaterImg.DataSource = GetBlackImg();
                }
                else if (e.CommandArgument.ToString() == "Beige")
                {
                    repeaterImg.DataSource = GetBeigeImg();

                }
            }
            repeaterImg.DataBind();

            lvReviews.DataSource = GetReviewList();
            lvReviews.DataBind();

        }



        protected void repeaterColors_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
        }
    }
}

