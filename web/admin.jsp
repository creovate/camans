<%--
    Document   : admin
    Created on : Jan 7, 2015, 4:22:18 PM
    Author     : soemyatmyat
--%>
<%@page import="camans.dao.ProblemDAO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int maxYear = ProblemDAO.getMaxYear();
    ArrayList<String> nationalityArr = DropdownDAO.retrieveAllDropdownListOfNationalities();
    ArrayList<String> jobSectorArr = DropdownDAO.retrieveAllDropdownListOfJobSector();
%>
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
                    <div id ="pageloading"><img id="loading-image" src="images/loading.gif"/></div>
                    <div class="col-md-6">
                        <div id="chartContainer" style="width:100%;height: 300px"></div><br/>
                        <div id="barChart" style="width:100%;height: 300px"></div>
                    </div>
                    <div class="col-md-6">
                        <div id="pieChart" style="width:100%;height: 300px"></div><br/>
                        <div id="hbarChart" style="width:100%;height: 300px"></div>
                    </div>
                </div>

            </div>
        
        </div>


        <script>
            //page loading gif
            
            $(window).load(function() {
                $('#pageloading').hide();
            });
              
            var firstdata;
            function myCallback(result) {
                firstdata = result;
            }

            getFirstData(myCallback);
            function getFirstData(callback) {
                $.ajax({
                    url: "dataRetrieval.do",
                    dataType: 'json',
                    success: callback,
                    async:   false
                })
            }


            var seconddata;
            function myCallback2(result2) {
                seconddata = result2;
            }

            getSecondData(myCallback2);
            function getSecondData(callback2) {
                $.ajax({
                    url: "dataRetrieval2.do",
                    dataType: 'json',
                    success: callback2,
                    async:   false
                })
            }
            
            var selectedYear = <%=maxYear%>,
            selectedNationalityIdx = 0,
            selectedNationality = "<%=nationalityArr.get(0)%>",
            selectedJobSector = "<%=jobSectorArr.get(0)%>";
            $("#chartContainer").dxChart({
                dataSource: firstdata,
                commonSeriesSettings: {
                    argumentField: 'year'
                },
                
                series: [
                    <%for (int i = 0; i< nationalityArr.size(); i++){%>
                        { valueField:"<%= nationalityArr.get(i)%>", name: "<%= nationalityArr.get(i)%>"},
                    <%}%>    
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
                    text: "Cases by Year",
                    font: {
                        size: "20px"
                    }
                },
                legend: {
                    horizontalAlignment: "bottom",
                    verticalAlignment: "top",
                    margin: 0,
                    font: {size: 8}
                    //visible: true
                },
                commonPaneSettings: {
                    border: {
                        visible: true
                    }
                },
                pointClick: function(clickedPoint, clickEvent){
                    selectedYear = clickedPoint.argument;
                    updateBarChart();
                    updatePieChart();
                    updateHBarChart();
                }
            });

            $("#barChart").dxChart({
                dataSource: seconddata[selectedYear],        
                series: {
                    argumentField: "Nationality",
                    valueField: "Total",
                    name: "Job Sectors",
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
                    text: "Cases by Nationality in " + selectedYear,
                    font: {
                        size: "20px"
                    }
                },
                commonPaneSettings: {
                    border: {
                        visible: true
                    }
                },
                rotated: true,
                legend: {
                    visible: false
                },
                pointClick: function(clickedPoint, clickEvent){
                    selectedNationality = clickedPoint.argument;
                    for (var i=0; i < seconddata[selectedYear].length; i++) {
                        if (seconddata[selectedYear][i]["Nationality"] === selectedNationality) {
                            selectedNationalityIdx = i;
                            break;
                        }
                    }
                    updatePieChart();
                }
            });

            $("#hbarChart").dxChart({
                dataSource: seconddata[selectedYear],
                animation: {
                    duration: 350
                },
                title: {
                    text: "Cases by " + selectedJobSector + " in " + selectedYear,
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
                argumentAxis: {
                    grid: {
                        visible: true
                    }
                },
                commonPaneSettings: {
                    border: {
                        visible: true
                    }
                },
                rotated: true,
                series: {
                    argumentField: "Nationality",
                    valueField: selectedJobSector,
                    name: "Job Sectors",
                    type: "bar",
                    color: '#333'
                }
            });


            $("#pieChart").dxPieChart({
                dataSource: getJobSectorByNationality(selectedYear, selectedNationalityIdx),
                series: [
                    {
                        type: "doughnut",
                        argumentField: "jobsector",
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
                    text: "Cases By " + selectedNationality + " in " + selectedYear,
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
                    selectedJobSector = clickedPoint.argument;
                    updateHBarChart();
                }
            });

            function getJobSectorByNationality(year, nationalityIdx) {
                var item = seconddata[year][nationalityIdx];
                //alert(item.toString());
                return [
                    /*
                    <%for (int i = 0; i< jobSectorArr.size(); i++){%>
                        { jobsector: "<%= jobSectorArr.get(i)%>", count: item.Cleaning},
                    <%}%>*/  
                    
                    {'jobsector': 'Cleaning', 'count': item.Cleaning},
                    {'jobsector': 'Construction', 'count': item.Construction},
                    {'jobsector': 'Domestic', 'count': item.Domestic},
                    {'jobsector': 'Landscaping', 'count': item.Landscaping},
                    {'jobsector': 'Manufacturing', 'count': item.Manufacturing},
                    {'jobsector': 'Marine', 'count': item.Marine},
                    {'jobsector': 'Process', 'count': item.Process},
                    {'jobsector': 'Services', 'count': item.Services},
                    {'jobsector': 'Nil', 'count': item.Nil},
                    {'jobsector': 'Other', 'count': item.Other}
                    
                ];
            }

            function updateBarChart() {
                var chart2 = $("#barChart").dxChart("instance");
                chart2.option({
                    dataSource: seconddata[selectedYear],
                    title: "Cases by Nationality in " + selectedYear
                });
            }

            function updatePieChart() {
                var chart3 = $("#pieChart").dxPieChart("instance");
                chart3.option({
                    dataSource: getJobSectorByNationality(selectedYear, selectedNationalityIdx),
                    title: "Cases by " + selectedNationality + " in " + selectedYear
                });
            }

            function updateHBarChart() {
                var chart4 = $("#hbarChart").dxChart("instance");
                chart4.option({
                    dataSource: seconddata[selectedYear],
                    title: "Cases by " + selectedJobSector + " in " + selectedYear,
                    series: {
                        valueField: selectedJobSector
                    }

                });
            }
            
            
        </script>
    </body>
</html>
