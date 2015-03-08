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
        <link rel="stylesheet" href="../css/jquery-ui-1.9.2.custom.css">
        <link rel="stylesheet" href="../css/jquery-ui.structure.css">
        <link rel="stylesheet" href="../css/jquery-ui.theme.css">
        <link rel="stylesheet" href="../css/bootstrapValidator.min.css"/>
        <!-------------->

        <!--javascript-->
        <script src="../js/jquery-2.1.1.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery-ui-1.9.2.custom.js"></script>
        <script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>   
        <!------------->

        <!--tab icon-->
        <link rel="shortcut icon" href="../img/twc_logo.png">

        <!--page title-->
        <title>CAMANS</title>
        <style>
            #folderImg{
                max-height: 20vw;
                margin-bottom: 4%;
            }
            
            .menu_icon{
                padding: 1%;
            }
            
            #searchBox{
                margin-bottom: 2%;
            }
            input{
                width: 100%;
            }
            input.form-control{
                width: 100%;
            }
        </style>

</head>
<body id="home">
    <!-- Nav Bar -->
    <jsp:include page="navbar.jsp"/>
    <!-- End of Nav Bar-->

    <!-- Search Box -->
    
    <div id="searchBox" class="col-xs-12 col-sm-offset-1 col-sm-10 col-md-offset-2 col-md-8">
        <h4 style="color:#006c9a">Search Worker by FIN</h4>

        <!-- Search Worker form-->
        <form class="form-inline" method="POST" action="../searchWorker.do">
            <div class="form-group col-xs-9 col-sm-8 col-md-8">
                <input type="text" class="form-control" id="finNum" name="fin" placeholder="FIN Number" required style='width:100%;'>
            </div>
            <input type="hidden" name="associate" value="associate"/>
                <button type="submit" class="btn btn-blue col-xs-3">Search</button>
            
                
        </form>

    </div>
    <!-- End of Search Box -->

    <!-- Main Menu -->
    <div id="mainMenu" class="col-xs-12 col-sm-offset-1 col-sm-10 col-md-offset-2 col-md-8">
        <h4 style="color:#006c9a">Review Benefits</h4>
        <!-- First Row -->
        <div class='row'>
        <div class="col-xs-4 col-md-3 menu_icon text-center">
            <a href="benefection.jsp?beneCategory=Food&action=History"><img class="img-responsive center-block" src="../img/meal.png" id="folderImg"/></a>
            <label style="font-size: small;">Meal Cards</label>
        </div>
        <div class="col-xs-4 col-md-offset-1 col-md-3 menu_icon text-center">
            <a href="benefection.jsp?beneCategory=Transport&action=History"><img class="img-responsive center-block" src="../img/farego.png" id="folderImg"/></a>
            <label style="font-size: small;">FareGo</label>
        </div>
        <div class="col-xs-4 col-md-offset-1 col-md-3 menu_icon text-center">
            <a href="benefection.jsp?beneCategory=Medical&action=History"><img class="img-responsive center-block" src="../img/med.png" id="folderImg"/></a>
            <label style="font-size: small;">Medical</label>
        </div>
        </div>
        <!-- Second Row -->
        <div class="row">
        <div class="col-xs-4 col-md-3 menu_icon text-center">
            <a href="benefection.jsp?beneCategory=Roof&action=viewHistory"><img class="img-responsive center-block" src="../img/shelter.png" id="folderImg"/></a>
            <label style="font-size: small;">Roof</label>
        </div>
        <div class="col-xs-4 col-md-offset-1 col-md-4 menu_icon text-center">
            <a href="benefection.jsp?beneCategory=r2r&action=viewHistory"><img class="img-responsive center-block" src="../img/r2r.png" id="folderImg"/></a>
            <label style="font-size: small;">R2R</label>
        </div>
        </div>
        <!-- TO DO :: ADD SEPERATOR -->
            <h4 style="color:#006c9a">Create New Case</h4>
            <div class="row">
        <div class="col-xs-4 col-md-4 menu_icon text-center">
            <a href="addNew.jsp?option=createCase"><img class="img-responsive center-block" src="../img/folder.png" id="folderImg"/></a>
            <label style="font-size: small;">Create Case</label>
        </div>
            </div>
    </div>
    <!-- End of Main Menu -->

</body>
</html>
