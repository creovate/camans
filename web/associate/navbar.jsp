<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@ include file="./protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    
    User userLogin = (User) request.getSession().getAttribute("userLogin");
    ArrayList<Worker> searchWorkers = (ArrayList<Worker>) request.getSession().getAttribute("searchWorkers");

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!--css-->
        <link rel="stylesheet" href="css/bootstrap.css" media="screen" />
        <link rel="stylesheet" href="css/dataTables.bootstrap.css"/>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
        <link rel="stylesheet" href="css/jasny-bootstrap.css"/>
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
        <!-------------->
        
        <!--javascript-->
        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
        <script src="js/jquery.steps.js"></script>
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>
        <script type="text/javascript" src="js/bootstrapValidator.min.js"></script>
        <script src="js/jasny-bootstrap.js"></script>  
        <!------------->
        
        <!--tab icon-->
        <link rel="shortcut icon" href="img/twc_logo.png">
        
        <!--page title-->
        <title>CAMANS</title>
            
            
        </style>
    </head>
    <body>

    <div class="row">

    <nav class="navbar navbar-fixed-top" id="top-navbar" role="navigation">
        <div class="container-fluid">
            <div class="navbar-header">
                <div class="col-md-1"></div>
                <h4><a href="home.jsp" style="color:white; font-family: Roboto">CAMANS</a></h4>
            </div>
            
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" data-toggle="dropdown"><span class="glyphicon glyphicon-menu-hamburger" style="color:white;"></span></a>
                    <ul class="dropdown-menu" role="menu">

                        <!-- add home page link -->
                        <li><a href="userProfile.jsp">
                                <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
                                Profile
                            </a>
                        </li>

                        <li class="divider"></li>
                        <li><a href="logout.jsp">
                                <span class="glyphicon glyphicon-log-out" aria-hidden="true"></span>
                                Log Out
                            </a></li>
                    </ul>
                </li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </nav>

</div>

    </body>
</html>
 