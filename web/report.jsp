<%-- 
    Document   : report
    Created on : Jan 3, 2015, 11:56:04 PM
    Author     : Nyein Su
--%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
User userLogin = (User) session.getAttribute("userLogin");

String userRole = userLogin.getRole();
boolean isSpecialist = false;
if(userRole.equals("Specialist") || userRole.equals("Associate")){
    isSpecialist = true;
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="css/bootstrap.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <link rel="stylesheet" href="css/jquery-ui-1.9.2.custom.css">
        <link rel="stylesheet" href="css/jquery-ui.structure.css">
        <link rel="stylesheet" href="css/jquery-ui.theme.css">
        <link rel="stylesheet" href="css/jasny-bootstrap.css"/>
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 

        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-ui-1.9.2.custom.js"></script>
        <script src="js/jquery.steps.js"></script>     
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script> 

        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>Camans</title>

        <style>
            .col-md-1{
                width:10vw;
            }
        </style>
        <script>
            $(document).ready(function(){
                //----validation for start date and end date----//
            $(".startDate").datepicker({
                dateFormat: 'dd-M-yy',
                changeMonth: true,
                changeYear: true,
                onClose: function(selectedDate) {
                    $(".endDate").datepicker("option", "minDate", selectedDate);
                }
            });
            $(".endDate").datepicker({
                dateFormat: 'dd-M-yy',
                changeMonth: true,
                changeYear: true,
                onClose: function(selectedDate) {

                    $(".startDate").datepicker("option", "maxDate", selectedDate);
                }
            });

            });
            

        </script>
    </head>
    <body id="report">
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>

        <div class="col-md-offset-2 col-md-10">
            <div class="page-header text-center">
                <h1>Reports</h1>
            </div>
            <br/>
            <h5 style="padding-left: 2%; color: gray">Please choose a report type and year to view reports.</h5><br/>
            <form method="POST" action="generateReport.do" id="report_generate_form" class="form col-sm-12">
                <div class="form-group col-md-12">
                    <label class="col-md-1" for="reportType">Report Type: </label>
                    <div class="col-md-3">
                        <select class="form-control" id="reportType" name="reportType" required> 
                            <option value="" disabled selected>Choose a report type..</option>
                            <option value ="Case Summary">Case Summary</option>
                            <option value ="Benefit Summary">Benefit Summary</option>
                            
                        </select>
                    </div>
                </div><br/><br/>
                
                <div class="form-group col-md-12">
                    <label class="col-md-1 text-right" for="start">From: </label>
                    <div class="col-md-3">
                        <input class="form-control startDate" type='text' name="start" required>
                    </div>
                    <label class="col-md-1 text-right" for="end">To: </label>
                    <div class="col-md-3">
                        <input type="text" class="form-control endDate" name="end" required/>
                    </div>
                </div>
                <button id="generateSubmitbtn" type="submit" class="btn btn-blue">Generate Report</button>

            </form>
        </div>
        <script>
            
        </script> 
    </body>
</html>
