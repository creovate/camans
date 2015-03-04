<%--
    Document   : admin
    Created on : Jan 7, 2015, 4:22:18 PM
    Author     : soemyatmyat
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HashMap<String, ArrayList<String>> errList = (HashMap<String, ArrayList<String>>) request.getSession().getAttribute("bootstrapResult");
    request.getSession().removeAttribute("bootstrapResult");
    HashMap<String, Integer> successList = (HashMap<String, Integer>) request.getSession().getAttribute("successList");
    request.getSession().removeAttribute("successList");
    String error = (String) request.getSession().getAttribute("error");
    request.getSession().removeAttribute("error");
%>
<!DOCTYPE html>
<style>
    

.chart div {
  font: 10px sans-serif;
  background-color: steelblue;
  text-align: right;
  padding: 3px;
  margin: 1px;
  color: white;
}


</style>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
          
        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>         
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script> 
        <!--ChartJS library, added by soemyatmyat-->
        <script src="js/dx.chartjs.js"></script>
        <script src="js/globalize.min.js"></script>
        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>CAMANS</title>
    </head>
    <body id="admin">
        <jsp:include page="include/navbartop.jsp"/>
        <div class="row-offcanvas row-offcanvas-left">
            <jsp:include page="include/navbarside.jsp"/>
            <div class="col-md-offset-2 col-md-10">

                <!-- Page Header 
                <div class="page-header">
                    <center><h2>Admin Dashboard</h2>
                </div>  -->
                <!-- end of page header -->
                <br/>
                <div class="row">
                    <div class="col-md-7">
                    <div id="chartContainer" style="width:100%;height: 300px"></div><br/>
                    <div id="barChart" style="width:100%;height: 300px"></div>
                    </div>
                    <div class="col-md-5">
                    <div id="pieChart" style="width:100%;height: 300px"></div><br/>
                    <div id="hbarChart" style="width:100%;height: 300px"></div>
                    </div>
                </div>

            </div>
        
        </div>


        <script>
            
            //alert(firstdata);
            var firstdata;
            function myCallback(result) {
                firstdata = result;
            }
            
            getFirstData(myCallback);
            function getFirstData(callback) {
                $.ajax({
                    url: "dataRetrieval.do",
                    dataType: 'json',
                    success: callback
                })
            }
            
            var seconddata;
            function myCallback2(result2) {
                seconddata = result2;
                alert("IN2nd:" + seconddata);
            }
            
            getSecondData(myCallback2);
            function getSecondData(callback2) {
                $.ajax({
                    url: "dataRetrieval2.do",
                    dataType: 'json',
                    success: callback2 
                })
            }
            
            alert("Data Loading Complete!");
            alert("1stSet:" + firstdata);
            alert("2ndSet:" + seconddata);
                        
var summary = [
    {"year": "1994", "Canada": 13, "Germany": 22, "Norway": 26, "Russia": 23, "USA": 13},
    {"year": "1998", "Canada": 15, "Germany": 27, "Norway": 25, "Russia": 14, "USA": 13},
    {"year": "2002", "Canada": 17, "Germany": 34, "Norway": 25, "Russia": 13, "USA": 34},
    {"year": "2006", "Canada": 24, "Germany": 28, "Norway": 19, "Russia": 20, "USA": 25},
    {"year": "2010", "Canada": 26, "Germany": 30, "Norway": 23, "Russia": 15, "USA": 37}
];            
var results = {};
results["1994"] =

    [
        {
            "Country": "Canada",
            "Gold": 3,
            "Silver": 6,
            "Bronze": 4,
            "Total": 13
        },
        {
            "Country": "Germany",
            "Gold": 8,
            "Silver": 7,
            "Bronze": 7,
            "Total": 22
        },
        {
            "Country": "Norway",
            "Gold": 10,
            "Silver": 11,
            "Bronze": 5,
            "Total": 26
        },
        {
            "Country": "Russia",
            "Gold": 11,
            "Silver": 8,
            "Bronze": 4,
            "Total": 23
        },
        {
            "Country": "USA",
            "Gold": 6,
            "Silver": 5,
            "Bronze": 2,
            "Total": 13
        }
    ];

