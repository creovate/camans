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
        
        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>CAMANS</title>
    </head>
    <body id="admin">
        <jsp:include page="include/navbartop.jsp"/>
        <div class="row-offcanvas row-offcanvas-left">
            <jsp:include page="include/navbarside.jsp"/>
            <div class="col-md-offset-2 col-md-10">

                <!-- Page Header -->
                <div class="page-header">
                <center><h2>Admin Dashboard</h2>   
                </div>
                <!-- end of page header -->

                <div class="row">

                </div>

            </div>
        
        </div>


        <script>
            //session time out
            $(document).ready(function () {
                $.sessionTimeout({
                    message: 'Your session will be expired in five minutes.',
                    keepAliveUrl: 'keep-alive.html',
                    logoutUrl: 'logout.jsp',
                    redirUrl: 'logout.jsp',
                    warnAfter: 900000, //15 minutes
                    redirAfter: 1200000 // 20 minutes
                });
            });
        </script>
    </body>
</html>
