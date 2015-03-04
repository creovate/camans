<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--css-->
        <link rel="stylesheet" href="../css/bootstrap.css" media="screen" />
        <link rel="stylesheet" href="../css/custom.css" media="screen" /> 
        <!-------------->

        <!--javascript-->
        <script src="../js/jquery-2.1.1.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <!------------->

        <!--tab icon-->
        <link rel="shortcut icon" href="../img/twc_logo.png">

        <!--page title-->
        <title>CAMANS</title>


</head>
<body id="home">
    <!-- Nav Bar -->
    <jsp:include page="navbar.jsp"/>
    <!-- End of Nav Bar-->

    <!-- Search Box -->
    <div id="searchBox" class="col-xs-12 col-sm-offset-1 col-sm-10 col-md-offset-3 col-md-6">
        <br/>
        <h4 style="color:#006c9a">Search Worker by FIN</h4>

        <!-- Search Worker form-->
        <form class="form-inline" method="POST" action="../searchWorker.do">
            <div class="form-group col-xs-9">
                <input type="text" class="form-control" id="finNum" name="fin" placeholder="FIN Number" required>
            </div>
            <input type="hidden" name="associate" value="associate"/>
                <button type="submit" class="btn btn-blue col-xs-3">Search</button>
            
                
        </form>

    </div>
    <!-- End of Search Box -->

    <!-- Main Menu -->
    <div id="mainMenu" class="col-xs-12 col-sm-offset-1 col-sm-10 col-md-offset-3 col-md-6">
        <!-- First Row -->

        <!-- Second Row -->
    </div>
    <!-- End of Main Menu -->

</body>
</html>
