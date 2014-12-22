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
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    HashMap<Integer, String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
    HashMap<Integer, String> passTypeList = DropdownDAO.retrieveAllDropdownListOfPassType();
    HashMap<Integer, String> problemList = DropdownDAO.retrieveAllDropdownListOfProblems();
    HashMap<Integer, String> hospitalList = DropdownDAO.retrieveAllDropdownListOfHosptialType();
    
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
    /*
    if (registeredStartIn != null || !registeredStartIn.equals("")) {
        registeredStartIn = sdf.format(registeredStartIn);
    }  */  
    String registeredEndIn = (String) request.getSession().getAttribute("end");
    /*if (registeredEndIn != null || !registeredEndIn.equals("")) {
        registeredEndIn = sdf.format(registeredEndIn);
    }
 */
    String leadCaseWorkerIn = (String) request.getSession().getAttribute("leadCase");
    String auxCaseWorkerIn = (String) request.getSession().getAttribute("auxCase");
    
    request.getSession().removeAttribute("fin");
    request.getSession().removeAttribute("worker");
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
        
        
        <title>CAMANS</title>
    </head>
    <body id="home">
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>
            
        <div class="col-md-10" id="content">
            <div class="page-header">
                <center><h2>Search Worker</h2></center>    
            </div>
            <div id="search_worker">
                <!-- SEARCH FILTERS -->
                
                <!--<div id="schwker_box" class="col-md-11 sub_div_w_bg" style="padding:2% 1%">-->
                <div id="worker_filter_div" class="col-md-12"> 
                    <div class="panel panel-default">
                        <div class="panel-body"> 
                <!--<div class="col-mid-9 panel panel-default sub_div_w_bg" style="padding:2% 1%">-->    
                            <h3>Search Criteria</h3>  
                            <%
                            %>
                            <form id="searchWorkerForm" action="searchWorker.do" method="post">
                                <div class="row">
                                    <!-- Fin Number -->
                                    <div class="form-group col-sm-3">
                                        <input type="text" class="form-control" id="workerFIN_In" 
                                               name="fin" placeholder="FIN" value="<%=(finIn==null) ? "":finIn%>">
                                    </div>
                                    <!-- Name -->
                                    <div class ="form-group col-sm-3">
                                        <input type="text" class="form-control" id="workerName_In" 
                                               name="name" placeholder="Worker Name" value="<%=(workerNameIn==null)?"":workerNameIn%>">
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
                                            for (String nationalityStr : nationalityList.values()) {
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
                                               name="sgPhone" placeholder="Singapore Phone" 
                                               value="<%=(sgPhoneIn==null) ? "":sgPhoneIn%>">
                                    </div>
                                    <!-- home country phone -->
                                    <div class="form-group col-sm-3">
                                        <input type="text" class="form-control" id="workerHCPh_In" 
                                               name="homeCountryPhone" placeholder="Home Country Phone"
                                               value="<%=(homeCountryPhIn==null) ? "":homeCountryPhIn%>">
                                    </div>
                                    <!-- employer Name -->
                                    <div class="form-group col-sm-3">
                                        <input type="text" class="form-control" id="workerEmpName_In" 
                                               name="employer" placeholder="Employer's Name"
                                               value="<%=(employerIn==null) ? "":employerIn%>">
                                    </div>
                                    <!-- Occupation -->
                                    <div class="form-group col-sm-3">
                                        <input type="text" class="form-control" id="workerOccupation_In" 
                                               name="occupation" placeholder="Occupation"
                                               value="<%=(occupationIn==null) ? "":occupationIn%>">
                                    </div>
                                </div> <!-- end of row 2--> 

                                <div class="row"> <!--row 3-->

                                    <!--work pass types-->
                                    <div class="form-group col-sm-3">
                                        <select class="form-control" id="workerWPType_In" name="workPassType">
                                            <option value="" default selected>Work Pass Type</option>
                                        <%
                                            for (String passTypeStr : passTypeList.values()) {
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
                                            for (String problemListStr : problemList.values()) {
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
                                            for (String problemListStr : problemList.values()) {
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
                                            for (String hosptialStr : hospitalList.values()) {
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
                                    <input type="text" id="reg_StartDate_In" placeholder="Registered Start Date" name="startDate" 
                                           class="form-control input-append date dateInput" data-date-format="dd-mm-yyyy"
                                           value="<%=(registeredStartIn==null) ? "":registeredStartIn%>">
                                </div>

                                <div class="form-group col-sm-3">
                                    <input type="text" id="reg_EndDate_In" placeholder="Registered End Date" name="endDate"
                                           class="form-control input-append date dateInput" data-date-format="dd-mm-yyyy"
                                           value="<%=(registeredEndIn==null) ? "": registeredEndIn%>">
                                </div>

                                <div class="form-group col-sm-3">
                                    <input type="text" class="form-control" id="auxiliaryCaseWorker_In" 
                                               name="leadCaseWorker" placeholder="Lead Case Worker"
                                               value="<%=(leadCaseWorkerIn==null) ? "":leadCaseWorkerIn%>">
                                </div>

                                <div class="form-group col-sm-3">
                                    <input type="text" class="form-control" id="auxiliaryCaseWorker_In" 
                                               name="auxiliaryCaseWorker" placeholder="Auxiliary Case Worker"
                                               value="<%=(auxCaseWorkerIn==null) ? "":auxCaseWorkerIn%>">
                                </div>
                                </div> <!--end of row 4--> 

                                <div clas="row"> <!-- row 5 -->
                                    <div class="form-group col-sm-3 pull-right">
                                        <button class="btn btn-default" id="btnSearch" onclick="search()">Search</button>
                                        <button class="btn btn-default pull-right" id="btnReset" 
                                                type="reset" onClick="window.location.href=window.location.href">Reset</button>
                                    </div>
                                </div> <!--end of row 5--> 
                            </form> <!-- form close -->
                        </div> <!-- panel body -->
                    </div>  <!-- panel close -->  
                </div>
                   
                <!-- End of search filters -->

                <!-- search Results -->
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
                                    workersList = WorkerDAO.retrieveWorkersByUser(userLogin.getFullName());
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
                                
                                <table class="table table-striped table-bordered table-hover" id="workers-table">    
                                    <thead>
                                        <tr>
                                            <th>Lead Case Worker</th>
                                            <th>Auxiliary Case Worker</th>
                                            <th>Worker Fin Number </th>
                                            <th>Worker Name </th>
                                            <th>Worker Gender </th>
                                            <th>Worker Nationality </th>
                                            <th>Case Registered Date </th>
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
                                        <td><%=fin%></td>
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
                        
        <script>
            
            $(function() {
                $(".dateInput").datepicker({
                    dateFormat: 'dd-M-yy',
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: "-100:nn"
                });

            });
            
            //ready the data in tables
            $(document).ready(function () {
                $('#workers-table').dataTable();
            }); 
            
            
        </script>
    </body>
</html>
 