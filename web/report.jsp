<%-- 
    Document   : report
    Created on : Jan 3, 2015, 11:56:04 PM
    Author     : Nyein Su
--%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 

        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
        <script src="js/jquery.steps.js"></script>
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script> 
        
        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>Camans : Reports</title>
        
        <style>
            .col-md-1{
                width:10vw;
            }
        </style>
    </head>
    <body id="report">
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>

        <div class="col-md-10" id="content">
            <br/>
            <form method="POST" action="generateReport.do" class="form col-sm-12">
                    <label class="col-md-1" for="reportType">Report Type: </label>
                    <div class="col-md-3">
                        <select class="form-control" id="reportType" name="reportType"> 
                            <option disabled selected>Choose a report type..</option>
                            <option>Case Summary</option>
                            <option>Benefit Summary</option>
                        </select>
                    </div>
                    <label class="col-md-1 text-right" for="year">Year: </label>
                    <div class="col-md-3">
                        <select class="form-control" id="year" name="year"> 
                            <option disabled selected>Year..</option>
                            <option>2013</option>
                            <option>2014</option>
                            <option>2015</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-default">Generate Report</button>
            </form>
        </div>
        <script>
            //session time out
            $(document).ready(function () {
                $.sessionTimeout({
                    message: 'Your session will be expired in one minute.',
                    keepAliveUrl: 'keep-alive.html',
                    logoutUrl: 'index.jsp',
                    redirUrl: 'logout.jsp',
                    warnAfter: 900000,
                    redirAfter: 120000
                });
            });
        </script>        
    </body>
</html>
