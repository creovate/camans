<%-- 
    Document   : index
    Created on : Oct 23, 2014, 10:55:34 AM
    Author     : soemyatmyat
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User userLogin = (User) request.getSession().getAttribute("userLogin");
    String role = userLogin.getRole();
    boolean isAssociate = false;
    if(role.equalsIgnoreCase("Associate")){
        isAssociate = true;
    }
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    ArrayList<String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
    ArrayList<String> passTypeList = DropdownDAO.retrieveAllDropdownListOfWorkpassType();
    ArrayList<String> problemList = DropdownDAO.retrieveAllDropdownListOfProblems();
    ArrayList<String> hospitalList = DropdownDAO.retrieveAllDropdownListOfHosptialType();
    
    ArrayList<Worker> searchWorkers = (ArrayList<Worker>) request.getSession().getAttribute("searchWorkers");
    request.getSession().removeAttribute("searchWorkers");
    
    
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
        
        <style>
            .navbar{
                margin-bottom: 0 !important;
            }
            
            
        </style>
        
        <script>
            $(document).ready(function(){
                if(<%=isAssociate%>){
                    window.location = "associate/home.jsp";
    }
                var isMobile = {
                    Android: function() {
                        return navigator.userAgent.match(/Android/i);
                    },
                    BlackBerry: function() {
                        return navigator.userAgent.match(/BlackBerry/i);
                    },
                    iOS: function() {
                        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
                    },
                    Opera: function() {
                        return navigator.userAgent.match(/Opera Mini/i);
                    },
                    Windows: function() {
                        return navigator.userAgent.match(/IEMobile/i);
                    },
                    any: function() {
                        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
                    }};

                if (isMobile.any()) {
                    //this is mobile
                    window.location = "associate/home.jsp";
                } else {
                    //this is desktop
                    //window.location = "../home.jsp";
                }
            })
        </script>
    </head>
    <body id="home">
        <jsp:include page="include/navbartop.jsp"/>
        <div class="row-offcanvas row-offcanvas-left" style="padding:0%;">
            <jsp:include page="include/navbarside.jsp"/>

            <div class="col-md-offset-2 col-md-10" id="content" style="padding-top: 2%;">

                <div id="search_worker">
                    <!-- SEARCH FILTERS -->

                    <div id="worker_filter_div" class="col-md-12"> 
                        <div class="panel panel-default">
                            <div class="panel-body">   
                                <h3>Search Criteria</h3>  
                                <%
                                %>
                                <form id="searchWorkerForm" action="searchWorker.do" method="post">
                                    <div class="row">
                                        <!-- Fin Number -->
                                        <div class="form-group col-sm-3">
                                            <input type="text" class="form-control" id="workerFIN_In" 
                                                   name="fin" placeholder=" FIN" value="<%=(finIn==null) ? "":finIn%>">
                                        </div>
                                        <!-- Name -->
                                        <div class ="form-group col-sm-3">
                                            <input type="text" class="form-control" id="workerName_In" 
                                                   name="name" placeholder=" Worker Name" value="<%=(workerNameIn==null)? "":workerNameIn%>">
                                        </div>
                                        <!-- Gender -->
                                        <div class ="form-group col-sm-3">
                                            <select class="form-control" id="workerGender_In" name="gender">
                                                <%
                                                    if (genderIn == null || genderIn.equals("")) {
                                                %>
                                                <option value="" default selected>Gender</option>
                                                <option value="male">Male</option>
                                                <option value="female">Female</option>
                                                <%
                                                    } else if (genderIn.equals("male")) {
                                                %>
                                                <option value=""> Gender </option>
                                                <option value="male" selected>Male</option>
                                                <option value="female">Female</option>
                                                <%
                                                    } else if (genderIn.equals("female")) {
                                                %>
                                                <option value=""> Gender </option>
                                                <option value="male">Male</option>
                                                <option value="female" selected>Female</option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>    
                                        <!-- Nationality -->
                                        <div class ="form-group col-sm-3">
                                            <select class="form-control" id="workerNationality_In" name="nationality">
                                                <option value="" default selected>Nationality</option>
                                            <%
                                                for (String nationalityStr : nationalityList) {
                                                    if (nationalityIn !=null && nationalityIn.equals(nationalityStr)) {
                                            %>
                                                <option selected><%=nationalityStr%></option>
                                            <%
                                                    } else {
                                            %>
                                                <option><%=nationalityStr%></option>
                                            <%

                                                    }
                                                }    
                                            %>    
                                            </select>
                                        </div>
                                    </div> <!--end of row 1-->

                                    <div class="row"> <!--row 2-->
                                        <!-- sg Phone -->
                                        <div class="form-group col-sm-3">
                                            <input type="text" class="form-control" id="workerSGPh_In" 
                                                   name="sgPhone" placeholder=" Singapore Phone" 
                                                   value="<%=(sgPhoneIn==null) ? "":sgPhoneIn%>">
                                        </div>
                                        <!-- home country phone -->
                                        <div class="form-group col-sm-3">
                                            <input type="text" class="form-control" id="workerHCPh_In" 
                                                   name="homeCountryPhone" placeholder=" Home Country Phone"
                                                   value="<%=(homeCountryPhIn==null) ? "":homeCountryPhIn%>">
                                        </div>
                                        <!-- employer Name -->
                                        <div class="form-group col-sm-3">
                                            <input type="text" class="form-control" id="workerEmpName_In" 
                                                   name="employer" placeholder=" Employer's Name"
                                                   value="<%=(employerIn==null) ? "":employerIn%>">
                                        </div>
                                        <!-- Occupation -->
                                        <div class="form-group col-sm-3">
                                            <input type="text" class="form-control" id="workerOccupation_In" 
                                                   name="occupation" placeholder=" Occupation"
                                                   value="<%=(occupationIn==null) ? "":occupationIn%>">
                                        </div>
                                    </div> <!-- end of row 2--> 

                                    <div class="row"> <!--row 3-->

                                        <!--work pass types-->
                                        <div class="form-group col-sm-3">
                                            <select class="form-control" id="workerWPType_In" name="workPassType">
                                                <option value="" default selected>Work Pass Type</option>
                                            <%
                                                for (String passTypeStr : passTypeList) {
                                                    if (workPassIn !=null && workPassIn.equals(passTypeStr)) {
                                            %>
                                                <option selected><%=passTypeStr%></option>
                                            <%
                                                    } else {
                                            %>
                                                <option><%=passTypeStr%></option>
                                            <%

                                                    }
                                                }    
                                            %>
                                            </select>
                                        </div>
                                        <!--To retrieve from db dropdown list table-->
                                        <div class="form-group col-sm-3">
                                            <select class="form-control" id="workerProblem_In" name="problemType">
                                                <option value="" default selected>Problem Type</option>
                                           <%
                                                for (String problemListStr : problemList) {
                                                    if (problemTypeIn !=null && problemTypeIn.equals(problemListStr)) {
                                            %>
                                                <option selected><%=problemListStr%></option>
                                            <%
                                                    } else {
                                            %>
                                                <option><%=problemListStr%></option>
                                            <%

                                                    }
                                                }    
                                            %>
                                            </select>
                                        </div>

                                        <div class="form-group col-sm-3">
                                            <select class="form-control" id="workerIssue_In" name="aggravatingIssue">
                                                <option value="" default selected>Aggravating Issue</option>
                                           <%
                                                for (String problemListStr : problemList) {
                                                    if (aggravatingIssueIn !=null && aggravatingIssueIn.equals(problemListStr)) {
                                            %>
                                                <option selected><%=problemListStr%></option>
                                            <%
                                                    } else {
                                            %>
                                                <option><%=problemListStr%></option>
                                            <%

                                                    }
                                                }    
                                            %>
                                            </select>
                                        </div>
                                    <div class="form-group col-sm-3">
                                        <select class="form-control" id="workerHospital_In" name="hospital">
                                            <option value="" default selected>Hospital</option>
                                            <%
                                                for (String hosptialStr : hospitalList) {
                                                    if (hospitalIn !=null && hospitalIn.equals(hosptialStr)) {
                                            %>
                                                <option selected><%=hosptialStr%></option>
                                            <%
                                                    } else {
                                            %>
                                                <option><%=hosptialStr%></option>
                                            <%

                                                    }
                                                }    
                                            %>
                                        </select>
                                    </div>
                                    </div> <!-- end of row 3-->
                                    <div class="row"> <!-- row 4 -->

                                    <div class="form-group col-sm-3">
                                        <input type="text" id="reg_StartDate_In" placeholder=" Registered Start Date" name="startDate" 
                                               class="form-control startDate" data-date-format="dd-mm-yyyy"
                                               value="<%=(registeredStartIn==null) ? "":registeredStartIn%>">
                                    </div>

                                    <div class="form-group col-sm-3">
                                        <input type="text" id="reg_EndDate_In" placeholder=" Registered End Date" name="endDate"
                                               class="form-control endDate" data-date-format="dd-mm-yyyy"
                                               value="<%=(registeredEndIn==null) ? "": registeredEndIn%>">
                                    </div>

                                    <div class="form-group col-sm-3">
                                        <input type="text" class="form-control" id="auxiliaryCaseWorker_In" 
                                                   name="leadCaseWorker" placeholder=" Lead Case Worker"
                                                   value="<%=(leadCaseWorkerIn==null) ? "":leadCaseWorkerIn%>">
                                    </div>

                                    <div class="form-group col-sm-3">
                                        <input type="text" class="form-control" id="auxiliaryCaseWorker_In" 
                                                   name="auxiliaryCaseWorker" placeholder=" Auxiliary Case Worker"
                                                   value="<%=(auxCaseWorkerIn==null) ? "":auxCaseWorkerIn%>">
                                    </div>
                                    </div> <!--end of row 4--> 

                                    <div clas="row"> <!-- row 5 -->
                                        <div class="form-group col-sm-12 text-right">
                                            <button class="btn btn-blue" id="btnSearch" onclick="search()">Search</button>
                                            <button class="btn btn-info" id="btnReset" style="border-radius:2px"
                                                    type="reset" onClick="window.location.href=window.location.href">Reset</button>
                                        </div>
                                    </div> <!--end of row 5--> 
                                </form> <!-- form close -->
                            </div> <!-- panel body -->
                        </div>  <!-- panel close -->  
                    </div>

                    <!-- End of search filters -->

                    <!-- search Results -->
                    <div id ="pageloading"><img id="loading-image" src="images/loading.gif"/></div>
                    <div id="worker_search_result_div" class="col-md-12">
                        <!--div class="col-md-3 pull-right"> 
                            <input type="text" id="search_in_recent" placeholder="Search..." class="form-control"/>
                        </div-->
                        <!--<table class="table" id="worker_search_result">-->
                        
                        <div class="panel panel-default">
                            <div class="panel-body">  

                                <%
                                    ArrayList<Worker> workersList = new ArrayList<Worker>();
                                    if (searchWorkers == null) {
                                        workersList = WorkerDAO.retrieveWorkersByUser(userLogin.getUsername());
                                    } else {
                                        workersList = searchWorkers;
                                    } 
                                    if (workersList.isEmpty()) {
                                        if (searchWorkers != null && searchWorkers.isEmpty()) {

                                            out.println("<h3>Search Results</h3>");    
                                            out.println("No records Found!");

                                        } else {

                                            out.println("<h3>Assigned Cases</h3>");    
                                            out.println("There is no case assigned to you!");

                                        }

                                    } else {
                                        if (searchWorkers == null) {
                                            out.println("<h3>Assigned Cases</h3>");
                                        } else { 
                                            out.println("<h3>Search Results</h3>");
                                        }   
                                %>

                                    <table class="table table-bordered table-hover text-center" id="workers-table">    
                                        <thead bgcolor="#4c98b8">
                                            <tr>
                                                <th><font color="#fff">Lead Case Worker</font></th>
                                                <th><font color="#fff">Auxiliary Case Worker</font></th>
                                                <th><font color="#fff">Worker Fin Number</font></th>
                                                <th><font color="#fff">Worker Name</font></th>
                                                <th><font color="#fff">Worker Gender</font></th>
                                                <th><font color="#fff">Worker Nationality</font></th>
                                                <th><font color="#fff">Worker Registration Date</font></th>
                                            </tr>
                                        </thead>
                                        <tbody>

                                        <%

                                            String name;
                                            String fin;
                                            String gender;
                                            String nationality;
                                            for (int i = 0; i < workersList.size(); i++) {
                                                Worker worker = workersList.get(i);
                                                name = worker.getName();
                                                fin = worker.getFinNumber();
                                                java.util.Date regDate = worker.getRegistrationDate();
                                                gender = worker.getGender();
                                                nationality = worker.getNationality();
                                                if (nationality == null) {
                                                    nationality = worker.getNationalityMore();
                                                }
                                                ArrayList<Integer> jobIds = JobDAO.retrieveJobIdsOfWorker(worker);
                                                Job latestJob = JobDAO.retrieveJobByJobId(jobIds.get(jobIds.size() - 1));
                                                ArrayList<Integer> problemIds = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
                                                Problem latestProblem = ProblemDAO.retrieveProblemByProblemId(problemIds.get(problemIds.size() - 1));
                                                ArrayList<Integer> leadCaseIds = ProblemComplementsDAO.retrieveLeadCaseWorkerIdsOfProblem(latestProblem);
                                                String leadCaseWorker = "-";
                                                if (!leadCaseIds.isEmpty()) {
                                                    ProblemLeadCaseWorker latestLeadCaseWkr = ProblemComplementsDAO.retrieveProblemLeadCaseWorkerById
                                                            (leadCaseIds.get(leadCaseIds.size()-1));
                                                    leadCaseWorker = latestLeadCaseWkr.getLeadCaseWorker();
                                                }
                                                ArrayList<Integer> auxiCaseIds = ProblemComplementsDAO.retrieveProblemAuxiliaryCaseWorkerIdsOfProblem(latestProblem);
                                                String auxiCaseWorker = "-";
                                                if (!auxiCaseIds.isEmpty()) {
                                                    ProblemAuxiliaryCaseWorker latestAuxiCaseWkr = ProblemComplementsDAO.retrieveProblemAuxiliaryCaseWorkerById
                                                            (auxiCaseIds.get(auxiCaseIds.size()-1));
                                                    auxiCaseWorker = latestAuxiCaseWkr.getAuxName();
                                                }
                                        %>
                                        <tr onclick="location.href = 'viewWorker.jsp?worker=<%=fin%>'" style="cursor: pointer">
                                            <td><%=leadCaseWorker%></td>
                                            <td><%=auxiCaseWorker%></td>
                                            <td><a href="viewWorker.jsp?worker=<%=fin%>" style="text-decoration:none;"><%=fin%></a></td>
                                            <td><%=name%></td>
                                            <td><%=gender%></td>
                                            <td><%=nationality%></td>
                                            <td><%=sdf.format(regDate)%></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            <%
                                }
                            %>    
                            </div>
                        </div>
                    </div>
                    <!-- End of search Results -->      
                </div> <!--search worker -->

            </div>
        </div>                        
        <script>
            //page loading gif
            $(window).load(function() {
                $('#pageloading').hide();
            });
            //startdate & enddate 
            $(function() {
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
            
            //ready the data in tables
            $(document).ready(function () {
                $('#workers-table').dataTable();
            }); 
            
            //session timeout
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
 