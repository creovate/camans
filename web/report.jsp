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
        <!-- DataTables CSS, added by soemyatmyat -->
        <link rel="stylesheet" href="css/dataTables.bootstrap.css"/>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
        <!-- Bootstrap Validator CSS, Added by soemyatmyat -->
        <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
        <!--jasny-bootstrap v3.1.3, added by soemyatmayt-->
        <link rel="stylesheet" href="css/jasny-bootstrap.css"/>

        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
        <script src="js/jquery.steps.js"></script>
        <!-- DataTables JS, Added by soemyatmyat -->
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script> 
        <!-- BootstrapValidator JS, Added by soemyatmyat-->
        <script type="text/javascript" src="js/bootstrapValidator.min.js"></script>
        <!--jasny-bootstrap v3.1.3, added by soemyatmyat-->
        <script src="js/jasny-bootstrap.js"></script>  

        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>Camans : Reports</title>

        <style>
            .col-md-1{
                width:10vw;
            }
        </style>
        <script>
            //year dropdown
            $(document).ready(function() {
                for (i = new Date().getFullYear(); i > 2000; i--)
                {
                    $('#year').append($('<option />').val(i).html(i));
                }
            });
        </script>
    </head>
    <body id="report">
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>

        <div class="col-md-10" id="content">
            <br/>
            <form method="POST" action="generateReport.do" id="report_generate_form" class="form col-sm-12">
                <label class="col-md-1" for="reportType">Report Type: </label>
                <div class="col-md-3">
                    <select class="form-control" id="reportType" name="reportType" required> 
                        <option value="" disabled selected>Choose a report type..</option>
                        <option value ="Case Summary">Case Summary</option>
                        <option value ="Benefit Summary">Benefit Summary</option>
                    </select>
                </div>
                <label class="col-md-1 text-right" for="year">Year: </label>
                <div class="col-md-3">
                    <select class="form-control" id="year" name="year" required> 
                        <option value="" disabled selected>Year..</option>
                    </select>
                </div>
                <button id="generateSubmitbtn" type="submit" class="btn btn-default">Generate Report</button>
            </form>
        </div>
    </body>
</html>
