<%-- 
    Document   : viewWorker
    Created on : Oct 23, 2014, 8:00:17 PM
    Author     : soemyatmyat
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.dao.*"%>
<%@ include file="protect.jsp"%>

<%
    String workerFin = request.getParameter("worker");
    if (workerFin == null) {
        workerFin = (String) request.getAttribute("worker");
    }
    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
    //request.getSession().removeAttribute("workerTmp");
    ArrayList<Integer> jobIds = JobDAO.retrieveJobIdsOfWorker(worker);
    Job latestJob = JobDAO.retrieveJobByJobId(jobIds.get(jobIds.size() - 1));
    ArrayList<Integer> problemIds = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
    Problem latestProblem = ProblemDAO.retrieveProblemByProblemId(problemIds.get(problemIds.size() - 1));
    
    String selectedJob = request.getParameter("selectedJob");
    if (selectedJob == null) {
        selectedJob = (String) request.getAttribute("selectedJob");
    }
    if (selectedJob != null) {
        int selectedJobId = Integer.parseInt(selectedJob);
        latestJob = JobDAO.retrieveJobByJobId(selectedJobId);
        problemIds = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
        latestProblem = ProblemDAO.retrieveProblemByProblemId(problemIds.get(problemIds.size() - 1));
    }
    
    String selectedProb = request.getParameter("selectedProb");
    if (selectedProb == null) {
        selectedProb = (String) request.getAttribute("selectedProb");
    }
    
    if (selectedProb != null) {
        int selectedProbId = Integer.parseInt(selectedProb);
        latestProblem = ProblemDAO.retrieveProblemByProblemId(selectedProbId);
        int selectedJobId = latestProblem.getJobKey();
        latestJob = JobDAO.retrieveJobByJobId(selectedJobId);
    }
    
    String selectedBenefit = request.getParameter("selectedBenefit");
    if (selectedBenefit == null) {
        selectedBenefit = (String) request.getAttribute("selectedBenefit");
    }
    
    if (selectedBenefit != null) {
        selectedProb = null;
        selectedJob = null;
    }
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");


