<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="../protect.jsp"%>
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
        <style>
            #folderImg{
                height: 20vw;
                
                margin-bottom: 4%;
            }
            
            #mainMenu{
                padding : 5% 5%;
            }
            .menu_icon{
                padding: 2%;
            }
        </style>

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
<br/>
    <!-- Main Menu -->
    <div id="mainMenu" class="col-xs-12 col-sm-offset-1 col-sm-10 col-md-offset-3 col-md-6">
        <h4 style="color:#006c9a">Review</h4>
        <!-- First Row -->
        <div class="col-xs-4 menu_icon text-center">
            <a href="addNew.jsp?option=createCase"><img class="img-responsive center-block" src="../img/meal.png" id="folderImg"/></a>
            <label style="font-size: small;">Meal Cards</label>
        </div>
        <div class="col-xs-4 menu_icon text-center">
            <a href="addNew.jsp?option=createCase"><img class="img-responsive center-block" src="../img/farego.png" id="folderImg"/></a>
            <label style="font-size: small;">FareGo</label>
        </div>
        <div class="col-xs-4 menu_icon text-center">
            <a href="addNew.jsp?option=createCase"><img class="img-responsive center-block" src="../img/med.png" id="folderImg"/></a>
            <label style="font-size: small;">Medical</label>
        </div>
        <!-- Second Row -->
        <div class="col-xs-4 menu_icon text-center">
            <a href="addNew.jsp?option=createCase"><img class="img-responsive center-block" src="../img/roof.png" id="folderImg"/></a>
            <label style="font-size: small;">Roof</label>
        </div>
        <div class="col-xs-4 menu_icon text-center">
            <a href="addNew.jsp?option=createCase"><img class="img-responsive center-block" src="../img/r2r.png" id="folderImg"/></a>
            <label style="font-size: small;">R2R</label>
        </div>
        <!-- TO DO :: ADD SEPERATOR -->
        <div class="col-xs-12">
            <h4 style="color:#006c9a">Create New Case</h4>
        <div class="col-xs-4 menu_icon text-center">
            <a href="addNew.jsp?option=createCase"><img class="img-responsive center-block" src="../img/add_folder.png" id="folderImg"/></a>
            <label style="font-size: small;">Create Case</label>
        </div>
        </div>
    </div>
    <!-- End of Main Menu -->

</body>
</html>
