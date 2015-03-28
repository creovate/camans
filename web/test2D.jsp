<%-- 
    Document   : test2D
    Created on : Feb 22, 2015, 2:46:04 PM
    Author     : Nyein Su
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
    <body>
        <h1>Hello World!</h1>
        
    </body>
</html>
