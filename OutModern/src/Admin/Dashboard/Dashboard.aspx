<%@ Page Title="" Language="C#" MasterPageFile="~/src/Admin/AdminMaster/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="OutModern.src.Admin.Dashboard.Dashboard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/tailwindcss">
        @layer components {
            .dashboard-item-container {
                @apply w-48;
            }

                .dashboard-item-container .dashboard-item {
                    @apply bg-gray-200 drop-shadow rounded-2xl p-4 mt-4;
                }

                    .dashboard-item-container .dashboard-item .text > * {
                        @apply text-2xl font-bold font-black;
                    }
        }
    </style>

    <script src='<%# Page.ResolveClientUrl("~/lib/highcharts/highcharts.js") %>'></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Genaral Data -->
    <div class="flex gap-8">
        <!--Customer-->
        <div class="dashboard-item-container">
            <div class="dashboard-item">
                <div class="title">
                    Total Customer
                </div>
                <div class="text">
                    <asp:Label ID="lblTotalCustomer" runat="server" Text="120 000"></asp:Label>
                </div>
            </div>
            <div class="dashboard-item">
                <div class="title">
                    New Customer
                </div>
                <div class="text">
                    <asp:Label ID="lblNewCustomer" runat="server" Text="12"></asp:Label>
                </div>
            </div>
        </div>

        <!--Orders-->
        <div class="dashboard-item-container">
            <div class="dashboard-item">
                <div class="title">
                    This month Orders
                </div>
                <div class="text">
                    <asp:Label ID="lblMonthOrders" runat="server" Text="12 000"></asp:Label>
                </div>
            </div>
            <div class="dashboard-item">
                <div class="title">
                    New Orders
                </div>
                <div class="text">
                    <asp:Label ID="Label2" runat="server" Text="45"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Cancelled -->
        <div class="dashboard-item-container">
            <div class="dashboard-item">
                <div class="title">
                    This month Cancelled
                </div>
                <div class="text">
                    <asp:Label ID="Label1" runat="server" Text="120"></asp:Label>
                </div>
            </div>
            <div class="dashboard-item">
                <div class="title">
                    Today Cancelled
                </div>
                <div class="text">
                    <asp:Label ID="Label3" runat="server" Text="3"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Review Pending Reply -->
        <div class="dashboard-item-container">
            <div class="dashboard-item">
                <div class="title">
                    New Review
                </div>
                <div class="text">
                    <asp:Label ID="Label4" runat="server" Text="12"></asp:Label>
                </div>
            </div>
            <div class="dashboard-item">
                <div class="title">
                    Overall Rating
                </div>
                <div class="text">
                    <asp:Label ID="Label5" runat="server" Text="4.9"></asp:Label>
                </div>
            </div>
        </div>
    </div>

    <!--Charts-->
    <div class="mt-10 overflow-hidden">
        <div id="sales-chart" class="w-[60%] float-left">
        </div>
        <div id="sales-chart-category" class="w-[40%] float-right">
        </div>
    </div>


    <script>
        //Overall Sales chart

        (() => {

            Highcharts.chart('sales-chart', {
                chart: {
                    type: 'line' // Set chart type as line
                },
                title: {
                    text: 'Sales In One Year' // Chart title
                },
                xAxis: {
                    title: { // Label for X-axis
                        text: 'Months'
                    },
                    type: 'datetime',
                    labels: {
                        formatter: function () {
                            let date = new Date(this.value);
                            return Highcharts.dateFormat("%b %Y", date);
                        }
                    }
                },
                yAxis: {
                    title: { // Label for Y-axis
                        text: ''
                    }
                },
                series: [{ // Define data series
                    name: 'Sales', // Series name
                    data: <%= lineData %> // Replace with your generated data array
                }]
            });

        })();

        // Pie chart, sales for each category
        (() => {
            Highcharts.chart('sales-chart-category', {
                chart: {
                    type: 'pie', // Set chart type as line
                },
                title: {
                    text: 'Total Sales By Category' // Chart title
                },
                tooltip: {
                    valueSuffix: '%'
                }, plotOptions: {
                    series: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: [{
                            enabled: true,
                            distance: 20
                        },
                        {
                            enabled: true,
                            distance: -40,
                            format: '{point.percentage:.1f}%',
                            style: {
                                fontSize: '1.2em',
                                textOutline: 'none',
                                opacity: 0.7
                            },
                            filter: {
                                operator: '>',
                                property: 'percentage',
                                value: 10
                            }
                        }]
                    }
                },
                series: [{ // Define data series
                    name: 'Sold',
                    colorByPoint: true,
                    data: [
                        { name: "Hoodie", y: 14 },
                        { name: "Shorts", y: 38 },
                        { name: "Sweater", y: 24 },
                        { name: "Tee Shirt", y: 26 },
                    ]// Replace with your generated data array
                }]
            });
        })();

    </script>
</asp:Content>