results["1998"] =

    [
        {
            "Country": "Canada",
            "Gold": 6,
            "Silver": 5,
            "Bronze": 4,
            "Total": 15
        },
        {
            "Country": "Germany",
            "Gold": 11,
            "Silver": 8,
            "Bronze": 8,
            "Total": 27
        },
        {
            "Country": "Norway",
            "Gold": 10,
            "Silver": 10,
            "Bronze": 5,
            "Total": 25
        },
        {
            "Country": "Russia",
            "Gold": 7,
            "Silver": 5,
            "Bronze": 2,
            "Total": 14
        },
        {
            "Country": "USA",
            "Gold": 6,
            "Silver": 3,
            "Bronze": 4,
            "Total": 13
        }
    ];


results["2002"] =

    [
        {
            "Country": "Canada",
            "Gold": 7,
            "Silver": 3,
            "Bronze": 7,
            "Total": 17
        },
        {
            "Country": "Germany",
            "Gold": 10,
            "Silver": 16,
            "Bronze": 8,
            "Total": 34
        },
        {
            "Country": "Norway",
            "Gold": 13,
            "Silver": 5,
            "Bronze": 7,
            "Total": 25
        },
        {
            "Country": "Russia",
            "Gold": 5,
            "Silver": 4,
            "Bronze": 4,
            "Total": 13
        },
        {
            "Country": "USA",
            "Gold": 10,
            "Silver": 13,
            "Bronze": 11,
            "Total": 34
        },
    ];

results["2006"] =

    [
        {
            "Country": "Canada",
            "Gold": 7,
            "Silver": 10,
            "Bronze": 7,
            "Total": 24
        },
        {
            "Country": "Germany",
            "Gold": 11,
            "Silver": 11,
            "Bronze": 6,
            "Total": 28
        },
        {
            "Country": "Norway",
            "Gold": 2,
            "Silver": 8,
            "Bronze": 9,
            "Total": 19
        },
        {
            "Country": "Russia",
            "Gold": 8,
            "Silver": 6,
            "Bronze": 6,
            "Total": 20
        },
        {
            "Country": "USA",
            "Gold": 9,
            "Silver": 9,
            "Bronze": 7,
            "Total": 25
        }
    ];


