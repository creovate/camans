<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    ArrayList<String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
    ArrayList<String> passTypeList = DropdownDAO.retrieveAllDropdownListOfWorkpassType();
    ArrayList<String> problemList = DropdownDAO.retrieveAllDropdownListOfProblems();
    ArrayList<String> hospitalList = DropdownDAO.retrieveAllDropdownListOfHosptialType();
    
    ArrayList<Worker> searchWorkers = (ArrayList<Worker>) request.getSession().getAttribute("searchWorkers");
    request.getSession().removeAttribute("searchWorkers");
    
    User userLogin = (User) request.getSession().getAttribute("userLogin");
    String finIn = (String) request.getSession().getAttribute("fin");
    String workerNameIn = (String) request.getSession().getAttribute("workerIn");
    String genderIn = (String) request.getSession().getAttribute("gender");
    String nationalityIn = (String) request.getSession().getAttribute("nationality");
    String sgPhoneIn = (String) request.getSession().getAttribute("sgPhone");
    String homeCountryPhIn = (String) request.getSession().getAttribute("homeCountryPh");
    String employerIn = (String) request.getSession().getAttribute("employer");
    String occupationIn = (String) request.getSession().getAttribute("occupation");
    String workPassIn = (String) request.getSession().getAttribute("workPass");
    String problemTypeIn = (String) request.getSession().getAttribute("problemType");
    String aggravatingIssueIn = (String) request.getSession().getAttribute("aggravatingIssue");
    String hospitalIn = (String) request.getSession().getAttribute("hospital");
    String registeredStartIn = (String) request.getSession().getAttribute("start");

    String registeredEndIn = (String) request.getSession().getAttribute("end");

    String leadCaseWorkerIn = (String) request.getSession().getAttribute("leadCase");
    String auxCaseWorkerIn = (String) request.getSession().getAttribute("auxCase");
    
    request.getSession().removeAttribute("fin");
    request.getSession().removeAttribute("workerIn");
    request.getSession().removeAttribute("gender");
    request.getSession().removeAttribute("nationality");
    request.getSession().removeAttribute("sgPhone");
    request.getSession().removeAttribute("homeCountryPh");
    request.getSession().removeAttribute("employer");
    request.getSession().removeAttribute("occupation");
    request.getSession().removeAttribute("workPass");
    request.getSession().removeAttribute("problemType");
    request.getSession().removeAttribute("aggravatingIssue");
    request.getSession().removeAttribute("hospital");
    request.getSession().removeAttribute("start");
    request.getSession().removeAttribute("end");
    request.getSession().removeAttribute("leadCase");
    request.getSession().removeAttribute("auxCase");
    
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
    <body id="home">
    <!-- Nav Bar -->
    	<jsp:include page="include/navbartop.jsp"/>
    	<!-- End of Nav Bar-->

    	<!-- Search Box -->
    	<div id="searchBox" class="col-xs-12 col-sm-offset-1 col-sm-10 col-md-offset-3 col-md-6">
    		<h3>Search Worker by FIN</h3>

    		<!-- Search Worker form-->
    		<form class="form-inline" method="POST" action="">
	    		<div class="form-group">
					<input type="text" class="form-control" id="finNum" placeholder="FIN Number">	
	    		</div>

	    		<div>
	    			<button type="submit" class="btn btn-primary">Search</button>
	    		</div>
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
 