%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
        <link rel="stylesheet" href="css/jquery-ui.css">

        <link rel="stylesheet" href="css/jquery-ui.structure.css">
        <link rel="stylesheet" href="css/jquery-ui.theme.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">

        <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
        <!--jasny-bootstrap v3.1.3, added by soemyatmayt-->
        <link rel="stylesheet" href="css/jasny-bootstrap.css"/>
        <!-- DataTables CSS, added by soemyatmyat -->
        <link rel="stylesheet" href="css/dataTables.bootstrap.css"/>

        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-ui.js"></script>
        <script src="js/jquery.steps.js"></script>
        <script src="jquery.ui.position.js"></script>
        <script type="text/javascript" src="js/bootstrapValidator.min.js"></script>        
        <!--jasny-bootstrap v3.1.3, added by soemyatmyat-->
        <script src="js/jasny-bootstrap.js"></script>  
        <!-- DataTables JS, Added by soemyatmyat -->
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>

        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>CAMANS</title>

        <script>
            $(document).ready(function() {
                if (<%=selectedJob%> !== null) {
                    $(".complement_tabs").removeClass("active");
                    $("#job_complement_tab").addClass("active");
                    $(".tab-pane").removeClass("active");
                    $("#job_complement").addClass("active");
                    $("#jobSelected").val('<%=latestJob.getJobKey()%>');
                }
                if (<%=selectedProb%> !== null) {
                    $(".complement_tabs").removeClass("active");
                    $("#worker_complement").removeClass("active");
                    $("#job_complement").removeClass("active");
                    $("#problem_complement_tab").addClass("active");
                    $("#problem_complement").addClass("active");
                    $("#problemSelected").val('<%=latestProblem.getProbKey()%>');
                }
                if (<%=selectedBenefit%> !== null) {
                    $(".complement_tabs").removeClass("active");
                    $("#worker_complement").removeClass("active");
                    $("#job_complement").removeClass("active");
                    $("#benefit_complement_tab").addClass("active");
                    $("#benefit_complement").addClass("active");
                }
            });

            $(document).ready(function() {
                $('[data-toggle=offcanvas]').click(function() {
                    $('.row-offcanvas').toggleClass('active');
                });

                $('.moreObjs').hide();
            });


            //for date inputs
            $(document).ready(function() {

                $('.no_change').focus(function() {

                    $('.no_change').blur();

                });

            });


        </script>
        <style>
            .col-md-1{
                width:14%;
            }
            .col-md-2{
                width:48%;
            }

            .col-md-offset-6{
                margin-left:35%;
            }

        </style>
    </head>
    <body id="home" style='background:white;overflow-y: scroll'>
        <jsp:include page="include/navbartop.jsp"/>
        <div class="row-offcanvas row-offcanvas-left" style="padding:1% 0% 0%;">

            <div id="sidebar" class="sidebar-offcanvas text-capitalize">
                <jsp:include page="include/navbarside.jsp"/>

                <div class="col-md-6"  id="worker_profile_div">
                    <!-- Face Picture -->
                    <br/>
                    <div id="worker_profile_pic" class="text-center">
                        <img src="img/profile_pic.jpg" style="max-width: 40%"> <!--get image from db also -->
                    </div>
                    <br/>

                    <!--worker stub-->
                    <p class="worker_profile_header text-center">Worker Stub<a id="worker_profile_details" style="color: white" data-target="#worker_stub"  data-value='worker' href="#" data-title="View/Edit Worker Stub" data-toggle="modal" data-action="view" class="profile_details"><span class="glyphicon glyphicon-eye-open pull-right" pull-right></span></a></p>

                    <div class="worker_profile_content text-center text-capitalize">
                        <%
                            String wkername = worker.getName();
                            String wkerfinNum = worker.getFinNumber();
                            //String phNum = WorkerComplementsDAO.retrieveSgCountryPhoneNumIdsOfWorker(worker);
                            String wkerphNum = "";

                            ArrayList<Integer> phNoIds = WorkerComplementsDAO.retrieveSgCountryPhoneNumIdsOfWorker(worker);
                            if (phNoIds != null && !phNoIds.isEmpty()) {
                                WorkerSgPhNum phNumObj = WorkerComplementsDAO.retrieveWorkerSgPhNumById(phNoIds.get(phNoIds.size() - 1));
                                wkerphNum = phNumObj.getPhNumber();
                            }

                        %>
                        <p><%=worker.getName()%><p>
                        <p><%=worker.getFinNumber()%></p>
                        <p><%=wkerphNum%></p>
                    </div>

                    <!--job stub-->
                    <p class="worker_profile_header text-center">Job Stub<a id="job_profile_details" style="color: white"  data-value='job' href="#" data-title="View/Edit Job Stub" data-toggle="modal" data-action="view" class="profile_details"><span class="glyphicon glyphicon-eye-open pull-right" pull-right></span></a></p>
                    <div class="worker_profile_content text-center text-capitalize"> 

                        <p><%=latestJob.getEmployerName()%></p>
                        <p><%=latestJob.getWorkPassType()%></p>
                        <p><%=(latestJob.getOccupation() == null) ? "-" : latestJob.getOccupation()%></p>
                        <p>Job Start on: <%=(latestJob.getJobStartDate() == null) ? "-" : latestJob.getJobStartDate()%></p>
                    </div>

                    <!--Problem Stub-->
                    <p class="worker_profile_header text-center">Problem Stub<a id="problem_profile_details" style="color: white"  data-value='problem' href="#" data-title="View/Edit Problem Stub" data-toggle="modal" data-action="view" class="profile_details"><span class="glyphicon glyphicon-eye-open pull-right" pull-right></span></a></p>

                    <div class="worker_profile_content text-capitalize">
                        <p>Problem: <%=latestProblem.getProblem()%></p>
                        <p>Registered Date: <%=sdf.format(latestProblem.getProblemRegisteredDate())%></p>
                        <p>Chief problem:</p>
                        <p>Date of Injury:<%=(latestJob.getJobStartDate() == null) ? "-" : latestJob.getJobStartDate()%></p>
                        <p>Lead Caseworker:</p>
                    </div>
                </div>
            </div>

            <div id="complement_details_div" class="col-md-offset-6 col-md-6">

                <div class="col-md-12 ">


                    <div  id="content" style="padding: 3% 1%">
                        <div class="tab-content ">
                            <!----Worker Complement Tab---> 
                            <div class="tab-pane active" id="worker_complement">
                                <br/>


                                <!--Nickname-->
                                <div class="panel panel-default">
                                    <div class="panel-heading">

                                        <h4 class="panel-title">Nickname 
                                            <a href="" id="nicknameAddBtn" data-class="worker"  data-toggle="modal" data-action = "add" data-target="#nickname_pop_up" data-value='nickname' data-nickname='' class="add_btn pop_up_open pull-right">
                                                <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                            </a>
                                        </h4>


                                    </div>
                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> nickNameIds = WorkerComplementsDAO.retrieveNickNameIdsOfWorker(worker);
                                            if (nickNameIds != null && !nickNameIds.isEmpty()) {
                                                for (int i = nickNameIds.size() - 1; i >= 0; i--) {
                                                    WorkerNickname nicknameObj = WorkerComplementsDAO.retrieveWorkerNicknameById(nickNameIds.get(i));
                                                    String nickname = nicknameObj.getNickname();

                                                    if (i < nickNameIds.size() - 1) {
                                        %>

                                        <div class="col-md-4 other_nickname moreObjs" >

                                            <table class="table table-bordered">
                                                <tr>
                                                    <td style="width:80%"><%=nickname%></td>
                                                    <td class="text-center" style="width:20%"><a style="color: black"  data-class="worker" data-value='nickname' data-nickname='<%=nicknameObj.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#nickname_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <%
                                        } else {
                                        %>
                                        <div class="col-md-4">
                                            <table class="table table-bordered">
                                                <tr>
                                                    <td style="width:80%"><%=nickname%></td>
                                                    <td class="text-center" style="width:20%"><a style="color: black"  data-class="worker" data-value='nickname' data-nickname='<%=nicknameObj.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#nickname_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                            </table>
                                            <%
                                                    }

                                                }
                                            %>

                                        </div>
                                        <%
                                            if (nickNameIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_nickname_seemore" onclick="seemore('.other_nickname')">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_nickname_seemore" onclick="seemore('.other_nickname')">View Less</a>
                                        <%                                                            }
                                            }
                                        %>

                                    </div>
                                </div>

                                <!--Passport Details-->
                                <div class="panel panel-default">

                                    <div class="panel-heading">

                                        <h4 class="panel-title">Passport Details 
                                            <a href="" id="passportAddBtn" data-toggle="modal" data-target="#passport_pop_up" data-action = "add" data-value='passport' data-passport='' data-class="worker"  class="add_btn pop_up_open pull-right">
                                                <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                    </div>

                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> passportDetailsIds = WorkerComplementsDAO.retrievePassportIdsOfWorker(worker);
                                            if (passportDetailsIds != null && !passportDetailsIds.isEmpty()) {

                                        %>

                                        <table class="table table-condensed">
                                            <tr>
                                                <th>Country Issued</th>
                                                <th>Passport No.</th>
                                                <th>Issued Date</th>
                                                <th>Expiry Date</th>
                                                <th>Action</th>
                                            </tr>

                                            <%
                                                for (int i = passportDetailsIds.size() - 1; i >= 0; i--) {
                                                    WorkerPassportDetails passportDetails = WorkerComplementsDAO.retrieveWorkerPassportDetailsById(passportDetailsIds.get(i));
                                                    String isCountry = passportDetails.getPassportCountry();
                                                    String passportNo = passportDetails.getPassportNumber();
                                                    java.util.Date isDate = passportDetails.getPassportIssueDate();

                                                    java.util.Date exDate = passportDetails.getPassportExpirtyDate();
                                                    if (i < passportDetailsIds.size() - 1) {

                                            %>
                                            <tr class="other_passport moreObjs">
                                                <td><%=isCountry%></td>
                                                <td><%=passportNo%></td>
                                                <td><%=(isDate == null) ? "-" : sdf.format(isDate)%></td>
                                                <td><%=(exDate == null) ? "-" : sdf.format(exDate)%></td>  
                                                <td><a style="color: black" data-value='passport' data-passport='<%=passportDetails.getId()%>' 
                                                       href="" data-toggle="modal" data-class="worker"  data-action="viewedit" 
                                                       data-target="#passport_pop_up" class="edit_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                    </a>
                                                </td>
                                            </tr>
                                            <%
                                            } else {
                                            %>
                                            <tr>
                                                <td><%=isCountry%></td>
                                                <td><%=passportNo%></td>
                                                <td><%=(isDate == null) ? "-" : sdf.format(isDate)%></td>
                                                <td><%=(exDate == null) ? "-" : sdf.format(exDate)%></td> 
                                                <td><a style="color: black" data-value='passport' data-passport='<%=passportDetails.getId()%>' 
                                                       href="" data-toggle="modal" data-class="worker"  data-action="viewedit" 
                                                       data-target="#passport_pop_up" class="edit_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                    </a>
                                                </td>
                                            </tr>
                                            <%
                                                    }
                                                }

                                            %>
                                        </table>
                                        <%
                                            }
                                            if (passportDetailsIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_passport_seemore" onclick="seemore('.other_passport')">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_passport_seemore" onclick="seemore('.other_passport')">View Less</a>
                                        <%                                            }
                                        %>
                                    </div>
                                </div>

                                <!--Singapore Phone Number-->
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">Singapore Phone Number <a data-value='sgphone' data-action = "add" data-sgphone='' href="" data-toggle="modal" data-class="worker"  data-target="#sgPhone_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                    </div>
                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> phoneNumberIds = WorkerComplementsDAO.retrieveSgCountryPhoneNumIdsOfWorker(worker);
                                            if (phoneNumberIds != null && !phoneNumberIds.isEmpty()) {
                                                for (int i = phoneNumberIds.size() - 1; i >= 0; i--) {
                                                    WorkerSgPhNum phNumObj = WorkerComplementsDAO.retrieveWorkerSgPhNumById(phoneNumberIds.get(i));
                                                    String phNum = phNumObj.getPhNumber();
                                                    java.util.Date obsolete = phNumObj.getObseleteDate();
                                                    if (obsolete != null) {
                                                        phNum = phNum + " (Obsoleted on " + sdf.format(obsolete) + ")";
                                                    } else {
                                                        phNum += " (Active)";
                                                    }
                                                    int phId = phNumObj.getId();
                                                    if (i < phoneNumberIds.size() - 1) {
                                        %>

                                        <div class="col-md-4 other_sgphone moreObjs">
                                            <table class="table table-bordered">
                                                <tr>
                                                    <td style="width:80%"><%=phNum%></td>
                                                    <td class="text-center" style="width:20%"><a style="color: black" data-value='sgphone' data-sgphone='<%=phId%>' href="" data-toggle="modal" data-target="#sgPhone_pop_up" data-class="worker"  data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                            </table>
                                        </div>

                                        <%} else {
                                        %>
                                        <div class="col-md-4">
                                            <table class="table table-bordered">
                                                <tr>
                                                    <td style="width:80%"><%=phNum%></td>
                                                    <td class="text-center" style="width:20%"><a style="color: black" data-value='sgphone' data-sgphone='<%=phId%>' href="" data-toggle="modal" data-target="#sgPhone_pop_up" data-class="worker"  data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                            </table> 
                                        </div>
                                        <%
                                                }
                                            }
                                            if (phoneNumberIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_sgphone_seemore" onclick="seemore('.other_sgphone')">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_sgphone_seemore" onclick="seemore('.other_sgphone')">View Less</a>
                                        <%                                                            }
                                            }

                                        %>
                                    </div>
                                </div>


                                <!--Home Country Phone Number-->
                                <div class="panel panel-default">
                                    <div class="panel-heading">

                                        <h4 class="panel-title">Home Country Phone Number 
                                            <a data-value='homephone' data-action = "add" data-homephone='' 
                                               href="" data-toggle="modal" data-class="worker"  
                                               data-target="#homePhone_pop_up" class="edit_btn pop_up_open">
                                                <span class="glyphicon glyphicon-plus pull-right" pull-right>
                                            </a></span></h4>


                                    </div>
                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> homePhIds = WorkerComplementsDAO.retrieveHomeCountryPhoneNumIdsOfWorker(worker);
                                            if (homePhIds != null && !homePhIds.isEmpty()) {
                                        %>
                                        <table class="table table-condensed">
                                            <tr>
                                                <th>Phone No</th>
                                                <th>Owner</th>
                                                <th>Obsolete Date</th>
                                                <th>Action</th>
                                            </tr>

                                            <%
                                                for (int i = homePhIds.size() - 1; i >= 0; i--) {
                                                    WorkerHomeCountryPhNum homePhNum = WorkerComplementsDAO.retrieveWorkerHomeCountryPhNumById(homePhIds.get(i));
                                                    String phNum = homePhNum.getPhNumber();
                                                    String owner = homePhNum.getPhOwner();
                                                    java.util.Date oDate = homePhNum.getObseleteDate();

                                                    if (i < homePhIds.size() - 1) {
                                            %>
                                            <tr class="other_homephone moreobjs">

                                                <td><%=phNum%></td>
                                                <td><%=owner%></td>
                                                <td><%=(oDate == null) ? "-" : sdf.format(oDate)%></td>
                                                <td><a style="color: black" data-value='homephone' 
                                                       data-homephone='<%=homePhNum.getId()%>' href="" data-toggle="modal" 
                                                       data-class="worker"  data-target="#homePhone_pop_up" data-action="viewedit" 
                                                       class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                    </a>
                                                </td>

                                                <%} else {
                                                %>
                                            <tr>
                                                <td><%=phNum%></td>
                                                <td><%=owner%></td>
                                                <td><%=(oDate == null) ? "-" : sdf.format(oDate)%></td>

                                                <td><a style="color: black" data-value='homephone' data-homephone='<%=homePhNum.getId()%>' href="" data-toggle="modal" data-class="worker"  data-target="#homePhone_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>


                                                <%
                                                        }
                                                    }
                                                %>
                                        </table>
                                        <%
                                            }
                                            if (homePhIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_homephone_seemore" onclick="seemore('.other_homephone');">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_homephone_seemore" onclick="seemore('.other_homephone');">View Less</a>
                                        <%                                                    }
                                        %>
                                    </div>
                                </div>


                                <!--Singapore Address-->
                                <div class="panel panel-default">
                                    <div class="panel-heading">

                                        <h4 class="panel-title">Singapore Address <a data-value='sgadd' data-action = "add" data-sgadd='' href="" data-toggle="modal" data-class="worker"  data-target="#sgAdd_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-plus pull-right" pull-right></a></span></h4>


                                    </div>
                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> sgAddressIds = WorkerComplementsDAO.retrieveWorkerSgAddressIdsOfWorker(worker);
                                            if (sgAddressIds != null && !sgAddressIds.isEmpty()) {
                                                for (int i = sgAddressIds.size() - 1; i >= 0; i--) {
                                                    WorkerSgAddress sgAddress = WorkerComplementsDAO.retrieveWorkerSgAddressById(sgAddressIds.get(i));
                                                    String address = sgAddress.getAddress();
                                                    java.util.Date oDate = sgAddress.getObseleteDate();
                                                    if (oDate != null) {
                                                        address += " (Obsoleted on " + sdf.format(oDate) + ")";
                                                    } else {
                                                        address += " (Active)";
                                                    }
                                                    if (i < sgAddressIds.size() - 1) {
                                        %>
                                        <div class="col-md-6 other_sgaddress moreObjs">

                                            <table class="table table-bordered">
                                                <tr>
                                                    <td style="width:80%"><%=address%></td>
                                                    <td class="text-center" style="width:20%"><a style="color: black" data-class="worker"  data-value='sgadd' data-sgadd='<%=sgAddress.getId()%>' href="" data-toggle="modal" data-target="#sgAdd_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                            </table> 
                                        </div>
                                        <%} else {
                                        %>
                                        <div class="col-md-6">
                                            <table class="table table-bordered">
                                                <tr>
                                                    <td style="width:87%"><%=address%></td>
                                                    <td class="text-center" style="width:13%"><a style="color: black" data-class="worker"  data-value='sgadd' data-sgadd='<%=sgAddress.getId()%>' href="" data-toggle="modal" data-target="#sgAdd_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <%
                                                }

                                            }
                                            if (sgAddressIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_sgaddress_seemore" onclick="seemore('.other_sgaddress');">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_sgaddress_seemore" onclick="seemore('.other_sgaddress');">View Less</a>
                                        <%                                                            }
                                            }
                                        %>
                                    </div>
                                </div>



                                <!--Home Country Address-->
                                <div class="panel panel-default">
                                    <div class="panel-heading">

                                        <h4 class="panel-title">Home Country Address <a data-value='homeadd' data-action = "add" data-homeadd='' href="" data-toggle="modal" data-class="worker"  data-target="#homeAdd_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-plus pull-right" pull-right></a></span></h4>


                                    </div>
                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> homeCountryAddressIds = WorkerComplementsDAO.
                                                    retrieveWorkerHomeCountryAddressIdsOfWorker(worker);
                                            if (homeCountryAddressIds != null && !homeCountryAddressIds.isEmpty()) {
                                                for (int i = homeCountryAddressIds.size() - 1; i >= 0; i--) {
                                                    WorkerHomeCountryAddress addressObj = WorkerComplementsDAO.retrieveWorkerHomeCountryAddressById(homeCountryAddressIds.get(i));
                                                    String address = addressObj.getAddress();
                                                    java.util.Date oDate = addressObj.getObseleteDate();
                                                    if (oDate != null) {
                                                        address += " (Obsoleted on " + sdf.format(oDate) + ")";
                                                    } else {
                                                        address += " (Active)";
                                                    }
                                                    if (i < homeCountryAddressIds.size() - 1) {
                                        %>

                                        <div class="col-md-6 other_homeaddress moreObjs" >
                                            <table class="table table-bordered">
                                                <tr>
                                                    <td style="width:80%"><%=address%></td>
                                                    <td class="text-center" style="width:20%"><a style="color: black" data-class="worker"  data-value='homeadd' data-homeadd='<%=addressObj.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#homeAdd_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                            </table>

                                        </div>
                                        <%} else {
                                        %>
                                        <div class="col-md-6">
                                            <table class="table table-bordered">
                                                <tr>
                                                    <td style="width:90%"><%=address%></td>
                                                    <td class="text-center" style="width:10%"><a style="color: black" data-class="worker"  data-value='homeadd' data-homeadd='<%=addressObj.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#homeAdd_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <%
                                                }
                                            }
                                            if (homeCountryAddressIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_homeaddress_seemore" onclick="seemore('.other_homeaddress')">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_homeaddress_seemore" onclick="seemore('.other_homeaddress')">View Less</a>
                                        <%                                                            }
                                            }
                                        %>
                                    </div>
                                </div>

                                <!--Digital Contacts-->
                                <div class="panel panel-default">

                                    <div class="panel-heading">

                                        <h4 class="panel-title">Digital Contacts
                                            <a data-value='digcontact' data-class="worker"  data-digcontact='' href="" data-action = "add" data-toggle="modal" data-target="#digContact_pop_up" class="edit_btn pop_up_open">
                                                <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                    </div>

                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> digitalContactsIds = WorkerComplementsDAO.retrieveDigitalContactIdsOfWorker(worker);
                                            if (digitalContactsIds != null && !digitalContactsIds.isEmpty()) {

                                        %>

                                        <table class="table table-condensed">
                                            <tr>
                                                <th>Type</th>
                                                <th>Contact Address/No</th>
                                                <th>Owner</th>
                                                <th>Obsoleted Date</th>
                                                <th>Action</th>
                                            </tr>

                                            <%
                                                for (int i = digitalContactsIds.size() - 1; i >= 0; i--) {
                                                    WorkerDigitalContact digitalContact = WorkerComplementsDAO.retrieveWorkerDigitalContactById(digitalContactsIds.get(i));


                                                    String type = digitalContact.getContactType();
                                                    String contactAdd = digitalContact.getContactInfo();
                                                    String owner = digitalContact.getOwner();
                                                    java.util.Date obDate = digitalContact.getObseleteDate();
                                                    if (i < digitalContactsIds.size() - 1) {

                                            %>
                                            <tr class="other_digContact moreObjs" >
                                                <td><%=type%></td>
                                                <td><%=contactAdd%></td>
                                                <td><%=owner%></td>
                                                <%
                                                    if (obDate == null) {
                                                %>
                                                <td>Still in Use</td>
                                                <%                                                } else {
                                                    String obDateStr = sdf.format(obDate);
                                                %>
                                                <td><%=obDateStr%></td>
                                                <%
                                                    }

                                                %>

                                                <td><a style="color: black" data-class="worker"  data-value='digcontact' data-digcontact='<%=digitalContact.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#digContact_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                            } else {
                                            %>
                                            <tr>
                                                <td><%=type%></td>
                                                <td><%=contactAdd%></td>
                                                <td><%=owner%></td>
                                                <%
                                                    if (obDate == null) {
                                                %>
                                                <td>Still in Use</td>
                                                <%                                                } else {
                                                    String obDateStr = sdf.format(obDate);

                                                %>
                                                <td><%=obDateStr%></td>
                                                <%
                                                    }

                                                %>

                                                <td><a style="color: black" data-class="worker"  data-value='digcontact' data-digcontact='<%=digitalContact.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#digContact_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </table>
                                        <%
                                            if (digitalContactsIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_digContact_seemore" onclick="seemore('.other_digContact');">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_digContact_seemore" onclick="seemore('.other_digContact');">View Less</a>
                                        <%                                                            }
                                            }
                                        %>
                                    </div>
                                </div>

                                <!--Next of Kins-->
                                <div class="panel panel-default">

                                    <div class="panel-heading">

                                        <h4 class="panel-title">Next of Kin
                                            <a data-value='nok' data-class="worker"  data-nok='' href="" data-toggle="modal" data-action = "add" data-target="#nok_pop_up" class="edit_btn pop_up_open">
                                                <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                    </div>

                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> nextOfKinsIds = WorkerComplementsDAO.retrieveNextOfKinIdsOfWorker(worker);
                                            if (nextOfKinsIds != null && !nextOfKinsIds.isEmpty()) {
                                        %>

                                        <table class="table table-condensed">
                                            <tr>
                                                <th>Name</th>
                                                <th>Relationship</th>
                                                <th>Contact No</th>
                                                <th>Other Contacts</th>
                                                <th>Action</th>
                                            </tr>

                                            <%
                                                for (int i = nextOfKinsIds.size() - 1; i >= 0; i--) {
                                                    WorkerNextOfKin nextOfKins = WorkerComplementsDAO.retrieveWorkerNextOfKinById(nextOfKinsIds.get(i));
                                                    String name = nextOfKins.getName();
                                                    String relationship = nextOfKins.getRelation();
                                                    String phNum = nextOfKins.getPhoneNumber();
                                                    String otherContact = nextOfKins.getDigital();
                                                    java.util.Date obDate = nextOfKins.getObseleteDate();

                                                    if (i < nextOfKinsIds.size() - 1) {

                                            %>
                                            <tr class="other_nok moreObjs">
                                                <td><%=name%></td>
                                                <td><%=(relationship == null) ? "" : relationship%></td>
                                                <td><%=(phNum == null) ? "" : phNum%></td>
                                                <td><%=(otherContact == null) ? "" : otherContact%></td>


                                                <td><a style="color: black"  data-class="worker" data-value='nok' data-nok='<%=nextOfKins.getId()%>' href="" data-toggle="modal" data-target="#nok_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                            } else {
                                            %>
                                            <tr>
                                                <td><%=name%></td>
                                                <td><%=(relationship == null) ? "" : relationship%></td>
                                                <td><%=(phNum == null) ? "" : phNum%></td>
                                                <td><%=(otherContact == null) ? "" : otherContact%></td>

                                                <td><a style="color: black"  data-class="worker" data-value='nok' data-nok='<%=nextOfKins.getId()%>' href="" data-toggle="modal" data-target="#nok_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </table>
                                        <%
                                            if (nextOfKinsIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_nok_seemore" onclick="seemore('.other_nok')">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_nok_seemore" onclick="seemore('.other_nok')">View Less</a>
                                        <%                                                            }
                                            }
                                        %>
                                    </div>
                                </div>

                                <!--Family Members-->
                                <div class="panel panel-default">

                                    <div class="panel-heading">

                                        <h4 class="panel-title">Family Members
                                            <a data-value='familymember' data-class="worker"  data-familymember='' href="" data-action = "add" data-toggle="modal" data-target="#familyMember_pop_up" class="edit_btn pop_up_open">
                                                <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                    </div>

                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> familyMmbrIds = WorkerComplementsDAO.retrieveFamilyMemberIdsOfWorker(worker);
                                            if (familyMmbrIds != null && !familyMmbrIds.isEmpty()) {
                                        %>

                                        <table class="table table-condensed">
                                            <tr>
                                                <th>Name</th>
                                                <th>Relationship</th>
                                                <th>Contact No</th>
                                                <th>Other Contacts</th>
                                                <th>Action</th>
                                            </tr>

                                            <%
                                                for (int i = 0; i < familyMmbrIds.size(); i++) {
                                                    WorkerFamilyMember familyMember = WorkerComplementsDAO.retrieveWorkerFamilyMemberById(familyMmbrIds.get(i));

                                                    String name = familyMember.getName();
                                                    String relationship = familyMember.getRelation();
                                                    String phNum = familyMember.getPhoneNumber();
                                                    String otherContact = familyMember.getDigital();
                                                    java.util.Date obDate = familyMember.getObseleteDate();
                                                    if (i < familyMmbrIds.size() - 1) {
                                            %>
                                            <tr class="other_familyMember moreObjs" >
                                                <td><%=name%></td>
                                                <td><%=relationship%></td>
                                                <td><%=phNum%></td>
                                                <td><%=otherContact%></td>
                                                <td><a style="color: black" data-class="worker"  data-value='familymember' data-familymember='<%=familyMember.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#familyMember_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                            } else {
                                            %>
                                            <tr>
                                                <td><%=name%></td>
                                                <td><%=relationship%></td>
                                                <td><%=phNum%></td>
                                                <td><%=otherContact%></td>
                                                <td><a style="color: black" data-class="worker"  data-value='familymember' data-familymember='<%=familyMember.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#familyMember_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </table>
                                        <%
                                            if (familyMmbrIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_familyMember_seemore" onclick="seemore('.other_familyMember')">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_familyMember_seemore" onclick="seemore('.other_familyMember')">View Less</a>
                                        <%                                                            }
                                            }
                                        %>
                                    </div>
                                </div>

                                <!--Friends in Singapore-->
                                <div class="panel panel-default">

                                    <div class="panel-heading">

                                        <h4 class="panel-title">Friends In Singapore
                                            <a data-value='sgfri' data-sgfri='' data-class="worker"  href="" data-toggle="modal" data-action = "add" data-target="#sgFri_pop_up" class="edit_btn pop_up_open">
                                                <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                    </div>

                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> friendIds = WorkerComplementsDAO.retrieveFriendIdsOfWorker(worker);
                                            if (friendIds != null && !friendIds.isEmpty()) {
                                        %>

                                        <table class="table table-condensed">
                                            <tr>
                                                <th>Name</th>
                                                <th>Relationship</th>
                                                <th>Phone No</th>
                                                <th>Obsolete Date</th>
                                                <th>Action</th>
                                            </tr>

                                            <%
                                                for (int i = friendIds.size() - 1; i >= 0; i--) {
                                                    WorkerFriend friend = WorkerComplementsDAO.retrieveWorkerFriendById(friendIds.get(i));

                                                    String name = friend.getName();
                                                    String relationship = friend.getRelation();
                                                    String phNum = friend.getPhone();
                                                    //String remark = friend.getRemark();
                                                    java.util.Date obDate = friend.getObseleteDate();
                                                    if (i < friendIds.size() - 1) {
                                            %>
                                            <tr class="moreObjs other_friend">
                                                <td><%=name%></td>
                                                <td><%=relationship%></td>
                                                <td><%=phNum%></td>
                                                <td><%=(obDate == null) ? "" : sdf.format(obDate)%></td>
                                                <td><a style="color: black" data-class="worker"  data-value='sgfri' data-sgfri='<%=friend.getId()%>' href="" data-toggle="modal" data-target="#sgFri_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                            } else {
                                            %>
                                            <tr>
                                                <td><%=name%></td>
                                                <td><%=relationship%></td>
                                                <td><%=phNum%></td>
                                                <td><%=(obDate == null) ? "" : sdf.format(obDate)%></td>
                                                <td><a style="color: black" data-class="worker"  data-value='sgfri' data-sgfri='<%=friend.getId()%>' href="" data-toggle="modal" data-target="#sgFri_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </table>
                                        <%
                                            if (friendIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_friend_seemore" onclick="seemore('.other_friend')">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_friend_seemore" onclick="seemore('.other_friend')">View Less</a>
                                        <%                                                            }
                                            }
                                        %>
                                    </div>
                                </div>

                                <!--Worker's Language-->
                                <div class="panel panel-default">

                                    <div class="panel-heading">

                                        <h4 class="panel-title">Language
                                            <a data-value='language' data-class="worker"  data-language='' href="" data-toggle="modal" data-action = "add" data-target="#language_pop_up" class="edit_btn pop_up_open">
                                                <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                    </div>

                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> languagueIds = WorkerComplementsDAO.retrieveLanguageIdsOfWorker(worker);
                                            if (languagueIds != null && !languagueIds.isEmpty()) {
                                        %>

                                        <table class="table table-condensed">
                                            <tr>
                                                <th>Language</th>
                                                <th>Spoken English Standard</th>
                                                <th>Remark</th>
                                                <th>Action</th>
                                            </tr>

                                            <%
                                                for (int i = 0; i < languagueIds.size(); i++) {
                                                    WorkerLanguage language = WorkerComplementsDAO.retrieveWorkerLanguageById(languagueIds.get(i));
                                                    String mlanguage = language.getMainLanguage();
                                                    String engStd = language.getSpokenLanguageStandard();
                                                    String remark = language.getRemark();

                                                    if (i < languagueIds.size() - 1) {
                                            %>
                                            <tr class="other_language moreObjs">
                                                <td><%=mlanguage%></td>
                                                <td><%=engStd%></td>
                                                <td><%=(remark == null) ? "" : remark%></td>
                                                <td><a style="color: black"  data-class="worker" data-value='language' data-language='<%=language.getId()%>' href="" data-toggle="modal" data-target="#language_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                            } else {
                                            %>
                                            <tr>
                                                <td><%=mlanguage%></td>
                                                <td><%=engStd%></td>
                                                <td><%=(remark == null) ? "" : remark%></td>
                                                <td><a style="color: black"  data-class="worker" data-value='language' data-language='<%=language.getId()%>' href="" data-toggle="modal" data-target="#language_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </table>
                                        <%
                                            if (languagueIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_language_seemore" onclick="seemore('.other_language')">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_language_seemore" onclick="seemore('.other_language')">View Less</a>
                                        <%                                                            }
                                            }
                                        %>
                                    </div>
                                </div>

                                <!--Bank Account Details-->
                                <div class="panel panel-default">

                                    <div class="panel-heading">

                                        <h4 class="panel-title">Bank Account Details
                                            <a data-value='bankacc' data-class="worker"  data-bankacc='' href="" data-toggle="modal" data-action = "add" data-target="#bankAcc_pop_up" class="edit_btn pop_up_open">
                                                <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                    </div>

                                    <div class="panel-body text-capitalize">
                                        <%
                                            ArrayList<Integer> bankAcctDetailsIds = WorkerComplementsDAO.retrieveBankAccountDetailsIdsOfWorker(worker);
                                            if (bankAcctDetailsIds != null && !bankAcctDetailsIds.isEmpty()) {
                                        %>

                                        <table class="table table-condensed">
                                            <tr>
                                                <th>Bank Name</th>
                                                <th>Account Name</th>
                                                <th>Bank Acc No</th>
                                                <th>Obsoleted Date</th>
                                                <th>Action</th>
                                            </tr>

                                            <%
                                                for (int i = bankAcctDetailsIds.size() - 1; i >= 0; i--) {
                                                    WorkerBankAcct bankAcct = WorkerComplementsDAO.retrieveBankAccountDetailsById(bankAcctDetailsIds.get(i));
                                                    String bank = bankAcct.getBankName();
                                                    String acctype = bankAcct.getBankAcctName();
                                                    String accno = bankAcct.getBankAcctNumber();
                                                    java.util.Date obDate = bankAcct.getObseleteDate();

                                                    if (i < bankAcctDetailsIds.size() - 1) {
                                            %>
                                            <tr class="other_bankacc moreObjs">
                                                <td><%=bank%></td>
                                                <td><%=acctype%></td>
                                                <td><%=accno%></td>
                                                <%
                                                    if (obDate == null) {
                                                %>
                                                <td>-</td>
                                                <%                                                } else {
                                                    String obDateStr = sdf.format(obDate);
                                                %>
                                                <td><%=obDateStr%></td>
                                                <%
                                                    }

                                                %>

                                                <td><a style="color: black" data-value='bankacc' data-bankacc='<%=bankAcct.getId()%>' href="" data-toggle="modal" data-class="worker"  data-target="#bankAcc_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                            } else {
                                            %>
                                            <tr>
                                                <td><%=bank%></td>
                                                <td><%=acctype%></td>
                                                <td><%=accno%></td>
                                                <%
                                                    if (obDate == null) {
                                                %>
                                                <td>-</td>
                                                <%                                                } else {
                                                    String obDateStr = sdf.format(obDate);
                                                %>
                                                <td><%=obDateStr%></td>
                                                <%
                                                    }

                                                %>

                                                <td><a style="color: black" data-value='bankacc' data-bankacc='<%=bankAcct.getId()%>' href="" data-toggle="modal" data-class="worker"  data-target="#bankAcc_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                            </tr>
                                            <%
                                                    }
                                                }
                                            %>
                                        </table>
                                        <%
                                            if (bankAcctDetailsIds.size() > 1) {
                                        %>

                                        <a href="#" class="text-center col-sm-12 seemore_btn other_bankacc_seemore" onclick="seemore('.other_bankacc')">See more</a>
                                        <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_bankacc_seemore" onclick="seemore('.other_bankacc')">View Less</a>
                                        <%                                                            }
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>

                            <!----Job Complement Tab--->        
                            <div class="tab-pane " id="job_complement">
                                <br/>
                                <div class="row">
                                    <form method="POST" action="changeToSelected">
                                        <div class="form-group">
                                            <label for="jobSelected" class="col-md-1 control-label">Select Job:</label>
                                            <div class="col-md-1">
                                                <input type="hidden" name="workerFin" value="<%=workerFin%>"/>
                                                <input type="hidden" name="selectedType" value="job"/>
                                                <select class="form-control text-capitalize" id="jobSelected" name="selectedJob" required>
                                                    <%
                                                        for (int i = 0; i < jobIds.size(); i++) {
                                                            int Id = jobIds.get(i);
                                                            Job tempJob = JobDAO.retrieveJobByJobId(Id);
                                                            String jobEmp = tempJob.getEmployerName();
                                                            if ((i + 1) == jobIds.size()) {
                                                    %>
                                                    <option value="<%=Id%>" selected><%=jobEmp%></option>
                                                    <%
                                                    } else {
                                                    %>
                                                    <option value="<%=Id%>"><%=jobEmp%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>

                                                </select>
                                            </div>

                                            <button type='submit' onclick="" class="btn btn-default  col-md-1">Submit</button>
                                            <button type='button' data-title="Add New Job" data-action="add" data-value="job" class="btn btn-default profile_details  pull-right">Add New Job</button>

                                        </div>
                                    </form>
                                    <!--need to change the vlaue of job id when the user change the dropdown value-->
                                </div>


                                <br/>


                                <!--job complements here-->
                                <div class="row">

                                    <%

                                    %>
                                    <!--Pass Details-->
                                    <div class="panel panel-default">

                                        <div class="panel-heading">


                                            <h4 class="panel-title">Pass Details
                                                <a style="color: black" data-class="job"  data-value='passdetails' data-passdetails='' href="" data-toggle="modal" data-target="#passdetails_pop_up" data-action="add" class="view_btn pop_up_open">
                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                        </div>

                                        <div class="panel-body text-capitalize">
                                            <%
                                                ArrayList<Integer> jobPassDetailsIds = JobComplementsDAO.retrievePassDetailsIdsOfJob(latestJob);
                                                if (jobPassDetailsIds != null && !jobPassDetailsIds.isEmpty()) {

                                            %>

                                            <table class="table table-condensed">
                                                <tr>
                                                    <th>Pass Type</th>
                                                    <th>Pass Number</th>
                                                    <th>Issued Date</th>
                                                    <th>Expiry Date</th>
                                                    <th>Action</th>
                                                </tr>

                                                <%

                                                    for (int i = jobPassDetailsIds.size() - 1; i >= 0; i--) {
                                                        JobPassDetails tempPass = JobComplementsDAO.
                                                                retrieveJobPassDetailsById(jobPassDetailsIds.get(i));
                                                        String passType = tempPass.getPassType();
                                                        String passNo = tempPass.getPassNum();
                                                        java.util.Date isDate = tempPass.getIssueDate();
                                                        java.util.Date exDate = tempPass.getExpiryDate();

                                                        if (i < jobPassDetailsIds.size() - 1) {

                                                %>
                                                <tr class="moreObjs other_jobpass">
                                                    <td><%=passType%></td>
                                                    <td><%=passNo%></td>
                                                    <td><%=(isDate == null) ? "-" : sdf.format(isDate)%></td>
                                                    <td><%=(exDate == null) ? "-" : sdf.format(exDate)%></td>

                                                    <td><a style="color: black" data-class="job"  data-value="passdetails" data-passdetails="<%=tempPass.getId()%>" href="" data-toggle="modal" data-action="viewedit" data-target="#passdetails_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                                <%
                                                } else {
                                                %>
                                                <tr>
                                                    <td><%=passType%></td>
                                                    <td><%=passNo%></td>
                                                    <td><%=(isDate == null) ? "-" : sdf.format(isDate)%></td>
                                                    <td><%=(exDate == null) ? "-" : sdf.format(exDate)%></td>
                                                    <td><a style="color: black" data-class="job"  data-value="passdetails" data-passdetails="<%=tempPass.getId()%>" href="" data-toggle="modal" data-action="viewedit" data-target="#passdetails_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>
                                            <%
                                                if (jobPassDetailsIds.size() > 1) {
                                            %>

                                            <a href="#" class="text-center col-sm-12 seemore_btn other_jobpass_seemore" onclick="seemore('.other_jobpass')">See more</a>
                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_jobpass_seemore" onclick="seemore('.other_jobpass')">View Less</a>
                                            <%                                                            }
                                                }
                                            %>
                                        </div>
                                    </div>


                                    <!--Employer Details-->
                                    <div class="panel panel-default">

                                        <div class="panel-heading">

                                            <h4 class="panel-title">Employer Details
                                                <a style="color: black" data-class="job"  data-value='empdetails' data-empdetails='' href="" data-toggle="modal" data-target="#empdetails_pop_up" data-action="add" class="view_btn pop_up_open">
                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                        </div>

                                        <div class="panel-body text-capitalize">
                                            <%
                                                ArrayList<Integer> empIdsList = JobComplementsDAO.retrieveJobEmployerIdsOfJob(latestJob);
                                                if (empIdsList != null && !empIdsList.isEmpty()) {

                                            %>

                                            <table class="table table-condensed">
                                                <tr>
                                                    <th>Employer's Name</th>
                                                    <th>Employer's ID</th>
                                                    <th>Employer's Contact</th>
                                                    <th>Key Person</th>
                                                    <th>Action</th>
                                                </tr>

                                                <%
                                                    for (int i = empIdsList.size() - 1; i >= 0; i--) {
                                                        JobEmployer jobEmp = JobComplementsDAO.retrieveJobEmployerById(empIdsList.get(i));
                                                        String empName = jobEmp.getEmployerOfficialName();
                                                        String empId = jobEmp.getEmployerID();
                                                        String empAddress = jobEmp.getEmployerAddress();
                                                        String empContact = jobEmp.getEmployerContacts();
                                                        String empKeyPerson = jobEmp.getEmployerPersons();

                                                        if (i < empIdsList.size() - 1) {
                                                %>
                                                <tr class="other_employer moreObjs">
                                                    <td><%=empName%></td>
                                                    <td><%=empId%></td>
                                                    <td><%=empContact%></td>
                                                    <td><%=empKeyPerson%></td>
                                                    <td><a style="color: black"  data-class="job" data-value='empdetails' data-empdetails='<%=jobEmp.getId()%>' 
                                                           href="" data-toggle="modal" data-target="#empdetails_pop_up" data-action="viewedit" 
                                                           class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                                <%
                                                } else {
                                                %>
                                                <tr>
                                                    <td><%=empName%></td>
                                                    <td><%=empId%></td>
                                                    <td><%=empContact%></td>
                                                    <td><%=empKeyPerson%></td>
                                                    <td><a style="color: black"  data-class="job" data-value='empdetails' data-empdetails='<%=jobEmp.getId()%>' 
                                                           href="" data-toggle="modal" data-target="#empdetails_pop_up" data-action="viewedit" 
                                                           class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>
                                            <%
                                                if (empIdsList.size() > 1) {
                                            %>

                                            <a href="#" class="text-center col-sm-12 seemore_btn other_employer_seemore" onclick="seemore('.other_employer')">See more</a>
                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_employer_seemore" onclick="seemore('.other_employer')">View Less</a>
                                            <%                                                            }
                                                }
                                            %>
                                        </div>
                                    </div>


                                    <!--Employment Contract-->
                                    <div class="panel panel-default">

                                        <div class="panel-heading">

                                            <h4 class="panel-title">Employment Contract
                                                <a style="color: black"  data-class="job" data-value='empcontract' data-empcontract='' href="" data-toggle="modal" data-target="#empcontract_pop_up" data-action="add" class="view_btn pop_up_open">
                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                        </div>

                                        <div class="panel-body text-capitalize">
                                            <%
                                                ArrayList<Integer> empContractIdsList = JobComplementsDAO.retrieveEmploymentContractIdsOfJob(latestJob);
                                                if (empContractIdsList != null && !empContractIdsList.isEmpty()) {

                                            %>

                                            <table class="table table-condensed">
                                                <tr>
                                                    <th>Contract Date</th>
                                                    <th>Where Signed</th>
                                                    <th>Name of Opposite Party</th>
                                                    <th>Basic Salary</th>
                                                    <th>Action</th>
                                                </tr>

                                                <%
                                                    for (int i = empContractIdsList.size() - 1; i >= 0; i--) {
                                                        JobEmploymentContract empContract = JobComplementsDAO.retrieveEmploymentContractById(empContractIdsList.get(i));
                                                        java.util.Date contraDate = empContract.getContractDate();
                                                        String contraWhere = empContract.getContractWhere();
                                                        String contraName = empContract.getContractOppName();
                                                        String contraSalary = empContract.getContractBasicSalary();
                                                        if (i < empContractIdsList.size() - 1) {
                                                %>
                                                <tr class="other_contract moreObjs">
                                                    <%
                                                        if (contraDate == null) {
                                                    %>
                                                    <td>-</td>
                                                    <%                                                    } else {
                                                        String contraDateStr = sdf.format(contraDate);
                                                    %>
                                                    <td><%=contraDateStr%></td>
                                                    <%
                                                        }

                                                    %>
                                                    <td><%=contraWhere%></td>
                                                    <td><%=contraName%></td>
                                                    <td><%=contraSalary%></td>

                                                    <td><a style="color: black"  data-class="job" data-value='empcontract' 
                                                           data-empcontract='<%=empContract.getId()%>' href="" 
                                                           data-toggle="modal" data-target="#empcontract_pop_up" 
                                                           data-action="viewedit" class="view_btn pop_up_open">
                                                            <span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                                <%
                                                } else {
                                                %>
                                                <tr>
                                                    <%
                                                        if (contraDate == null) {
                                                    %>
                                                    <td>-</td>
                                                    <%                                                    } else {
                                                        String contraDateStr = sdf.format(contraDate);
                                                    %>
                                                    <td><%=contraDateStr%></td>
                                                    <%
                                                        }

                                                    %>
                                                    <td><%=contraWhere%></td>
                                                    <td><%=contraName%></td>
                                                    <td><%=contraSalary%></td>

                                                    <td>
                                                        <a style="color: black"  data-class="job" data-value='empcontract' 
                                                           data-empcontract='<%=empContract.getId()%>' 
                                                           href="" data-toggle="modal" data-target="#empcontract_pop_up" 
                                                           data-action="viewedit" class="view_btn pop_up_open">
                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>
                                            <%
                                                if (empContractIdsList.size() > 1) {
                                            %>

                                            <a href="#" class="text-center col-sm-12 seemore_btn other_contract_seemore" onclick="seemore('.other_contract')">See more</a>
                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_contract_seemore" onclick="seemore('.other_contract')">View Less</a>
                                            <%                                                            }
                                                }
                                            %>
                                        </div>
                                    </div>


                                    <!--Intermediary Agent-->
                                    <div class="panel panel-default">

                                        <div class="panel-heading">

                                            <h4 class="panel-title">Intermediary Agent
                                                <a style="color: black" data-value='agent' data-agent='' href="" data-toggle="modal" data-class="job"  data-target="#agent_pop_up" data-action="add" class="view_btn pop_up_open">
                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                        </div>

                                        <div class="panel-body text-capitalize">
                                            <%
                                                ArrayList<Integer> agentIdsList = JobComplementsDAO.retrieveJobIntermediaryAgentIdsOfJob(latestJob);
                                                if (agentIdsList != null && !agentIdsList.isEmpty()) {

                                            %>

                                            <table class="table table-condensed">
                                                <tr>
                                                    <th>Agency Name</th>
                                                    <th>Key Person Name</th>
                                                    <th>Amount Paid</th>
                                                    <th>Where Agent Fee Paid</th>
                                                    <th>Action</th>
                                                </tr>

                                                <%
                                                    for (int i = agentIdsList.size() - 1; i >= 0; i--) {
                                                        JobIntermediaryAgent agent = JobComplementsDAO.retrieveJobIntermediaryAgentById(agentIdsList.get(i));

                                                        String agentName = agent.getAgentCompany();
                                                        String agentPName = agent.getAgentPersonName();
                                                        double agentPaidAmt = agent.getAgentAmtPaid();
                                                        String agentFWhere = agent.getAgentFeeWhere();

                                                        if (i < agentIdsList.size() - 1) {
                                                %>
                                                <tr class="other_agent moreObjs">
                                                    <td><%=agentName%></td>
                                                    <td><%=agentPName%></td>
                                                    <td><%=agentPaidAmt%></td>
                                                    <td><%=agentFWhere%></td>

                                                    <td>
                                                        <a style="color: black" data-value='agent' data-agent='<%=agent.getID()%>'  data-class="job" 
                                                           href="" data-toggle="modal" data-target="#agent_pop_up" data-action="viewedit" 
                                                           class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                } else {
                                                %>
                                                <tr>
                                                    <td><%=agentName%></td>
                                                    <td><%=agentPName%></td>
                                                    <td><%=agentPaidAmt%></td>
                                                    <td><%=agentFWhere%></td>

                                                    <td>
                                                        <a style="color: black" data-value='agent' data-agent='<%=agent.getID()%>'  data-class="job" 
                                                           href="" data-toggle="modal" data-target="#agent_pop_up" data-action="viewedit" 
                                                           class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>
                                            <%
                                                if (agentIdsList.size() > 1) {
                                            %>

                                            <a href="#" class="text-center col-sm-12 seemore_btn other_agent_seemore" onclick="seemore('.other_agent')">See more</a>
                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_agent_seemore" onclick="seemore('.other_agent')">View Less</a>
                                            <%                                                            }
                                                }
                                            %>
                                        </div>
                                    </div>

                                    <!--Verbal Assurance of Previous Job-->
                                    <div class="panel panel-default">

                                        <div class="panel-heading">

                                            <h4 class="panel-title">Verbal Assurance of Previous Job
                                                <a style="color: black" data-value='assurance' data-assurance='' href=""  data-class="job" data-toggle="modal" data-target="#assurance_pop_up" data-action="add" class="view_btn pop_up_open">
                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                        </div>

                                        <div class="panel-body text-capitalize">
                                            <%
                                                ArrayList<Integer> verbalIdsList = JobComplementsDAO.retrieveVerbalAssuranceOfJob(latestJob);
                                                if (verbalIdsList != null && !verbalIdsList.isEmpty()) {

                                            %>

                                            <table class="table table-condensed">
                                                <tr>
                                                    <th>Name of giver of <br/>verbal assurances</th>
                                                    <th>Relationship of giver to <br/> worker or agent or employer</th>
                                                    <th>When verbal assurances given</th>
                                                    <th>Where verbal assurances given</th>
                                                    <th>Action</th>
                                                </tr>

                                                <%
                                                    for (int i = verbalIdsList.size() - 1; i >= 0; i--) {
                                                        JobVerbalAssurance assurance = JobComplementsDAO.retrieveVerbalAssuranceDetailsById(verbalIdsList.get(i));

                                                        String verbalName = assurance.getVerbalName();
                                                        String verbalRelation = assurance.getVerbalRelationship();
                                                        String verbalWhen = assurance.getWhen();
                                                        String verbalWhere = assurance.getWhere();
                                                        String verbalContent = assurance.getContent();

                                                        if (i < verbalIdsList.size() - 1) {
                                                %>
                                                <tr class="other_va moreObjs">

                                                    <td><%=verbalName%></td>
                                                    <td><%=verbalRelation%></td>
                                                    <td><%=verbalWhen%></td>
                                                    <td><%=verbalWhere%></td>
                                                    <td>
                                                        <a style="color: black" data-value='assurance' data-assurance='<%=assurance.getId()%>'  data-class="job" 
                                                           href="" data-toggle="modal" data-target="#assurance_pop_up" data-action="viewedit" 
                                                           class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                } else {
                                                %>
                                                <tr>

                                                    <td><%=verbalName%></td>
                                                    <td><%=verbalRelation%></td>
                                                    <td><%=verbalWhen%></td>
                                                    <td><%=verbalWhere%></td>
                                                    <td>
                                                        <a style="color: black" data-value='assurance' data-assurance='<%=assurance.getId()%>'  data-class="job" 
                                                           href="" data-toggle="modal" data-target="#assurance_pop_up" data-action="viewedit" 
                                                           class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>
                                            <%
                                                if (verbalIdsList.size() > 1) {
                                            %>

                                            <a href="#" class="text-center col-sm-12 seemore_btn other_va_seemore" onclick="seemore('.other_va')">See more</a>
                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_va_seemore" onclick="seemore('.other_va')">View Less</a>
                                            <%                                                            }
                                                }
                                            %>
                                        </div>
                                    </div>


                                    <!--Work Place Details-->
                                    <div class="panel panel-default">

                                        <div class="panel-heading">

                                            <h4 class="panel-title">Work Place Details
                                                <a style="color: black" data-value='wplace' data-wplace='' href="" data-toggle="modal"  data-class="job" data-target="#wplace_pop_up" data-action="add" class="view_btn pop_up_open">
                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                        </div>

                                        <div class="panel-body text-capitalize">
                                            <%
                                                ArrayList<Integer> workPlaceIdsList = JobComplementsDAO.retrieveJobWorkplaceIdsOfJob(latestJob);
                                                if (workPlaceIdsList != null && !workPlaceIdsList.isEmpty()) {

                                            %>

                                            <table class="table table-condensed">
                                                <tr>
                                                    <th>Workplace Type</th>
                                                    <th>Workplace Owner</th>
                                                    <th>Start Date at the Workplace</th>
                                                    <th>End Date at the Workplace</th>
                                                    <th>Action</th>
                                                </tr>

                                                <%
                                                    for (int i = workPlaceIdsList.size() - 1; i >= 0; i--) {
                                                        JobWorkplace workPlace = JobComplementsDAO.retrieveJobWorkplaceById(workPlaceIdsList.get(i));

                                                        String wpType = workPlace.getWorkplaceType();
                                                        String wpOwner = workPlace.getWorkplaceWhose();
                                                        String wpSDate = workPlace.getWorkplaceStart();
                                                        String wpEDate = workPlace.getWorkplaceEnd();

                                                        if (i < workPlaceIdsList.size() - 1) {
                                                %>
                                                <tr class="other_workplace moreObjs">
                                                    <td><%=wpType%></td>
                                                    <td><%=wpOwner%></td>
                                                    <td><%=wpSDate%></td>
                                                    <td><%=wpEDate%></td>

                                                    <td>
                                                        <a style="color: black" data-value='wplace' data-wplace='<%=workPlace.getId()%>' data-class="job"  href="" data-toggle="modal" data-target="#wplace_pop_up" data-action="viewedit" class="view_btn pop_up_open">
                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                } else {
                                                %>
                                                <tr>
                                                    <td><%=wpType%></td>
                                                    <td><%=wpOwner%></td>
                                                    <td><%=wpSDate%></td>
                                                    <td><%=wpEDate%></td>

                                                    <td>
                                                        <a style="color: black" data-value='wplace' data-wplace='<%=workPlace.getId()%>' data-class="job"  href="" data-toggle="modal" data-target="#wplace_pop_up" data-action="viewedit" class="view_btn pop_up_open">
                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>

                                            <%
                                                if (workPlaceIdsList.size() > 1) {
                                            %>

                                            <a href="#" class="text-center col-sm-12 seemore_btn other_workplace_seemore" onclick="seemore('.other_workplace');">See more</a>
                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_workplace_seemore" onclick="seemore('.other_workplace');">View Less</a>
                                            <%                                                            }
                                                }
                                            %>
                                        </div>
                                    </div>

                                    <!--Work History-->
                                    <div class="panel panel-default">

                                        <div class="panel-heading">

                                            <h4 class="panel-title">Work History
                                                <a style="color: black" data-value='whistory' data-whistory='' href="" data-toggle="modal" data-class="job"  data-target="#whistory_pop_up" data-action="add" class="view_btn pop_up_open">
                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                        </div>

                                        <div class="panel-body text-capitalize">
                                            <%
                                                ArrayList<Integer> historyIdsList = JobComplementsDAO.retrieveJobWorkHistoryIdsOfJob(latestJob);
                                                if (historyIdsList != null && !historyIdsList.isEmpty()) {

                                            %>

                                            <table class="table table-condensed">
                                                <tr>
                                                    <th>How did worker get into this job?</th>
                                                    <th>Date Arrived to Singapore</th>
                                                    <th>Is this first job in Singapore?</th>
                                                    <th>If not, state the arrival year to Singapore for the First Job</th>
                                                    <th>Action</th>
                                                </tr>

                                                <%
                                                    for (int i = historyIdsList.size() - 1; i >= 0; i--) {
                                                        JobWorkHistory history = JobComplementsDAO.retrieveJobWorkHistoryById(historyIdsList.get(i));

                                                        String historyHow = history.getWorkHistHow();
                                                        java.util.Date historyArrDate = history.getWorkHistDate();
                                                        String historyFirstJob = history.getWorkHistFirst();
                                                        String historyArrYear = history.getWorkHistYearArrive();
                                                        if (i < historyIdsList.size() - 1) {
                                                %>
                                                <tr class="other_workhistory moreObjs">
                                                    <td><%=historyHow%></td>
                                                    <td><%=(historyArrDate == null) ? "-" : sdf.format(historyArrDate)%></td>                        
                                                    <td><%=historyFirstJob%></td>
                                                    <td><%=historyArrYear%></td>

                                                    <td><a style="color: black" data-value='whistory' data-whistory='<%=history.getId()%>' href="" data-toggle="modal"  data-class="job" data-target="#whistory_pop_up" data-action="viewedit" class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                                <%
                                                } else {
                                                %>
                                                <tr>
                                                    <td><%=historyHow%></td>
                                                    <td><%=(historyArrDate == null) ? "-" : sdf.format(historyArrDate)%></td>                                       
                                                    <td><%=historyFirstJob%></td>
                                                    <td><%=historyArrYear%></td>

                                                    <td><a style="color: black" data-value='whistory' data-whistory='<%=history.getId()%>' href="" data-toggle="modal"  data-class="job" data-target="#whistory_pop_up" data-action="viewedit" class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>
                                            <%
                                                if (historyIdsList.size() > 1) {
                                            %>

                                            <a href="#" class="text-center col-sm-12 seemore_btn other_workhistory_seemore" onclick="seemore('.other_workhistory')">See more</a>
                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_workhistory_seemore" onclick="seemore('.other_workhistory')">View Less</a>
                                            <%                                                            }
                                                }
                                            %>
                                        </div>
                                    </div>


                                    <!--Accommodation During Work-->
                                    <div class="panel panel-default">

                                        <div class="panel-heading">

                                            <h4 class="panel-title">Accommodation During Work
                                                <a style="color: black" data-value='waccom' data-waccom='' href="" data-toggle="modal"  data-class="job" data-target="#waccom_pop_up" data-action="add" class="view_btn pop_up_open">
                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                        </div>

                                        <div class="panel-body text-capitalize">
                                            <%
                                                ArrayList<Integer> accomodoIdsList = JobComplementsDAO.retrieveJobAccomodationIdsOfJob(latestJob);
                                                if (accomodoIdsList != null && !accomodoIdsList.isEmpty()) {

                                            %>

                                            <table class="table table-condensed">
                                                <tr>
                                                    <th>Accommodation provided by employer?</th>
                                                    <th>Type of accommodation</th>
                                                    <th>Location</th>
                                                    <th>When Existed?</th>
                                                    <th>Action</th>
                                                </tr>

                                                <%
                                                    for (int i = accomodoIdsList.size() - 1; i >= 0; i--) {
                                                        JobAccomodation accomodation = JobComplementsDAO.retrieveJobAccomodationById(accomodoIdsList.get(i));

                                                        String accomProvided = accomodation.getAccProvided();
                                                        String accomType = accomodation.getAccType();
                                                        String accomLocation = accomodation.getAccLocation();
                                                        String accomEnd = accomodation.getAccEnd();
                                                        if (i < accomodoIdsList.size() - 1) {
                                                %>
                                                <tr class="other_accom moreObjs">
                                                    <td><%=accomProvided%></td>
                                                    <td><%=accomType%></td>
                                                    <td><%=accomLocation%></td>
                                                    <td><%=accomEnd%></td>

                                                    <td><a style="color: black" data-value='waccom' data-waccom='<%=accomodation.getId()%>'  data-class="job"  href="" data-toggle="modal" data-target="#waccom_pop_up" data-action="viewedit" 
                                                           class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                } else {
                                                %>
                                                <tr>
                                                    <td><%=accomProvided%></td>
                                                    <td><%=accomType%></td>
                                                    <td><%=accomLocation%></td>
                                                    <td><%=accomEnd%></td>

                                                    <td><a style="color: black" data-value='waccom' data-waccom='<%=accomodation.getId()%>'  data-class="job"  href="" data-toggle="modal" data-target="#waccom_pop_up" data-action="viewedit" 
                                                           class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>
                                            <%
                                                if (accomodoIdsList.size() > 1) {
                                            %>

                                            <a href="#" class="text-center col-sm-12 seemore_btn other_accom_seemore" onclick="seemore('.other_accom')">See more</a>
                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_accom_seemore" onclick="seemore('.other_accom')">View Less</a>
                                            <%                                                            }
                                                }
                                            %>
                                        </div>
                                    </div>

                                    <!--IPA Details-->
                                    <div class="panel panel-default">

                                        <div class="panel-heading">

                                            <h4 class="panel-title">IPA Details
                                                <a style="color: black" data-value='ipa' data-ipa='' href="" data-toggle="modal" data-class="job"  data-target="#ipa_pop_up" data-action="add" class="view_btn pop_up_open">
                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                        </div>

                                        <div class="panel-body text-capitalize">
                                            <%
                                                ArrayList<Integer> ipaIdList = JobComplementsDAO.retrieveIPADetailsIdsOfJob(latestJob);
                                                if (ipaIdList != null && !ipaIdList.isEmpty()) {

                                            %>

                                            <table class="table table-condensed">
                                                <tr>
                                                    <th>Workpass specified in IPA</th>
                                                    <th>IPA application date </th>
                                                    <th>IPA employer name</th>
                                                    <th>Basic Monthly Salary</th>
                                                    <th>Action</th>
                                                </tr>

                                                <%
                                                    for (int i = ipaIdList.size() - 1; i >= 0; i--) {
                                                        JobIPADetails ipa = JobComplementsDAO.retrieveJobIPADetailsById(ipaIdList.get(i));
                                                        String ipaPass = ipa.getIpaPassType();
                                                        String ipaIndustry = ipa.getIndustry();
                                                        String empName = ipa.getIpaEmployerName();
                                                        String ipaAgent = ipa.getIpaAgentName();
                                                        java.util.Date ipaAppDate = ipa.getIpaApplicationDate();
                                                        double salary = ipa.getBasicSalary();

                                                        if (i < ipaIdList.size() - 1) {
                                                %>
                                                <tr class="other_ipa moreObjs">
                                                    <td><%=ipaPass%></td>
                                                    <td><%=(ipaAppDate == null) ? "-" : sdf.format(ipaAppDate)%></td>
                                                    <td><%=empName%></td>
                                                    <td><%=salary%></td>
                                                    <td>
                                                        <a style="color: black" data-value='ipa' data-ipa='<%=ipa.getId()%>' 
                                                           data-class="job"   href="" data-toggle="modal" data-target="#ipa_pop_up" 
                                                           data-action="viewedit" class="view_btn pop_up_open">
                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                        </a></td>
                                                </tr>
                                                <%
                                                } else {
                                                %>
                                                <tr>
                                                    <td><%=ipaPass%></td>
                                                    <td><%=(ipaAppDate == null) ? "-" : sdf.format(ipaAppDate)%></td>
                                                    <td><%=empName%></td>
                                                    <td><%=salary%></td>
                                                    <td>
                                                        <a style="color: black" data-value='ipa' data-ipa='<%=ipa.getId()%>' 
                                                           data-class="job"   href="" data-toggle="modal" data-target="#ipa_pop_up" 
                                                           data-action="viewedit" class="view_btn pop_up_open">
                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>
                                            <%
                                                if (ipaIdList.size() > 1) {
                                            %>

                                            <a href="#" class="text-center col-sm-12 seemore_btn other_ipa_seemore" onclick="seemore('.other_ipa')">See more</a>
                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_ipa_seemore" onclick="seemore('.other_ipa')">View Less</a>
                                            <%                                                            }
                                                }
                                            %>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <!----Problem Complement Tab--->             
                            <div class="tab-pane " id="problem_complement" >
                                <br/>

                                <div class="row">
                                    <form method="POST" action='changeToSelected'>
                                        <div class="form-group">
                                            <label for="probSelected" class="col-md-1 control-label">Select Job:</label>
                                            <div class="col-md-1">
                                                <input type="hidden" name="workerFin" value="<%=workerFin%>"/>
                                                <input type="hidden" name="jobKey" value="<%=latestJob.getJobKey()%>"/>
                                                <input type="hidden" name="selectedType" value="problem"/>
                                                <select class="form-control text-capitalize" id="problemSelected" name="selectedProblem" required>
                                                    <%
                                                        for (int i = 0; i < problemIds.size(); i++) {
                                                            int Id = problemIds.get(i);
                                                            Problem tempProb = ProblemDAO.retrieveProblemByProblemId(Id);
                                                            String problemType = tempProb.getProblem();
                                                            java.util.Date tempDate = tempProb.getProblemRegisteredDate();

                                                            if (tempProb == latestProblem) {
                                                    %>
                                                    <option value="<%=Id%>" selected><%=problemType%></option>
                                                    <%
                                                    } else {
                                                    %>
                                                    <option value="<%=Id%>"><%=problemType%></option>
                                                    <%
                                                            }
                                                        }
                                                    %>

                                                </select>
                                            </div>

                                            <button type='submit' onclick="" class="btn btn-default  col-md-1">Submit</button>
                                            <button type='button' data-title="Add New Problem" data-action="add" data-value="problem" class="btn btn-default profile_details  pull-right">Add New Problem</button>

                                        </div>
                                    </form>
                                    <!--need to change the vlaue of job id when the user change the dropdown value-->
                                </div>
                                <br/>

                                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="false">
                                    <div class="panel panel-default">

                                        <!--common problem complements-->
                                        <div class="panel panel-primary">
                                            <div class="panel-heading" role="tab" id="headingOne">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#accordion" href="#commonComps" aria-expanded="true" aria-controls="collapseOne">
                                                        Common Problem Complements
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="commonComps" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                                                <div class="panel-body">



                                                    <!--Aggravating Issues-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Aggravating Issue
                                                                <a href="" id="issueAddBtn" data-toggle="modal" data-target="#aggravIssue_pop_up"  data-class="problem"  data-action = "add" data-value='aggravissue' data-aggravissue='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> aggravissueIds = ProblemComplementsDAO.retrieveAggravatingIssueIdsOfProblem(latestProblem);

                                                                if (aggravissueIds != null && !aggravissueIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Aggravating Issues</th>
                                                                    <th>Monetary Loss/Value</th>
                                                                    <th>Remarks</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = aggravissueIds.size() - 1; i >= 0; i--) {
                                                                        ProblemAggravatingIssue aggravIs = ProblemComplementsDAO.retrieveProblemAggravatingIssueById(aggravissueIds.get(i));

                                                                        String issue = aggravIs.getAggravatingIssue();

                                                                        if (issue.equals("Other") || issue.equals("other")) {
                                                                            issue = aggravIs.getAggravatingIssueMore();
                                                                        }

                                                                        String remark = aggravIs.getAggravatingRemark();
                                                                        String loss = aggravIs.getAggravatingLoss();
                                                                        if (i < aggravissueIds.size() - 1) {
                                                                %>
                                                                <tr class="other_aggravissue moreObjs">
                                                                    <td><%=issue%></td>
                                                                    <td><%=loss%></td>
                                                                    <td><%=remark%></td>
                                                                    <td>
                                                                        <a style="color: black" data-value='aggravissue' data-class="problem"   
                                                                           data-aggravissue='<%=aggravIs.getId()%>' href="" 
                                                                           data-toggle="modal" data-action="viewedit" data-target="#aggravIssue_pop_up"  
                                                                           class="edit_btn pop_up_open">
                                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                                        </a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=issue%></td>
                                                                    <td><%=loss%></td>
                                                                    <td><%=remark%></td>
                                                                    <td><a style="color: black" data-value='aggravissue' data-class="problem"   data-aggravissue='<%=aggravIs.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#aggravIssue_pop_up"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (aggravissueIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_aggravissue_seemore" onclick="seemore('.other_aggravissue')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_aggravissue_seemore" onclick="seemore('.other_aggravissue')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>


                                                    <!--Lead case worker-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Lead Case Worker
                                                                <a href="" id="lcwAddBtn" data-toggle="modal" data-action = "add"  data-class="problem"  data-target="#leadcaseworker_pop_up" data-value='leadcaseworker' data-leadcaseworker='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> lcwIds = ProblemComplementsDAO.retrieveLeadCaseWorkerIdsOfProblem(latestProblem);

                                                                if (lcwIds != null && !lcwIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Name</th>
                                                                    <th>Start Date</th>
                                                                    <th>End Date</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = lcwIds.size() - 1; i >= 0; i--) {
                                                                        int icwid = lcwIds.get(i);
                                                                        ProblemLeadCaseWorker lcw = ProblemComplementsDAO.retrieveProblemLeadCaseWorkerById(icwid);

                                                                        String name = lcw.getLeadCaseWorker();
                                                                        java.util.Date start = lcw.getLeadStart();
                                                                        java.util.Date end = lcw.getLeadEnd();
                                                                        if (i < lcwIds.size() - 1) {
                                                                %>
                                                                <tr class="other_leadcaseworker moreObjs">
                                                                    <td><%=name%></td>
                                                                    <%
                                                                        if (start == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String startStr = sdf.format(start);
                                                                    %>
                                                                    <td><%=startStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (end == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String endStr = sdf.format(end);

                                                                    %>
                                                                    <td><%=endStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><a style="color: black" data-target="#leadcaseworker_pop_up"  data-class="problem"  data-value='leadcaseworker' data-leadcaseworker='<%=icwid%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=name%></td>
                                                                    <%
                                                                        if (start == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String startStr = sdf.format(start);
                                                                    %>
                                                                    <td><%=startStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (end == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String endStr = sdf.format(end);

                                                                    %>
                                                                    <td><%=endStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><a style="color: black" data-target="#leadcaseworker_pop_up"  data-class="problem"  data-value='leadcaseworker' data-leadcaseworker='<%=icwid%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (lcwIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_leadcaseworker_seemore" onclick="seemore('.other_leadcaseworker')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_leadcaseworker_seemore" onclick="seemore('.other_leadcaseworker')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!--Auxiliary Worker-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Auxiliary Case Worker
                                                                <a href="" id="auxcaseAddBtn" data-toggle="modal"  data-class="problem"  
                                                                   data-target="#auxcaseworker_pop_up" data-action = "add" data-value='auxcaseworker' 
                                                                   data-auxcaseworker='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> auxCWIds = ProblemComplementsDAO.retrieveProblemAuxiliaryCaseWorkerIdsOfProblem(latestProblem);

                                                                if (auxCWIds != null && !auxCWIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">

                                                                <tr>
                                                                    <th>Name</th>
                                                                    <th>Start Date</th>
                                                                    <th>End Date</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = auxCWIds.size() - 1; i >= 0; i--) {
                                                                        int auxid = auxCWIds.get(i);
                                                                        ProblemAuxiliaryCaseWorker auxCW = ProblemComplementsDAO.retrieveProblemAuxiliaryCaseWorkerById(auxid);

                                                                        String name = auxCW.getAuxName();
                                                                        java.util.Date start = auxCW.getAuxStart();
                                                                        java.util.Date end = auxCW.getAuxEnd();
                                                                        if (i < auxCWIds.size() - 1) {

                                                                %>
                                                                <tr class="other_auxCaseworker moreObjs">
                                                                    <td><%=name%></td>
                                                                    <%
                                                                        if (start == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String startStr = sdf.format(start);
                                                                    %>
                                                                    <td><%=startStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (end == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String endStr = sdf.format(end);

                                                                    %>
                                                                    <td><%=endStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><a style="color: black" data-value='auxcaseworker' data-class="problem"   data-auxcaseworker='<%=auxid%>' href="" data-toggle="modal" data-action="viewedit" data-target="#auxcaseworker_pop_up"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=name%></td>
                                                                    <%
                                                                        if (start == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String startStr = sdf.format(start);
                                                                    %>
                                                                    <td><%=startStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <%
                                                                        if (end == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String endStr = sdf.format(end);

                                                                    %>
                                                                    <td><%=endStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><a style="color: black" data-value='auxcaseworker' data-class="problem"   data-auxcaseworker='<%=auxid%>' href="" data-toggle="modal" data-action="viewedit" data-target="#auxcaseworker_pop_up"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (auxCWIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_auxCaseworker_seemore" onclick="seemore('.other_auxCaseworker')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_auxCaseworker_seemore" onclick="seemore('.other_auxCaseworker')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!--Case Discussion-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Case Discussion
                                                                <a href="" id="casediscussionAddBtn" data-toggle="modal" data-class="problem"   data-target="#casediscussion_pop_up" data-action = "add" data-value='casediscussion' data-casediscussion='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> caseDiscussIds = ProblemComplementsDAO.retrieveCaseDiscussionIdsOfProblem(latestProblem);

                                                                if (caseDiscussIds != null && !caseDiscussIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Discussion Date & Time</th>
                                                                    <th>Mode/Location of Discussion</th>
                                                                    <th>Consultant</th>
                                                                    <th>Topic of Discussion</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = caseDiscussIds.size() - 1; i >= 0; i--) {
                                                                        int id = caseDiscussIds.get(i);
                                                                        ProblemCaseDiscussion caseDiscussion = ProblemComplementsDAO.retrieveProblemCaseDiscussionById(id);

                                                                        java.util.Date discussionDate = caseDiscussion.getCaseDiscussionDate();
                                                                        String mode = caseDiscussion.getCaseDiscussionWhere();
                                                                        String consultant = caseDiscussion.getCaseDiscussionTWC2Person1();
                                                                        String topic = caseDiscussion.getCaseDiscussionTopic();
                                                                        String location = caseDiscussion.getCaseDiscussionWhere();
                                                                        if (location.equals("other") || location.equals("Other") || location == null) {
                                                                            location = caseDiscussion.getCaseDiscussionWhereMore();
                                                                        }

                                                                        if (i < caseDiscussIds.size() - 1) {
                                                                %>
                                                                <tr class="other_casediscuss moreObjs">

                                                                    <%
                                                                        if (discussionDate == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String discussionDateStr = sdf.format(discussionDate);
                                                                    %>
                                                                    <td><%=discussionDateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=mode%></td>
                                                                    <td><%=consultant%></td>
                                                                    <td><%=topic%></td>
                                                                    <td><a style="color: black" data-value='casediscussion' data-class="problem"   data-casediscussion='<%=id%>' href="" data-toggle="modal" data-action="viewedit" data-target="#casediscussion_pop_up"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {

                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (discussionDate == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String discussionDateStr = sdf.format(discussionDate);
                                                                    %>
                                                                    <td><%=discussionDateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=mode%></td>
                                                                    <td><%=consultant%></td>
                                                                    <td><%=topic%></td>
                                                                    <td><a style="color: black" data-value='casediscussion' data-class="problem"   data-casediscussion='<%=id%>' href="" data-toggle="modal" data-action="viewedit" data-target="#casediscussion_pop_up"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (caseDiscussIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_casediscuss_seemore" onclick="seemore('.other_casediscuss')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_casediscuss_seemore" onclick="seemore('.other_casediscuss')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!--Lawyer-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Lawyer
                                                                <a href="" id="lawyerAddBtn" data-toggle="modal" data-target="#lawyer_pop_up" data-class="problem"   data-action = "add" data-value='lawyer' data-lawyer='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> lawyerIds = ProblemComplementsDAO.retrieveProblemLawyerIdsOfProblem(latestProblem);

                                                                if (lawyerIds != null && !lawyerIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Date of Update</th>
                                                                    <th>Lawyer Firm</th>
                                                                    <th>Lawyer Name</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = lawyerIds.size() - 1; i >= 0; i--) {
                                                                        int id = lawyerIds.get(i);

                                                                        ProblemLawyer lawyer = ProblemComplementsDAO.retrieveProblemLawyerById(id);

                                                                        String lawFirm = lawyer.getLawyerFirm();
                                                                        java.util.Date updateDate = lawyer.getLawyerUpdate();
                                                                        String lawyerName = lawyer.getLawyerName();
                                                                        if (i < lawyerIds.size() - 1) {

                                                                %>
                                                                <tr class="other_lawyer moreObjs">

                                                                    <%
                                                                        if (updateDate == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String updateDateStr = sdf.format(updateDate);
                                                                    %>
                                                                    <td><%=updateDateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=lawFirm%></td>
                                                                    <td><%=lawyerName%></td>
                                                                    <td><a style="color: black" data-value='lawyer' data-lawyer='<%=id%>' data-class="problem"   href="" data-toggle="modal" data-action="viewedit" data-target="#lawyer_pop_up"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (updateDate == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String updateDateStr = sdf.format(updateDate);
                                                                    %>
                                                                    <td><%=updateDateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=lawFirm%></td>
                                                                    <td><%=lawyerName%></td>
                                                                    <td><a style="color: black" data-value='lawyer' data-lawyer='<%=id%>' data-class="problem"   href="" data-toggle="modal" data-action="viewedit" data-target="#lawyer_pop_up"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>

                                                            <%
                                                                if (lawyerIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_lawyer_seemore" onclick="seemore('.other_lawyer')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_lawyer_seemore" onclick="seemore('.other_lawyer')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!--salary complements-->
                                        <div class="panel panel-primary">
                                            <div class="panel-heading" role="tab" id="headingTwo">
                                                <h4 class="panel-title">
                                                    <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#salaryComps"  data-class="problem"  aria-expanded="true" aria-controls="collapseTwo">
                                                        Salary Complements
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="salaryComps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                                                <div class="panel-body">

                                                    <!--salary related history-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Salary Related History
                                                                <a href="" id="salaryHistoryAddBtn" data-toggle="modal"  data-action = "add" data-class="problem"   data-target="#salaryhistory_pop_up" data-value='salaryhistory' data-salaryhistory='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> salaryHistoryIds = ProblemComplementsDAO.retrieveProblemSalaryRelatedHistoryIdsOfProblem(latestProblem);

                                                                if (salaryHistoryIds != null && !salaryHistoryIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Salary & Related History</th>
                                                                    <th>Payment Mode</th>
                                                                    <th>Total Claim</th>
                                                                    <th>12 Months Claim</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = salaryHistoryIds.size() - 1; i >= 0; i--) {
                                                                        int historyId = salaryHistoryIds.get(i);
                                                                        ProblemSalaryRelatedHistory salaryHistory = ProblemComplementsDAO.retrieveProblemSalaryRelatedHistoryById(historyId);

                                                                        String history = salaryHistory.getSalHistBasic();
                                                                        String mode = salaryHistory.getSalMode();
                                                                        double tClaim = salaryHistory.getSalLossTotal();
                                                                        double claim = salaryHistory.getSalLoss1Year();
                                                                        if (i < salaryHistoryIds.size() - 1) {
                                                                %>
                                                                <tr class="other_salaryhistory moreObjs">
                                                                    <td><%=history%></td>
                                                                    <td><%=mode%></td>
                                                                    <td><%=tClaim%></td>
                                                                    <td><%=claim%></td>
                                                                    <td>
                                                                        <a style="color: black" data-target="#salaryhistory_pop_up"  data-class="problem"  data-value='salaryhistory' 
                                                                           data-salaryhistory='<%=historyId%>' href="" data-toggle="modal" data-action="viewedit"  
                                                                           class="edit_btn pop_up_open">
                                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=history%></td>
                                                                    <td><%=mode%></td>
                                                                    <td><%=tClaim%></td>
                                                                    <td><%=claim%></td>
                                                                    <td>
                                                                        <a style="color: black" data-target="#salaryhistory_pop_up"  data-class="problem"  
                                                                           data-value='salaryhistory' data-salaryhistory='<%=historyId%>' href="" 
                                                                           data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open">
                                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (salaryHistoryIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_salaryhistory_seemore" onclick="seemore('.other_salaryhistory')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_salaryhistory_seemore" onclick="seemore('.other_salaryhistory')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!--Salary Claim Lodged-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Salary Claim Lodged
                                                                <a href="" id="salaryClaimAddBtn" data-toggle="modal" data-action = "add" data-class="problem"   data-target="#salarycalim_pop_up" data-value='salarycalim' data-salarycalim='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                //ArrayList<Integer> salaryClaimIds = ProblemComplementsDAO.retrieveProblemSalaryRelatedHistoryIdsOfProblem(latestProblem);
                                                                ArrayList<Integer> salaryClaimIds = ProblemComplementsDAO.retrieveSalaryClaimIdsOfProblem(latestProblem);
                                                                if (salaryClaimIds != null && !salaryClaimIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Salary Claim Date</th>
                                                                    <th>Salary Claim Loss</th>
                                                                    <th>Salary Claim Basic</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = salaryClaimIds.size() - 1; i >= 0; i--) {
                                                                        int salaryClaimId = salaryClaimIds.get(i);

                                                                        ProblemSalaryClaim salaryClaim = ProblemComplementsDAO.retrieveProblemSalaryClaimById(salaryClaimId);
                                                                        java.util.Date date = salaryClaim.getSalaryClaimDate();
                                                                        double loss = salaryClaim.getSalaryClaimLoss();
                                                                        String basic = salaryClaim.getSalaryClaimBasis();
                                                                        if (i < salaryClaimIds.size() - 1) {
                                                                %>
                                                                <tr class="other_salaryClaim moreObjs">
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=loss%></td>
                                                                    <td><%=basic%></td>
                                                                    <td><a style="color: black" data-target="#salarycalim_pop_up" data-class="problem"   data-value='salarycalim' data-salarycalim='<%=salaryClaimId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=loss%></td>
                                                                    <td><%=basic%></td>
                                                                    <td><a style="color: black" data-target="#salarycalim_pop_up" data-class="problem"   data-value='salarycalim' data-salarycalim='<%=salaryClaimId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (salaryClaimIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_salaryClaim_seemore" onclick="seemore('.other_salaryClaim')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_salaryClaim_seemore" onclick="seemore('.other_salaryClaim')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <!--Medical Complements-->
                                        <div class="panel-primary panel">
                                            <div class="panel-heading" role="tab" id="headingThree">
                                                <h4 class="panel-title">
                                                    <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#medicalComps" data-class="problem"  aria-expanded="true" aria-controls="collapseThree">
                                                        Medical Complements
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="medicalComps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                                <div class="panel-body">

                                                    <!--Injury History-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Injury History
                                                                <a href="" id="injHistoryAddBtn" data-toggle="modal" data-action = "add"  
                                                                   data-class="problem"   data-target="#injurycase_pop_up" 
                                                                   data-value='injurycase' data-injurycase='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> injuryIds = ProblemComplementsDAO.retrieveProblemInjuryIdsOfProblem(latestProblem);

                                                                if (injuryIds != null && !injuryIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Injury Date</th>
                                                                    <th>Location</th>
                                                                    <th>Injured Body Part</th>
                                                                    <th>Initial Treatment</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = injuryIds.size() - 1; i >= 0; i--) {
                                                                        int injuryId = injuryIds.get(i);

                                                                        ProblemInjury injury = ProblemComplementsDAO.retrieveProblemInjuryById(injuryId);
                                                                        java.util.Date date = injury.getInjuryDate();
                                                                        String location = injury.getInjuryLocation();
                                                                        String bodyPart = injury.getInjuryBodyPart();
                                                                        String treatment = injury.getInitialTreatment();

                                                                        if (treatment == null || treatment.equals("other") || treatment.equals("Other")) {
                                                                            treatment = injury.getInitialTreatmentMore();
                                                                        }
                                                                        if (i < injuryIds.size() - 1) {

                                                                %>
                                                                <tr class="other_injury moreObjs">
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=location%></td>
                                                                    <td><%=bodyPart%></td>
                                                                    <td><%=treatment%></td>
                                                                    <td><a style="color: black" data-target="#injurycase_pop_up" data-class="problem"   data-value='injurycase' data-injurycase='<%=injuryId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=location%></td>
                                                                    <td><%=bodyPart%></td>
                                                                    <td><%=treatment%></td>
                                                                    <td><a style="color: black" data-target="#injurycase_pop_up" data-class="problem"   data-value='injurycase' data-injurycase='<%=injuryId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (injuryIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_injury_seemore" onclick="seemore('.other_injury')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_injury_seemore" onclick="seemore('.other_injury')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!--Illness History-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Illness History
                                                                <a href="" id="ttrAddBtn" data-toggle="modal" data-action = "add"  data-class="problem"   
                                                                   data-target="#illnesscase_pop_up" data-value='illnesscase' data-illnesscase='' 
                                                                   class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> illnessIds = ProblemComplementsDAO.retrieveIllnessIdsOfProblem(latestProblem);

                                                                if (illnessIds != null && !illnessIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Start Date</th>
                                                                    <th>Diagnosed Date</th>
                                                                    <th>Diagnosed by</th>
                                                                    <th>Nature of Illness</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = illnessIds.size() - 1; i >= 0; i--) {
                                                                        int illnessId = illnessIds.get(i);

                                                                        ProblemIllness illness = ProblemComplementsDAO.retrieveProblemIllnesseById(illnessId);
                                                                        String date = illness.getIllnessStart();
                                                                        String dDate = illness.getIllnessDiagWhen();
                                                                        String dWho = illness.getIllnessDiagWho();
                                                                        String nature = illness.getIllnessNature();

                                                                        if (i < illnessIds.size() - 1) {
                                                                %>
                                                                <tr class="other_illness moreObjs">
                                                                    <td><%=date%></td>
                                                                    <td><%=dDate%></td>
                                                                    <td><%=dWho%></td>
                                                                    <td><%=nature%></td>
                                                                    <td><a style="color: black" data-target="#illnesscase_pop_up" data-class="problem"   data-value='illnesscase' data-illnesscase='<%=illnessId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=date%></td>
                                                                    <td><%=dDate%></td>
                                                                    <td><%=dWho%></td>
                                                                    <td><%=nature%></td>
                                                                    <td><a style="color: black" data-target="#illnesscase_pop_up" data-class="problem"   data-value='illnesscase' data-illnesscase='<%=illnessId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (illnessIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_illness_seemore" onclick="seemore('.other_illness')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_illness_seemore" onclick="seemore('.other_illness')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>


                                                    <!--WICA Claim Lodged-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">WICA Claim Lodged
                                                                <a href="" id="wicaclaimAddBtn" data-toggle="modal" data-action = "add"  
                                                                   data-class="problem"   data-target="#wicaclaim_pop_up" data-value='wicaclaim' 
                                                                   data-wicaclaim='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> wicaclaimIds = ProblemComplementsDAO.retrieveWicaClaimIdsOfProblem(latestProblem);

                                                                if (wicaclaimIds != null && !wicaclaimIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Claim Date</th>
                                                                    <th>Claim Reference No</th>
                                                                    <th>Claim Insurer</th>
                                                                    <th>Policy Number</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = wicaclaimIds.size() - 1; i >= 0; i--) {
                                                                        int wicaclaimId = wicaclaimIds.get(i);

                                                                        ProblemWicaClaim wicaClaim = ProblemComplementsDAO.retrieveProblemWicaClaimById(wicaclaimId);

                                                                        java.util.Date date = wicaClaim.getWicaClaimDate();
                                                                        String refNo = wicaClaim.getWicaReferenceNumber();
                                                                        String insurer = wicaClaim.getWicaInsurer();
                                                                        String policyNo = wicaClaim.getWicaPolicyNumber();

                                                                        if (i < wicaclaimIds.size() - 1) {
                                                                %>
                                                                <tr class="other_wicaClaim moreObjs">
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=refNo%></td>
                                                                    <td><%=insurer%></td>
                                                                    <td><%=policyNo%></td>
                                                                    <td><a style="color: black" data-target="#wicaclaim_pop_up" data-value='wicaclaim' data-class="problem"   data-wicaclaim='<%=wicaclaimId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=refNo%></td>
                                                                    <td><%=insurer%></td>
                                                                    <td><%=policyNo%></td>
                                                                    <td><a style="color: black" data-target="#wicaclaim_pop_up" data-value='wicaclaim' data-class="problem"   data-wicaclaim='<%=wicaclaimId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (wicaclaimIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_wicaClaim_seemore" onclick="seemore('.other_wicaClaim')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_wicaClaim_seemore" onclick="seemore('.other_wicaClaim')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>



                                                    <!--Non WICA Claim Lodged-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Non-WICA Claim Lodged
                                                                <a href="" id="nonwicaclaimAddBtn" data-toggle="modal" data-action = "add"  
                                                                   data-class="problem"   data-target="#nonwicaclaim_pop_up" data-value='nonwicaclaim' 
                                                                   data-nonwicaclaim='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> nonwicaClaimIds = ProblemComplementsDAO.retrieveNonWicaClaimIdsOfProblem(latestProblem);

                                                                if (nonwicaClaimIds != null && !nonwicaClaimIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Claim Date</th>
                                                                    <th>Claim Loss</th>
                                                                    <th>Claim Insurer</th>
                                                                    <th>Policy Number</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = nonwicaClaimIds.size() - 1; i >= 0; i--) {
                                                                        int nonwicaClaimId = nonwicaClaimIds.get(i);

                                                                        ProblemNonWicaClaim nonwicaClaim = ProblemComplementsDAO.retrieveProblemNonWicaClaimById(nonwicaClaimId);

                                                                        java.util.Date date = nonwicaClaim.getMedicalClaimDate();
                                                                        double loss = nonwicaClaim.getMedicalClaimLoss();
                                                                        String insurer = nonwicaClaim.getMedicalClaimInsurer();
                                                                        String pNo = nonwicaClaim.getMedicalClaimPolicyNumber();

                                                                        if (i < nonwicaClaimIds.size() - 1) {
                                                                %>
                                                                <tr class="other_nonWica moreObjs">
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=loss%></td>
                                                                    <td><%=insurer%></td>
                                                                    <td><%=pNo%></td>
                                                                    <td><a style="color: black"  data-target="#nonwicaclaim_pop_up"  data-class="problem"  data-value='nonwicaclaim' data-nonwicaclaim='<%=nonwicaClaimId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=loss%></td>
                                                                    <td><%=insurer%></td>
                                                                    <td><%=pNo%></td>
                                                                    <td><a style="color: black"  data-target="#nonwicaclaim_pop_up"  data-class="problem"  data-value='nonwicaclaim' data-nonwicaclaim='<%=nonwicaClaimId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (nonwicaClaimIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_nonWica_seemore" onclick="seemore('.other_nonWica')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_nonWica_seemore" onclick="seemore('.other_nonWica')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>


                                                    <!-- WICA Status -->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">WICA Monthly Status
                                                                <a href="" id="wicaAddBtn" data-toggle="modal" data-action = "add"  data-class="problem"   data-target="#wica_pop_up" data-value='wica' data-wica='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> wicaIds = ProblemComplementsDAO.retrieveWicaIdsOfProblem(latestProblem);

                                                                if (wicaIds != null && !wicaIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Wica Status</th>
                                                                    <th>Wica Update</th>
                                                                    <th>Wica Points</th>
                                                                    <th>Wica Compensation</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = wicaIds.size() - 1; i >= 0; i--) {
                                                                        int wicaId = wicaIds.get(i);

                                                                        ProblemWica wica = ProblemComplementsDAO.retrieveProblemWicaById(wicaId);

                                                                        String status = wica.getWicaMonthlyStatus();
                                                                        java.util.Date date = wica.getWicaMonthlyUpdate();
                                                                        double point = wica.getWicaMonthlyPoints();
                                                                        double comp = wica.getWicaMonthlyDollars();

                                                                        if (i < wicaIds.size() - 1) {
                                                                %>
                                                                <tr class="other_wicaStatus moreObjs">
                                                                    <td><%=status%></td>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>

                                                                    <td><%=point%></td>
                                                                    <td><%=comp%></td>
                                                                    <td><a style="color: black"  data-target="#wica_pop_up" data-value='wica' data-class="problem"   data-wica='<%=wicaId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <td><%=status%></td>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>

                                                                    <td><%=point%></td>
                                                                    <td><%=comp%></td>
                                                                    <td><a style="color: black"  data-target="#wica_pop_up" data-value='wica' data-class="problem"   data-wica='<%=wicaId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (wicaIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_wicaStatus_seemore" onclick="seemore('.other_wicaStatus')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_wicaStatus_seemore" onclick="seemore('.other_wicaStatus')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!-- Hospital Treatment  -->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Hospital Providing Treatment
                                                                <a href="" id="hospitalAddBtn" data-toggle="modal" data-action = "add"  data-class="problem"   data-target="#hospital_pop_up" data-value='hospital' data-hospital='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> hospitalIds = ProblemComplementsDAO.retrieveProblemHospitalIdsOfProblem(latestProblem);

                                                                if (hospitalIds != null && !hospitalIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>

                                                                    <th>Updated Date</th>
                                                                    <th>Hospital Name</th>
                                                                    <th>Doctor</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = hospitalIds.size() - 1; i >= 0; i--) {
                                                                        int hospitalId = hospitalIds.get(i);

                                                                        ProblemHospital hospital = ProblemComplementsDAO.retrieveProblemHospitalById(hospitalId);
                                                                        String name = hospital.getHospitalName();
                                                                        if (name == null || name.equals("other") || name.equals("Other")) {
                                                                            name = hospital.getHospitalNameMore();
                                                                        }

                                                                        String doctor = hospital.getHospitalDoctor();
                                                                        java.util.Date date = hospital.getHospitalUpdate();

                                                                        if (i < hospitalIds.size() - 1) {
                                                                %>
                                                                <tr class="other_hospital moreObjs">

                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=name%></td>

                                                                    <td><%=doctor%></td>
                                                                    <td><a style="color: black" data-target="#hospital_pop_up"  data-class="problem"  data-value='hospital' data-hospital='<%=hospitalId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>

                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=name%></td>

                                                                    <td><%=doctor%></td>
                                                                    <td><a style="color: black" data-target="#hospital_pop_up"  data-class="problem"  data-value='hospital' data-hospital='<%=hospitalId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (hospitalIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_hospital_seemore" onclick="seemore('.other_hospital')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_hospital_seemore" onclick="seemore('.other_hospital')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>


                                                    <!-- MC/Light Duty Status  -->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">MC/Light Duty Status
                                                                <a href="" id="mcAddBtn" data-toggle="modal" data-action = "add"  data-class="problem"   data-target="#mc_pop_up" data-value='mc' data-mc='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> mcIds = ProblemComplementsDAO.retrieveProblemMCStatusIdsOfProblem(latestProblem);

                                                                if (mcIds != null && !mcIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>

                                                                    <th>Date</th>
                                                                    <th>MC Status</th>
                                                                    <th>Expire Date</th>
                                                                    <th>Cumulative MC Days</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = mcIds.size() - 1; i >= 0; i--) {
                                                                        int mcId = mcIds.get(i);

                                                                        ProblemMCStatus mc = ProblemComplementsDAO.retrieveProblemMCStatusById(mcId);
                                                                        java.util.Date date = mc.getMCUpdate();
                                                                        java.util.Date exDate = mc.getMCExpDate();
                                                                        String status = mc.getMCStatus();
                                                                        if (status == null || status.equals("other") || status.equals("Other")) {
                                                                            status = mc.getMCStatusMore();

                                                                        }

                                                                        int cdays = mc.getMCDaysCumul();
                                                                        if (i < mcIds.size() - 1) {
                                                                %>
                                                                <tr class="other_mc moreObjs">

                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=status%></td>
                                                                    <%
                                                                        if (exDate == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String exDateStr = sdf.format(exDate);
                                                                    %>
                                                                    <td><%=exDateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=cdays%></td>
                                                                    <td><a style="color: black" data-target="#mc_pop_up" data-value='mc' data-class="problem"   data-mc='<%=mcId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>

                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=status%></td>
                                                                    <%
                                                                        if (exDate == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String exDateStr = sdf.format(exDate);
                                                                    %>
                                                                    <td><%=exDateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=cdays%></td>
                                                                    <td><a style="color: black" data-target="#mc_pop_up" data-value='mc' data-class="problem"   data-mc='<%=mcId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (mcIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_mc_seemore" onclick="seemore('.other_mc')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_mc_seemore" onclick="seemore('.other_mc')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>


                                                    <!-- R2R Appointments  -->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">R2R Appointments
                                                                <a href="" id="r2rAddBtn" data-toggle="modal" data-action = "add"  data-class="problem"   data-target="#r2r_pop_up" data-value='r2r' data-r2r='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> r2rIds = ProblemComplementsDAO.retrieveProblemR2RIdsOfProblem(latestProblem);

                                                                if (r2rIds != null && !r2rIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>

                                                                    <th>Date</th>
                                                                    <th>Time</th>
                                                                    <th>Hospital Name</th>
                                                                    <th>R2R First Volunteer</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = r2rIds.size() - 1; i >= 0; i--) {
                                                                        int r2rId = r2rIds.get(i);

                                                                        ProblemR2R r2r = ProblemComplementsDAO.retrieveProblemR2RById(r2rId);

                                                                        java.util.Date date = r2r.getR2RDate();
                                                                        String time = r2r.getR2RTime();
                                                                        String hospital = r2r.getR2RHosp();
                                                                        String r2r1 = r2r.getR2R1();

                                                                        if (i < r2rIds.size() - 1) {
                                                                %>
                                                                <tr class="other_r2r moreObjs">

                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=time%></td>
                                                                    <td><%=hospital%></td>
                                                                    <td><%=r2r1%></td>
                                                                    <td><a style="color: black" data-target="#r2r_pop_up" data-value='r2r' data-class="problem"   data-r2r='<%=r2rId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>

                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=time%></td>
                                                                    <td><%=hospital%></td>
                                                                    <td><%=r2r1%></td>
                                                                    <td><a style="color: black" data-target="#r2r_pop_up" data-value='r2r' data-class="problem"   data-r2r='<%=r2rId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (r2rIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_r2r_seemore" onclick="seemore('.other_r2r')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_r2r_seemore" onclick="seemore('.other_r2r')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <!--Other Complements-->
                                        <div class="panel panel-primary">
                                            <div class="panel-heading" role="tab" id="headingThree">
                                                <h4 class="panel-title">
                                                    <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#otherComps" data-class="problem"   aria-expanded="true" aria-controls="collapseThree">
                                                        Other Complements
                                                    </a>
                                                </h4>
                                            </div>
                                            <div id="otherComps" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                                                <div class="panel-body">

                                                    <!--Details & History of Other Problem-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Details & History of Other Problem
                                                                <a href="" id="otherProbAddBtn" data-toggle="modal" data-action = "add" data-class="problem"   data-target="#othercase_pop_up" data-value='othercase' data-othercase='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> otherCaseIds = ProblemComplementsDAO.retrieveOtherProblemIdsOfProblem(latestProblem);

                                                                if (otherCaseIds != null && !otherCaseIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Description</th>
                                                                    <th>Claim Value</th>
                                                                    <th>Remark</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = otherCaseIds.size() - 1; i >= 0; i--) {
                                                                        int otherCaseId = otherCaseIds.get(i);

                                                                        ProblemOtherProblems otherCase = ProblemComplementsDAO.retrieveProblemOtherProblemsById(otherCaseId);

                                                                        String description = otherCase.getOtherProblemDesc();
                                                                        double loss = otherCase.getOtherProblemLoss();
                                                                        String remark = otherCase.getOtherProblemRemark();
                                                                        if (i < otherCaseIds.size() - 1) {
                                                                %>
                                                                <tr class="other_othercase moreObjs">
                                                                    <td><%=description%></td>
                                                                    <td><%=loss%></td>
                                                                    <td><%=remark%></td>
                                                                    <td><a style="color: black" data-target="#othercase_pop_up" data-value='othercase' data-class="problem"   data-othercase='<%=otherCaseId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>

                                                                <tr>
                                                                    <td><%=description%></td>
                                                                    <td><%=loss%></td>
                                                                    <td><%=remark%></td>
                                                                    <td><a style="color: black" data-target="#othercase_pop_up" data-value='othercase' data-class="problem"   data-othercase='<%=otherCaseId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (otherCaseIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_othercase_seemore" onclick="seemore('.other_othercase')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_othercase_seemore" onclick="seemore('.other_othercase')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!--Trafficking Indication  -->
                                                    <!--div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Trafficking Indication
                                                                <a href="" id="traffickingAddBtn" data-toggle="modal" data-action = "add"  data-class="problem"   data-target="#trafficking_pop_up" data-value='trafficking' data-trafficking='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                    <%
                                                        ArrayList<Integer> traffickingIds = ProblemComplementsDAO.retrieveTraffickingIndicatorIdsOfProblem(latestProblem);

                                                        if (traffickingIds != null && !traffickingIds.isEmpty()) {
                                                    %>

                                                    <table class="table table-condensed">
                                                        <tr>
                                                            <th>Assess Date</th>
                                                            <th>Assess Name</th>
                                                            <th>Action</th>
                                                        </tr>

                                                    <%
                                                        for (int i = traffickingIds.size() - 1; i >= 0; i--) {
                                                            int traffickingId = traffickingIds.get(i);

                                                            ProblemTraffickingIndicator traffickingIndi = ProblemComplementsDAO.retrieveProblemTraffickingIndicatorById(traffickingId);
                                                            java.util.Date date = traffickingIndi.getTipiAssessDate();
                                                            String name = traffickingIndi.getTipiAssessName();

                                                            if (i < traffickingIds.size() - 1) {
                                                    %>
                                                    <tr class="other_trafficking moreObjs">
                                                    <%
                                                        if (date == null) {
                                                    %>
                                                    <td>-</td>
                                                    <%                                                                    } else {
                                                        String dateStr = sdf.format(date);
                                                    %>
                                                    <td><%=dateStr%></td>
                                                    <%
                                                        }
                                                    %>
                                                    <td><%=name%></td>
                                                    <td><a style="color: black" data-target="#trafficking_pop_up" data-value='trafficking' data-class="problem"   data-trafficking='<%=traffickingId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>
                                                    <%
                                                        if (date == null) {
                                                    %>
                                                    <td>-</td>
                                                    <%                                                                    } else {
                                                        String dateStr = sdf.format(date);
                                                    %>
                                                    <td><%=dateStr%></td>
                                                    <%
                                                        }
                                                    %>
                                                    <td><%=name%></td>
                                                    <td><a style="color: black" data-target="#trafficking_pop_up" data-value='trafficking' data-class="problem"   data-trafficking='<%=traffickingId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                                    <%
                                                        if (traffickingIds.size() > 1) {
                                                    %>

                                                    <a href="#" class="text-center col-sm-12 seemore_btn other_trafficking_seemore" onclick="seemore('.other_trafficking')">See more</a>
                                                    <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_trafficking_seemore" onclick="seemore('.other_trafficking')">View Less</a>
                                                    <%                                                            }
                                                        }
                                                    %>
                                                </div>
                                            </div-->

                                                    <!--Police Report Lodged-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Police Report Lodged
                                                                <a href="" id="policareportAddBtn" data-toggle="modal" data-action = "add" data-class="problem"   data-target="#policareport_pop_up" data-value='policareport' data-policareport='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> policeReportIds = ProblemComplementsDAO.retrievePoliceReportIdsOfProblem(latestProblem);

                                                                if (policeReportIds != null && !policeReportIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Report Date</th>
                                                                    <th>Report Station</th>
                                                                    <th>Accompanying TWC2 Person</th>
                                                                    <th>Report Reference</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = policeReportIds.size() - 1; i >= 0; i--) {
                                                                        int policeReportId = policeReportIds.get(i);

                                                                        ProblemPoliceReport policeReport = ProblemComplementsDAO.retrieveProblemPoliceReportById(policeReportId);

                                                                        java.util.Date date = policeReport.getPoliceReportDate();
                                                                        String station = policeReport.getPoliceReportStation();
                                                                        String accompany = policeReport.getPoliceReportPerson();
                                                                        String reference = policeReport.getPoliceReportReferenceNumber();
                                                                        if (i < policeReportIds.size() - 1) {
                                                                %>
                                                                <tr class="other_police moreObjs">
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=station%></td>
                                                                    <td><%=accompany%></td>
                                                                    <td><%=reference%></td>
                                                                    <td><a style="color: black" data-target="#policareport_pop_up" data-value='policareport'data-class="problem"   data-policareport='<%=policeReportId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=station%></td>
                                                                    <td><%=accompany%></td>
                                                                    <td><%=reference%></td>
                                                                    <td><a style="color: black" data-target="#policareport_pop_up" data-value='policareport'data-class="problem"   data-policareport='<%=policeReportId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (policeReportIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_police_seemore" onclick="seemore('.other_police')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_police_seemore" onclick="seemore('.other_police')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!--Other Complaint Lodged-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Other Complaint Lodged
                                                                <a href="" id="otherComplaintAddBtn" data-toggle="modal" data-action = "add" data-class="problem"   data-target="#othercomplaint_pop_up" data-value='othercomplaint' data-othercomplaint='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> otherComplaintIds = ProblemComplementsDAO.retrieveOtherComplaintIdsOfProblem(latestProblem);

                                                                if (otherComplaintIds != null && !otherComplaintIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Complaint Date</th>
                                                                    <th>Complaint Agency</th>
                                                                    <th>Lodged By</th>
                                                                    <th>Mode of Lodging</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = otherComplaintIds.size() - 1; i >= 0; i--) {
                                                                        int otherComplaintId = otherComplaintIds.get(i);

                                                                        ProblemOtherComplaint otherComplaint = ProblemComplementsDAO.retrieveProblemOtherComplaintById(otherComplaintId);

                                                                        java.util.Date date = otherComplaint.getOtherComplaintDate();
                                                                        String agency = otherComplaint.getOtherComplaintAgency();
                                                                        String by = otherComplaint.getOtherComplaintWho();
                                                                        String mode = otherComplaint.getOtherComplaintMode();
                                                                        if (mode == null || mode.equals("other") || mode.equals("Other")) {
                                                                            mode = otherComplaint.getOtherComplaintModeMore();
                                                                        }

                                                                        if (i < otherComplaintIds.size() - 1) {
                                                                %>
                                                                <tr class="other_othercomplaints moreObjs">
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=agency%></td>
                                                                    <td><%=by%></td>
                                                                    <td><%=mode%></td>
                                                                    <td><a style="color: black" data-target="#othercomplaint_pop_up" data-class="problem"  data-value='othercomplaint' data-othercomplaint='<%=otherComplaintId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=agency%></td>
                                                                    <td><%=by%></td>
                                                                    <td><%=mode%></td>
                                                                    <td><a style="color: black" data-target="#othercomplaint_pop_up" data-class="problem"  data-value='othercomplaint' data-othercomplaint='<%=otherComplaintId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>

                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (otherComplaintIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_othercomplaints_seemore" onclick="seemore('.other_othercomplaints')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_othercomplaints_seemore" onclick="seemore('.other_othercomplaints')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!--Case Milestone Reached(non-criminal)-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Case Milestone Reached(non-criminal)
                                                                <a href="" id="cmncAddBtn" data-toggle="modal" data-action = "add" data-class="problem"  data-target="#milestonenc_pop_up" data-value='ncmilestone' data-ncmilestone='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> nCaseMSIds = ProblemComplementsDAO.retrieveProblemCaseMilestoneNCIdsOfProblem(latestProblem);


                                                                if (nCaseMSIds != null && !nCaseMSIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Milestone Date</th>
                                                                    <th>Milestone Reached</th>
                                                                    <th>Explanation</th>
                                                                    <th>Remark</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = nCaseMSIds.size() - 1; i >= 0; i--) {
                                                                        int nCaseMSId = nCaseMSIds.get(i);

                                                                        ProblemCaseMilestoneNC casemsNc = ProblemComplementsDAO.retrieveProblemCaseMilestoneNCById(nCaseMSId);
                                                                        java.util.Date date = casemsNc.getMilesNCDate();
                                                                        String reached = casemsNc.getMilesNCReached();
                                                                        String remark = casemsNc.getMilesNCRem();

                                                                        if (reached == null || reached.equals("other") || reached.equals("Other")) {
                                                                            reached = casemsNc.getMilesNCReachedMore();
                                                                        }

                                                                        if (i < nCaseMSIds.size() - 1) {
                                                                %>
                                                                <tr class="other_casemsnc moreObjs">
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=reached%></td>
                                                                    <td><%=remark%></td>
                                                                    <td>
                                                                        <a style="color: black" data-target="#milestonenc_pop_up"  
                                                                           data-class="problem"  data-value='ncmilestone' 
                                                                           data-ncmilestone='<%=nCaseMSId%>' href="" data-toggle="modal" 
                                                                           data-action="viewedit"  class="edit_btn pop_up_open">
                                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=reached%></td>
                                                                    <td><%=remark%></td>
                                                                    <td><a style="color: black" data-target="#milestonenc_pop_up"  data-class="problem"  data-value='ncmilestone' data-ncmilestone='<%=nCaseMSId%>' href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (nCaseMSIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_casemsnc_seemore" onclick="seemore('.other_casemsnc')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_casemsnc_seemore" onclick="seemore('.other_casemsnc')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!--Case Milestone Reached(criminal)-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Case Milestone Reached(Criminal)
                                                                <a href="" id="cmilestoneAddBtn" data-toggle="modal" data-action = "add"  data-target="#milestonecr_pop_up"  data-class="problem"  data-value='cmilestone' data-cmilestone='' class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> caseMSIds = ProblemComplementsDAO.retrieveProblemCaseMilestoneCRIdsOfProblem(latestProblem);


                                                                if (caseMSIds != null && !caseMSIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Milestone Date</th>
                                                                    <th>Milestone Reached</th>
                                                                    <th>Explanation</th>
                                                                    <th>Remark</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = caseMSIds.size() - 1; i >= 0; i--) {
                                                                        int caseMSId = caseMSIds.get(i);

                                                                        ProblemCaseMilestoneCR casemsc = ProblemComplementsDAO.retrieveProblemCaseMilestoneCRById(caseMSId);
                                                                        java.util.Date date = casemsc.getMilesCRDate();
                                                                        String reached = casemsc.getMilesCRReached();
                                                                        String remark = casemsc.getMilesCRRem();

                                                                        if (reached == null || reached.equals("other") || reached.equals("Other")) {
                                                                            reached = casemsc.getMilesCRReachedMore();
                                                                        }

                                                                        if (i < caseMSIds.size() - 1) {
                                                                %>
                                                                <tr class="other_casemscr moreObjs">
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=reached%></td>
                                                                    <td><%=remark%></td>
                                                                    <td>
                                                                        <a style="color: black" data-target="#milestonecr_pop_up" 
                                                                           data-value='cmilestone' data-cmilestone='<%=caseMSId%>' 
                                                                           data-class="problem"  href="" data-toggle="modal" 
                                                                           data-action="viewedit"  class="edit_btn pop_up_open">
                                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=reached%></td>
                                                                    <td><%=remark%></td>
                                                                    <td>
                                                                        <a style="color: black" data-target="#milestonecr_pop_up" 
                                                                           data-value='cmilestone' data-cmilestone='<%=caseMSId%>' 
                                                                           data-class="problem"  href="" data-toggle="modal" 
                                                                           data-action="viewedit"  class="edit_btn pop_up_open">
                                                                            <span class="glyphicon glyphicon-eye-open"></span>
                                                                        </a>
                                                                    </td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>

                                                            <%
                                                                if (caseMSIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_casemscr_seemore" onclick="seemore('.other_casemscr')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_casemscr_seemore" onclick="seemore('.other_casemscr')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>

                                                    <!--Transfer, TJS & Repatriation-->
                                                    <div class="panel panel-default">

                                                        <div class="panel-heading">
                                                            <h4 class="panel-title">Transfer, TJS & Repatriation
                                                                <a href="" id="ttrAddBtn" data-toggle="modal" data-action = "add"  
                                                                   data-target="#ttr_pop_up" data-value='ttr' data-ttr='' 
                                                                   data-class="problem" class="add_btn pop_up_open pull-right">
                                                                    <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                </a>
                                                            </h4>
                                                        </div>
                                                        <div class="panel-body text-capitalize">
                                                            <%
                                                                ArrayList<Integer> ttrIds = ProblemComplementsDAO.retrieveProblemTTRIdsOfProblem(latestProblem);

                                                                if (ttrIds != null && !ttrIds.isEmpty()) {
                                                            %>

                                                            <table class="table table-condensed">
                                                                <tr>
                                                                    <th>Updated Date</th>
                                                                    <th>Status</th>
                                                                    <th>Departure Date</th>
                                                                    <th>Name of TJS</th>
                                                                    <th>Action</th>
                                                                </tr>

                                                                <%
                                                                    for (int i = ttrIds.size() - 1; i >= 0; i--) {
                                                                        int ttrId = ttrIds.get(i);

                                                                        ProblemTTR ttr = ProblemComplementsDAO.retrieveProblemTTRById(ttrId);
                                                                        java.util.Date date = ttr.getTTRUpdate();
                                                                        java.util.Date dDate = ttr.getDepartureDate();
                                                                        String status = ttr.getTTRStatus();
                                                                        String name = ttr.getNewEmployerName();

                                                                        if (i < ttrIds.size() - 1) {
                                                                %>
                                                                <tr class="other_ttr moreObjs">
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=status%></td>
                                                                    <%
                                                                        if (dDate == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dDateStr = sdf.format(dDate);
                                                                    %>
                                                                    <td><%=dDateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=name%></td>
                                                                    <td><a style="color: black" data-target="#ttr_pop_up" data-value='ttr' data-ttr='<%=ttrId%>' href="" data-toggle="modal" data-class="problem" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                } else {
                                                                %>
                                                                <tr>
                                                                    <%
                                                                        if (date == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dateStr = sdf.format(date);
                                                                    %>
                                                                    <td><%=dateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=status%></td>
                                                                    <%
                                                                        if (dDate == null) {
                                                                    %>
                                                                    <td>-</td>
                                                                    <%                                                                    } else {
                                                                        String dDateStr = sdf.format(dDate);
                                                                    %>
                                                                    <td><%=dDateStr%></td>
                                                                    <%
                                                                        }
                                                                    %>
                                                                    <td><%=name%></td>
                                                                    <td><a style="color: black" data-target="#ttr_pop_up" data-value='ttr' data-ttr='<%=ttrId%>' href="" data-toggle="modal" data-class="problem" data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                </tr>
                                                                <%
                                                                        }
                                                                    }
                                                                %>
                                                            </table>
                                                            <%
                                                                if (ttrIds.size() > 1) {
                                                            %>

                                                            <a href="#" class="text-center col-sm-12 seemore_btn other_ttr_seemore" onclick="seemore('.other_ttr')">See more</a>
                                                            <a href="#" style="display:none" class="text-center col-sm-12 seemore_btn other_ttr_seemore" onclick="seemore('.other_ttr')">View Less</a>
                                                            <%                                                            }
                                                                }
                                                            %>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!----Benefits Complement Tab--->                             
                            <div class="tab-pane" id="benefit_complement" >
                                <br/>
                                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                    <!--meal-->
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="foodbeneHead">
                                            <h4 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#accordion" href="#foodBeneCol" aria-expanded="true" aria-controls="foodBeneCol">
                                                    Meal Benefections
                                                    <a href="" id="foodbeneAddBtn" data-toggle="modal" data-class="benefection" 
                                                       data-target="#foodbene_pop_up"   data-title='Add New Meal Benefection'  
                                                       data-action = "add" data-value='foodbene' data-foodbene='' class="add_btn pop_up_open pull-right">

                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                    </a>
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="foodBeneCol" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="foodbeneHead">
                                            <div class="panel-body">
                                                <%
                                                    ArrayList<Integer> mealIds = new ArrayList<Integer>();
                                                    ArrayList<String> list = DropdownDAO.retreiveAllDropdownListOfBenefits("Food");
                                                    ArrayList<Integer> ids = new ArrayList<Integer>();
                                                    for (String string : list) {

                                                        ids = BenefitDAO.retrieveBenefitsIdsOfProblem(latestProblem, string);
                                                        mealIds.addAll(ids);
                                                    }
                                                    if (mealIds != null && !mealIds.isEmpty()) {


                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th>Issued Date</th>
                                                        <th>Given By</th>
                                                        <th>Benefit Type</th>
                                                        <th>Benefit Value(S$)</th>
                                                        <th>Action</th>
                                                    </tr>
                                                    <%
                                                        for (int i = mealIds.size() - 1; i >= 0; i--) {
                                                            int id = mealIds.get(i);
                                                            Benefit benefit = BenefitDAO.retrieveBenefitById(id);
                                                    %>
                                                    <tr class="foodbene">
                                                        <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                        <td><%=benefit.getBenefitGiver()%></td>
                                                        <td><%=benefit.getBenefitType()%></td>
                                                        <td><%=benefit.getBenefitValue()%></td>
                                                        <td>
                                                            <a style="color: black" data-target="#foodbene_pop_up"  data-class="benefection" 
                                                               data-value='foodbene' data-title='View Meal Benefection' 
                                                               data-foodbene='<%=id%>' href="" data-toggle="modal" 
                                                               data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a></td>
                                                    </tr>                                    

                                                    <%
                                                        }
                                                    %>        
                                                </table>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>

                                    <!--transportation-->
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="transpoBeneHead">
                                            <h4 class="panel-title">
                                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#transpoBeneCol" aria-expanded="false" aria-controls="transpoBeneCol">
                                                    Transportation Benefections
                                                    <a href="" id="transpobeneAddBtn" data-toggle="modal" data-target="#transpobene_pop_up"  data-class="benefection" data-title='Add New Transportation Benefection'  data-action = "add" data-value='transpobene' data-transpobene='' class="add_btn pop_up_open pull-right">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                    </a>
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="transpoBeneCol" class="panel-collapse collapse" role="tabpanel" aria-labelledby="transpoBeneHead">
                                            <div class="panel-body">
                                                <%
                                                    ArrayList<Integer> transportIds = new ArrayList<Integer>();
                                                    list = DropdownDAO.retreiveAllDropdownListOfBenefits("Transport");
                                                    ids = new ArrayList<Integer>();
                                                    for (String string : list) {

                                                        ids = BenefitDAO.retrieveBenefitsIdsOfProblem(latestProblem, string);
                                                        transportIds.addAll(ids);
                                                    }
                                                    if (transportIds != null && !transportIds.isEmpty()) {


                                                %>
                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th>Issued Date</th>
                                                        <th>Given By</th>
                                                        <th>Benefit Type</th>
                                                        <th>Benefit Value(S$)</th>
                                                        <th>Action</th>
                                                    </tr>
                                                    <%
                                                        for (int i = transportIds.size() - 1; i >= 0; i--) {
                                                            int id = transportIds.get(i);
                                                            Benefit benefit = BenefitDAO.retrieveBenefitById(id);
                                                    %>
                                                    <tr class="transpoBene">
                                                        <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                        <td><%=benefit.getBenefitGiver()%></td>
                                                        <td><%=benefit.getBenefitType()%></td>
                                                        <td><%=benefit.getBenefitValue()%></td>
                                                        <td>
                                                            <a style="color: black" data-target="#transpobene_pop_up"  data-class="benefection" 
                                                               data-value='transpobene' data-title='View Transportation Benefection' 
                                                               data-transpobene='<%=id%>' href="" data-toggle="modal" 
                                                               data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </table>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>

                                    <!--medical-->
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="mediBeneHead">
                                            <h4 class="panel-title">
                                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#mediBeneCol" aria-expanded="false" aria-controls="mediBeneCol">
                                                    Medical Benefections
                                                    <a href="" id="medibeneAddBtn" data-toggle="modal" data-target="#medibene_pop_up"  data-class="benefection" data-title='Add New Medical Benefection'  data-action = "add" data-value='medibene' data-medibene='' class="add_btn pop_up_open pull-right">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                    </a>
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="mediBeneCol" class="panel-collapse collapse" role="tabpanel" aria-labelledby="mediBeneHead">
                                            <div class="panel-body">
                                                <%
                                                    ArrayList<Integer> medicalIds = new ArrayList<Integer>();
                                                    list = DropdownDAO.retreiveAllDropdownListOfBenefits("Medical & Karunya");
                                                    ids = new ArrayList<Integer>();
                                                    for (String string : list) {

                                                        ids = BenefitDAO.retrieveBenefitsIdsOfProblem(latestProblem, string);
                                                        medicalIds.addAll(ids);
                                                    }
                                                    if (medicalIds != null && !medicalIds.isEmpty()) {


                                                %>
                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th>Issued Date</th>
                                                        <th>Given By</th>
                                                        <th>Benefit Type</th>
                                                        <th>Benefit Value(S$)</th>
                                                        <th>Action</th>
                                                    </tr>
                                                    <%
                                                        for (int i = medicalIds.size() - 1; i >= 0; i--) {
                                                            int id = medicalIds.get(i);
                                                            Benefit benefit = BenefitDAO.retrieveBenefitById(id);
                                                    %>
                                                    <tr class="mediBene">
                                                        <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                        <td><%=benefit.getBenefitGiver()%></td>
                                                        <td><%=benefit.getBenefitType()%></td>
                                                        <td><%=benefit.getBenefitValue()%></td>
                                                        <td>
                                                            <a style="color: black" data-target="#medibene_pop_up"  data-class="benefection" 
                                                               data-value='medibene' data-title='View Medical Benefection' 
                                                               data-medibene='<%=id%>' href="" data-toggle="modal" 
                                                               data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>                                                    
                                                </table>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>

                                    <!--roof-->
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="roofBeneHead">
                                            <h4 class="panel-title">
                                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#roofBeneCol" data-title='Add New Roof Benefections' aria-expanded="false" aria-controls="roofBeneCol">
                                                    Roof Benefections
                                                    <a href="" id="roofbeneAddBtn" data-toggle="modal" data-target="#roofbene_pop_up"  data-class="benefection" data-title='Add New Roof Benefection'  data-action = "add" data-value='roofbene' data-roofbene='' class="add_btn pop_up_open pull-right">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                    </a>
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="roofBeneCol" class="panel-collapse collapse" role="tabpanel" aria-labelledby="roofBeneHead">
                                            <div class="panel-body">
                                                <%
                                                    ArrayList<Integer> roofIds = new ArrayList<Integer>();
                                                    list = DropdownDAO.retreiveAllDropdownListOfBenefits("Roof");
                                                    ids = new ArrayList<Integer>();
                                                    for (String string : list) {

                                                        ids = BenefitDAO.retrieveBenefitsIdsOfProblem(latestProblem, string);
                                                        roofIds.addAll(ids);
                                                    }
                                                    if (roofIds != null && !roofIds.isEmpty()) {


                                                %>
                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th>Issued Date</th>
                                                        <th>Given By</th>
                                                        <th>Benefit Type</th>
                                                        <th>Benefit Value(S$)</th>
                                                        <th>Action</th>
                                                    </tr>
                                                    <%
                                                        for (int i = roofIds.size() - 1; i >= 0; i--) {
                                                            int id = roofIds.get(i);
                                                            Benefit benefit = BenefitDAO.retrieveBenefitById(id);
                                                    %>
                                                    <tr class="roofBene">
                                                        <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                        <td><%=benefit.getBenefitGiver()%></td>
                                                        <td><%=benefit.getBenefitType()%></td>
                                                        <td><%=benefit.getBenefitValue()%></td>
                                                        <td>
                                                            <a style="color: black" data-target="#roofbene_pop_up"  data-class="benefection" 
                                                               data-value='roofbene' data-title='View Roof Benefection' data-roofbene='<%=id%>' 
                                                               href="" data-toggle="modal" data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>          
                                                </table>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>

                                    <!--other-->
                                    <div class="panel panel-default">
                                        <div class="panel-heading" role="tab" id="otherBeneHead">
                                            <h4 class="panel-title">
                                                <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#otherBeneCol" 
                                                   aria-expanded="false" aria-controls="otherBeneCol">
                                                    Other Benefections
                                                    <a href="" id="otherbeneAddBtn" data-toggle="modal" data-target="#otherbene_pop_up"  
                                                       data-class="benefection" data-title='Add New Benefection (Others)'  data-action = "add" 
                                                       data-value='otherbene' data-otherbene='' class="add_btn pop_up_open pull-right">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                    </a>
                                                </a>
                                            </h4>
                                        </div>
                                        <div id="otherBeneCol" class="panel-collapse collapse" role="tabpanel" aria-labelledby="otherBeneHead">
                                            <div class="panel-body">
                                                <%
                                                    ArrayList<Integer> otherIds = new ArrayList<Integer>();
                                                    list = DropdownDAO.retreiveAllDropdownListOfBenefits("Other");
                                                    ids = new ArrayList<Integer>();
                                                    for (String string : list) {

                                                        ids = BenefitDAO.retrieveBenefitsIdsOfProblem(latestProblem, string);
                                                        otherIds.addAll(ids);
                                                    }
                                                    if (otherIds != null && !otherIds.isEmpty()) {


                                                %>
                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th>Issued Date</th>
                                                        <th>Given By</th>
                                                        <th>Benefit Type</th>
                                                        <th>Serial No.</th>
                                                        <th>Purpose/Reason</th>
                                                        <th>Benefit Value(S$)</th>
                                                        <th>Action</th>
                                                    </tr>
                                                    <%
                                                        for (int i = otherIds.size() - 1; i >= 0; i--) {
                                                            int id = otherIds.get(i);
                                                            Benefit benefit = BenefitDAO.retrieveBenefitById(id);
                                                    %>
                                                    <tr class="roofBene">
                                                        <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                        <td><%=benefit.getBenefitGiver()%></td>
                                                        <td><%=benefit.getBenefitType()%></td>
                                                        <td><%=benefit.getBenefitValue()%></td>
                                                        <td>
                                                            <a style="color: black" data-target="#otherbene_pop_up"  data-class="benefection" 
                                                               data-value='otherbene' data-title='View Benefection' data-otherbene='<%=id%>' 
                                                               href="" data-toggle="modal" data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                    <%
                                                        }
                                                    %>
                                                </table>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>

                            <!----Attachments Complement Tab--->                
                            <div class="tab-pane active" id="attachment_complement">
                                <br/><br/>
                                <!-- Attachments Success & Error Display --->
                                <% String successMsg = (String) request.getSession().getAttribute("successAttachMsg");
                                    request.getSession().removeAttribute("successAttachMsg");

                                    String errorMsg = (String) request.getSession().getAttribute("errAttachMsg");
                                    request.getSession().removeAttribute("errAttachMsg");%>
                                <% if (successMsg != null && !successMsg.equals("null")) {%>

                                <div class="alert alert-info" role="alert">
                                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                                    <%=successMsg%>
                                </div>

                                <% }%>
                                <% if (errorMsg != null) {%>

                                <div class="alert alert-danger" role="alert">
                                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                                    <%=errorMsg%>
                                </div>

                                <% }%>
                                <!-- End of Attachments Success & Error Display --->
                                <div class="panel panel-default">
                                    <div class="panel-body">
                                        <form action="fileUpload.do" method="post" enctype="multipart/form-data"> 
                                            <input type="hidden" name="workerFin" value="<%=workerFin%>"/>
                                            <label>File Upload</label><br/>
                                            Select file to upload: <input type="file" name="fileInput"/><br/> 
                                            <button type="submit">Upload File</button><br/><br/>
                                        </form>
                                    </div>
                                </div>
                                <p class="worker_profile_header text-center">Existing Attachments</p>
                                <%
                                    //See if there is any file
                                    ArrayList<Integer> workerAttachList = WorkerComplementsDAO.retrieveAttachmentIdsOfWorker(worker);
                                    if (workerAttachList != null && !workerAttachList.isEmpty()) {
                                %>
                                <!--- only if file exits -->
                                <table class="table table-striped  table-hover" id="worker_attachment">
                                    <thead bgcolor="#3579BC">
                                        <tr>
                                            <th><font color="#FFF">S/N</font></th>
                                            <th><font color="#FFF">Name</font></th>
                                            <th><font color="#FFF">Date & Time uploaded</font></th>
                                            <th><font color="#FFF">Upload By</font></th>
                                            <th><font color="#FFF">Actions</font></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            for (int i = 0; i < workerAttachList.size(); i++) {
                                                WorkerAttachment workerAttachment = WorkerComplementsDAO.retrieveAttachmentDetailsById(workerAttachList.get(i));
                                                String docName = workerAttachment.getDocumentName();
                                                java.util.Date timeStamp = WorkerComplementsDAO.retrieveTimeStamp(workerAttachment);
                                                String submitBy = workerAttachment.getSubmitBy();
                                        %>
                                        <tr bgcolor="">
                                            <td><%=i + 1%></td>
                                            <td><%=docName%></td>
                                            <td><%=sdf.format(timeStamp)%></td>
                                            <td><%=submitBy%></td>
                                            <td align="center">
                                                <a style="color: black" href="">
                                                    <span data-toggle="tooltip" title="Download" class="glyphicon glyphicon-download-alt"></span>
                                                </a>&nbsp; &nbsp; &nbsp; &nbsp;
                                                <a style="color: black" href=""
                                                   data-toggle="modal" data-target="#">
                                                    <span data-toggle="tooltip" title="Rename" class="glyphicon glyphicon-pencil"></span>
                                                </a>&nbsp; &nbsp; &nbsp; &nbsp;
                                                <a style="color: black" href="" class="delete_popup" data-docName='<%=docName%>' 
                                                   data-id='<%=workerAttachment.getId()%>' data-toggle="modal" data-target="#attach_delete_confirm">
                                                    <span data-toggle="tooltip" title="Delete" class="glyphicon glyphicon-trash"></span>
                                                </a>    
                                            </td>
                                        </tr>
                                        <%  } // for loop  %>    
                                    </tbody>
                                </table>
                                <%  } else { //if not exits   %>     
                                <br/>No file has been uploaded to this worker yet!
                                <%  }%>
                            </div>                
                            <!----End of Attachments Complement Tab---> 
                        </div>
                    </div>

                </div> 

                <div id="pop_up_content" ></div> <!-- <-- What is this for? -->

                <!-- Confirm Attachment Delete Modal -->
                <div class="modal fade" id="attach_delete_confirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" 
                     aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">

                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">
                                    <span aria-hidden="true">&times;</span>
                                    <span class="sr-only">Close</span>
                                </button>
                                <h3 class="modal-title" id="attach_pop_up_label" style="color:#2980b9" align="center">
                                    Delete File
                                </h3>
                            </div> <!--modal-header-->
                            <form id="deleteConfirmForm" method="post" action="#" class="form-horizontal">
                                <div class="modal-body">
                                    <input type="hidden" name="attachId" id="InputID" value=""/>
                                    Are you sure you want to delete this file -<label id="InputDocName"></label>?<br/><br/>
                                </div> <!--modal body -->

                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-success">Ok</button>
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                </div>
                            </form>

                        </div> <!--modal content -->
                    </div> <!--modal dialog -->
                </div> 

            </div>

        </div>

        <!--breadcrumbs-->
        <div class="col-md-offset-6" id="breadcrumb_div">
            <ol class="breadcrumb col-md-12">
                <li><a href="home.jsp" id="schwker_bc">Search worker</a></li>
                <li class="active"><%=worker.getFinNumber()%></li>
            </ol>
        </div>

        <div class="col-md-offset-6" id="complement_header_tab">
            <ul class="nav nav-tabs " role="tablist" id="sub_nav_tabs">
                <li id="worker_complement_tab" class="complement_tabs active"><a href="#worker_complement" role="tab" data-toggle="tab">Worker</a></li>
                <li id="job_complement_tab" class="complement_tabs"><a href="#job_complement" role="tab" data-toggle="tab">Job</a></li>
                <li id="problem_complement_tab" class="complement_tabs"><a href="#problem_complement" role="tab" data-toggle="tab">Problem</a></li>
                <li id="benefit_complement_tab" class="complement_tabs"><a href="#benefit_complement" role="tab" data-toggle="tab">Benefit</a></li>
                <li id="attachment_complement_tab" class="complement_tabs"><a href="#attachment_complement" role="tab" data-toggle="tab">Attachment</a></li>
            </ul>
        </div>
        <script>

            $(document).on("click", ".profile_details", function() {
                var div_id = $(this).data('value');
                var div_action_val = $(this).data('action');
                var div_title = $(this).data('title');

                $("#pop_up_content").load('include/createcaseForm.jsp?workerFin=<%=workerFin%>' + "&jobkey=<%=latestJob.getJobKey()%>" + "&probkey=<%=latestProblem.getProbKey()%>" + '&profile=' + div_id + '&action=' + div_action_val).dialog({modal: true, minHeight: $(window).height() - 350,
                    minWidth: $(window).width() - 750, resizable: false, title: div_title, draggable: false, close: function() {
                        $(this).dialog('destroy');
                        $('#pop_up_content').empty();
                    }
                });

            });

            $(document).on("click", ".pop_up_open", function() {
                var div_id = $(this).data('value');
                //alert('id: ' +div_id); //nickname
                var div_value = $(this).data(div_id);
                //alert(div_value); //nothing
                var div_action_val = $(this).data('action');

                var div_class = $(this).data('class');
                var div_title = $(this).data('title');

                var url = '';

                if (div_class === 'worker') {
                    url = 'workerViewEditPopUp.jsp';
                } else if (div_class === 'job') {
                    url = 'jobViewEditPopUp.jsp';
                } else if (div_class === 'problem') {
                    url = 'problemViewEditPopUp.jsp';
                } else if (div_class === 'benefection') {
                    url = 'benefectionPopUp.jsp';
                }
                if (div_action_val === 'viewedit' || div_class === 'benefection') {
                    $("#pop_up_content").load('include/' + url + '?workerFin=<%=workerFin%>&' + div_id + '=' + div_value
                            + "&jobkey=<%=latestJob.getJobKey()%>" + "&probkey=<%=latestProblem.getProbKey()%>" + "&action=" + div_action_val).dialog({modal: true, minHeight: $(window).height() - 350,
                        minWidth: $(window).width() - 750, resizable: false, title: div_title, draggable: false, close: function() {
                            $(this).dialog('destroy');
                            $('#pop_up_content').empty();
                        }
                    });
                } else if (div_action_val === 'add') {
                    $("#pop_up_content").load('include/addPopUp.jsp?workerFin=<%=workerFin%>&complement=' + div_id
                            + "&jobkey=<%=latestJob.getJobKey()%>" + "&probkey=<%=latestProblem.getProbKey()%>" + "&action='add'").dialog({modal: true, minHeight: $(window).height() - 350,
                        minWidth: $(window).width() - 750, title: div_title, resizable: false, draggable: false, close: function() {
                            $(this).dialog('destroy');
                            $('#pop_up_content').empty();
                        }});
                }
            });


            $(document).ready(function() {
                $('.other').hide();
            });

            function seemore(div_name) {
                $(div_name).toggle();
                $(div_name + '_seemore').toggle();
            }
            ;

            function pop_up_edit_box(div_name) {
                var div = '#' + div_name + '_pop_up';
                $(div).show();
            }

            //ready the data in tables - added by soemyatmyat
            $(document).ready(function() {
                $('#worker_attachment').dataTable();
            });

            //passing data for attachment delete confirm - added by soemyatmyat
            $(document).on("click", '.edit_popup', function() {
                var attachId = $(this).data('id');
                var docName = $(this).data('docName');
                $(".modal-body #InputID").val(attachId);
                $(".modal-body #InputDocName").val(docName);
            });

        </script>
    </div>
</body>
</html>