results["2010"] =
    [
        {
            "Country": "Canada",
            "Gold": 14,
            "Silver": 7,
            "Bronze": 5,
            "Total": 26
        },
        {
            "Country": "Germany",
            "Gold": 10,
            "Silver": 13,
            "Bronze": 7,
            "Total": 30
        },
        {
            "Country": "Norway",
            "Gold": 9,
            "Silver": 8,
            "Bronze": 6,
            "Total": 23
        },
        {
            "Country": "Russia",
            "Gold": 3,
            "Silver": 5,
            "Bronze": 7,
            "Total": 15
        },
        {
            "Country": "USA",
            "Gold": 9,
            "Silver": 15,
            "Bronze": 13,
            "Total": 37
        }
    ];
    alert("Results:" + results);

        var selectedYear = "2010",
        selectedCountryIdx = 0,
        selectedCountry = "USA",
        selectedMedalType = "Gold";
        
        $("#chartContainer").dxChart({
            dataSource: summary,
            commonSeriesSettings: {
                argumentField: 'year'
            },
            series: [
                /*
                { valueField: "Bangladesh", name: "Bangladesh" },
                { valueField: "China", name: "China" },
                { valueField: "Malaysia", name: "Malaysia" },
                { valueField: "Cambodia", name: "Cambodia" },
                { valueField: "Vietnam", name: "Vietnam" },
                { valueField: "India", name: "India" },
                { valueField: "Sri Lanka", name: "Sri Lanka" },
                { valueField: "Indonesia", name: "Indonesia" },
                { valueField: "Other", name: "Other" },
                { valueField: "Thailand", name: "Thailand" },
                { valueField: "Philippines", name: "Philippines" },
                { valueField: "Myanmar", name: "Myanmar" }
                */
                { valueField: "Canada", name: "Canada" },
                { valueField: "Germany", name: "Germany" },
                { valueField: "Norway", name: "Norway" },
                { valueField: "Russia", name: "Russia" },
                { valueField: "USA", name: "USA" }
            ],
            argumentAxis: {
                grid: {
                    visible: true
                }
            },
            tooltip: {
                enabled: true
            },
            title: {
                text: "Total Cases by Year",
                font: {
                    size: "20px"
                }
            },
            legend: {
                horizontalAlignment: "right",
                verticalAlignment: "top",
                margin: 0
            },
            commonPaneSettings: {
                border: {
                    visible: true
                }
            },
            pointClick: function(clickedPoint, clickEvent){
                selectedYear = clickedPoint.argument.substr(0,4);
                alert(selectedYear);
                updateBarChart();
                updatePieChart();
                updateHBarChart();
            }
        });

        $("#barChart").dxChart({
            dataSource: results[selectedYear],
            series: {
                argumentField: "Country",
                valueField: "Total",
                name: "Medals",
                type: "bar",
                color: '#4C98B8'
            },
            argumentAxis: {
                grid: {
                    visible: true
                }
            },
            tooltip: {
                enabled: true
            },
            title: {
                text: "Total Cases by Nationality in " + selectedYear,
                font: {
                    size: "20px"
                }
            },
            commonPaneSettings: {
                border: {
                    visible: true
                }
            },
            legend: {
                visible: false
            },
            pointClick: function(clickedPoint, clickEvent){
                selectedCountry = clickedPoint.argument;
                for (var i=0; i < results[selectedYear].length; i++) {
                    if (results[selectedYear][i]["Country"] === selectedCountry) {
                        selectedCountryIdx = i;
                        break;
                    }
                }
                updatePieChart();
            }
        });
        
        $("#pieChart").dxPieChart({
            dataSource: getTypeByCountry(selectedYear, selectedCountryIdx),
            series: [
                {
                    type: "doughnut",
                    argumentField: "type",
                    valueField: "count",
                    label: {
                        visible: true,
                        connector: {
                            visible: true
                        }
                    }
                }
            ],
            argumentAxis: {
                grid: {
                    visible: true
                }
            },
            tooltip: {
                enabled: true
            },
            title: {
                text: "Cases By Job Sector",
                font: {
                    size: "20px"
                }
            },
            legend: {
                horizontalAlignment: "right",
                verticalAlignment: "top",
                margin: 0
            },
            pointClick: function(clickedPoint, clickEvent){
                console.log(clickedPoint);
                selectedMedalType = clickedPoint.argument;
                updateHBarChart();
            }
        });

        $("#hbarChart").dxChart({
            dataSource: results[selectedYear],
            animation: {
                duration: 350
            },
            title: {
                text: "Total Cases by " + selectedMedalType + " in " + selectedYear,
                font: {
                    size: "20px"
                }
            },
            tooltip: {
                enabled: true
            },
            legend: {
                visible: false
            },
            rotated: true,
            series: {
                argumentField: "Country",
                valueField: selectedMedalType,
                name: "Medals",
                type: "bar",
                color: '#333'
            }
        });


        function getTypeByCountry(year, countryIdx) {
            var item = results[year][countryIdx];
            return [
                {'type': 'Gold', 'count': item.Gold},
                {'type': 'Silver', 'count': item.Silver},
                {'type': 'Bronze', 'count': item.Bronze}
            ];
        }
        
        function updateBarChart() {
            var chart2 = $("#barChart").dxChart("instance");
            chart2.option({
                dataSource: results[selectedYear],
                title: "Total Cases by Nationality in " + selectedYear
            });
        }

        function updatePieChart() {
            var chart3 = $("#pieChart").dxPieChart("instance");
            chart3.option({
                dataSource: getTypeByCountry(selectedYear, selectedCountryIdx),
                title: " Total Cases by " + selectedCountry + " in " + selectedYear
            });
        }

        function updateHBarChart() {
            var chart4 = $("#hbarChart").dxChart("instance");
            chart4.option({
                dataSource: results[selectedYear],
                title: "Total Cases by " + selectedMedalType + " in " + selectedYear,
                series: {
                    valueField: selectedMedalType
                }

            });
        }
        </script>
    </body>
</html>
