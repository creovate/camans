<%@page import="camans.utility.BenefitComparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.dao.*"%>
<%@ include file="protect.jsp"%>
<%
    Job latestJob = null;
    Problem latestProblem = null;


    boolean isJob = false;
    boolean isProblem = false;
    boolean isBenefit = false;
    boolean isAttachment = false;

    User userLogin = (User) session.getAttribute("userLogin");
    String workerFin = request.getParameter("worker");
    if (workerFin == null) {
        workerFin = (String) request.getSession().getAttribute("worker");
    }

    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
    //request.getSession().removeAttribute("workerTmp");

    String selectedJob = (String) request.getSession().getAttribute("selectedJob");
    request.getSession().removeAttribute("selectedJob");
    
    if(selectedJob == null || selectedJob.equals("")){
        selectedJob = request.getParameter("selectedJob");
    }
    String selectedProb = (String) request.getSession().getAttribute("selectedProb");
    request.getSession().removeAttribute("selectedProb");
    if(selectedProb == null || selectedProb.equals("")){
        selectedProb = request.getParameter("selectedProb");
    }
    
    ArrayList<Integer> jobIds = JobDAO.retrieveJobIdsOfWorker(worker);
    ArrayList<Integer> problemIds = new ArrayList<Integer>();
    if (selectedJob != null) {
        int selectedJobId = Integer.parseInt(selectedJob);
        latestJob = JobDAO.retrieveJobByJobId(selectedJobId);
        problemIds = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
        latestProblem = ProblemDAO.retrieveProblemByProblemId(problemIds.get(problemIds.size() - 1));
    } else {
        latestJob = JobDAO.retrieveJobByJobId(jobIds.get(jobIds.size() - 1));
        problemIds = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
    }

    if (selectedProb != null) {
        int selectedProbId = Integer.parseInt(selectedProb);
        latestProblem = ProblemDAO.retrieveProblemByProblemId(selectedProbId);
        int selectedJobId = latestProblem.getJobKey();
        latestJob = JobDAO.retrieveJobByJobId(selectedJobId);
        problemIds = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
    } else {

        latestProblem = ProblemDAO.retrieveProblemByProblemId(problemIds.get(problemIds.size() - 1));
    }

    //messages
    String successCaseMsg = (String) request.getSession().getAttribute("successCaseMsg");
    request.getSession().removeAttribute("successCaseMsg");

    String successWorkerMsg = (String) request.getSession().getAttribute("successWrkCompMsg");
    request.getSession().removeAttribute("successWrkCompMsg");

    String errorWorkerMsg = (String) request.getSession().getAttribute("errorWrkCompMsg");
    request.getSession().removeAttribute("errorWrkCompMsg");

    String successJobMsg = (String) request.getSession().getAttribute("successJobCompMsg");
    request.getSession().removeAttribute("successJobCompMsg");

    String errorJobMsg = (String) request.getSession().getAttribute("errorJobCompMsg");
    request.getSession().removeAttribute("errorJobCompMsg");

    String successProbMsg = (String) request.getSession().getAttribute("successProbCompMsg");
    request.getSession().removeAttribute("successProbCompMsg");

    String errorProbMsg = (String) request.getSession().getAttribute("errorProbCompMsg");
    request.getSession().removeAttribute("errorProbCompMsg");

    String successBenefitMsg = (String) request.getSession().getAttribute("successBenefitMsg");
    request.getSession().removeAttribute("successBenefitMsg");

    String errorBenefitMsg = (String) request.getSession().getAttribute("errorBenefitMsg");
    request.getSession().removeAttribute("errorBenefitMsg");

    String successAttachMsg = (String) request.getSession().getAttribute("successAttachMsg");
    request.getSession().removeAttribute("successAttachMsg");

    String errorAttachMsg = (String) request.getSession().getAttribute("errAttachMsg");
    request.getSession().removeAttribute("errAttachMsg");

    //tab indicator
    String tabIndicator = (String) request.getSession().getAttribute("tabIndicator");
    request.getSession().removeAttribute("tabIndicator");

    if (tabIndicator != null && tabIndicator.equals("job")) {
        isJob = true;
    } else if (tabIndicator != null && tabIndicator.equals("problem")) {
        isProblem = true;
    } else if (tabIndicator != null && tabIndicator.equals("benefit")) {
        isBenefit = true;
    } else if (successAttachMsg != null || errorAttachMsg != null) {
        isAttachment = true;
    }

    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

    String userRole = userLogin.getRole();
    
    DecimalFormat df = new DecimalFormat("#,###,##0.00");
%>


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
        <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
        <link rel="stylesheet" href="css/jasny-bootstrap.css"/>
        <link rel="stylesheet" href="css/dataTables.bootstrap.css"/>
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 

        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-ui-1.9.2.custom.js"></script>
        <script src="js/jquery.steps.js"></script>
        <script type="text/javascript" src="js/bootstrapValidator.min.js"></script>        
        <!--jasny-bootstrap v3.1.3, added by soemyatmyat-->
        <script src="js/jasny-bootstrap.js"></script>  
        <!-- DataTables JS, Added by soemyatmyat -->
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script> 

        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>CAMANS</title>

        <script>
            $(document).ready(function() {
                if (<%=isProblem%> === true) {
                    $(".complement_tabs").removeClass("active");
                    $("#worker_complement").removeClass("active");
                    $("#job_complement").removeClass("active");
                    $("#problem_complement_tab").addClass("active");
                    $("#problem_complement").addClass("active");
                    $("#problemSelected").val('<%=latestProblem.getProbKey()%>');

                } else if (<%=isJob%> === true) {
                    $(".complement_tabs").removeClass("active");
                    $("#job_complement_tab").addClass("active");
                    $(".tab-pane").removeClass("active");
                    $("#job_complement").addClass("active");
                    $("#jobSelected").val('<%=latestJob.getJobKey()%>');

                } else if (<%=isBenefit%> === true) {
                    $(".complement_tabs").removeClass("active");
                    $("#worker_complement").removeClass("active");
                    $("#job_complement").removeClass("active");
                    $("#benefit_complement_tab").addClass("active");
                    $("#benefit_complement").addClass("active");

                } else if (<%=isAttachment%> === true) {
                    $(".complement_tabs").removeClass("active");
                    $("#worker_complement").removeClass("active");
                    $("#job_complement").removeClass("active");
                    $("#benefit_complement").removeClass("active");
                    $("#attachment_complement_tab").addClass("active");
                    $("#attachment_complement").addClass("active");


                }
            });
            $(document).ready(function() {
                $('[data-toggle=offcanvas]').click(function() {
                    $('.row-offcanvas').toggleClass('active');
                });

                $('.moreObjs').hide();

                $('.alert').fadeOut(9999);
            });


            //for date inputs
            $(document).ready(function() {

                $('.no_change').focus(function() {

                    $('.no_change').blur();

                });

            });


        </script>
        <style>
            .changebtn{
                width:14%;
            }
            .col-md-1{
                width:17%;
            }

            .col-md-offset-6{
                margin-left:35%;
            }


            .accordion_panel_heading{
                background-color: #eee;
                color: #006C9A;

            }

            #side-menu{
                position: static !important;
            }


            .table th{
                text-align: left;
            }

            .table tr{
                text-align: left;
            }

            .tbl-20-col{
                width: 20%;
                text-align: left;
            }

            .tbl-25-col{
                width: 25%;
                text-align: left;
            }

            .alert{
                position: absolute;
                width: 40vw;
                margin-left: 11vw;
                height: 8vh;
                z-index: 999;
                top: 18vh;
            }
        </style>
    </head>
    <body id="home" style='background:white;overflow-y: scroll'>
        <jsp:include page="include/navbartop.jsp"/>
        <div class="row-offcanvas row-offcanvas-left" style="padding:0;">

            <div id="sidebar" class="sidebar-offcanvas ">
                <jsp:include page="include/navbarside.jsp"/>
                <!--stubs-->
                <div class="col-md-6" style="left: 50% "  id="worker_profile_div">
                    <!-- face Picture -->
                    <br/>
                    <div id="worker_profile_pic" class="text-center">
                        <% if (worker.getPhotoPath() == null) {%>
                        <img src="img/profile_pic.jpg" style="max-width: 40%"> <!--get image from db also -->
                        <% } else {%>
                        <img src="<%=worker.getPhotoPath()%>" style="max-width: 40%"> 
                        <% }%>
                    </div>
                    <br/>

                    <!--worker stub-->
                    <div class="col-md-12 worker_profile_header text-center">Worker Stub
                        <a id="worker_profile_details" style="color: white" data-target="#worker_stub"  data-value='worker' href="#" data-title="View Worker Profile" data-toggle="modal" data-action="view" class="profile_details"><span class="glyphicon glyphicon-eye-open pull-right" pull-right></span></a>
                    </div>
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
                    <table class="table table-condensed" class="stub-table">
                        <tr>
                            <td class="col-md-6">Name</td>
                            <td class="col-md-6"><%=worker.getName()%></td>
                        </tr>
                        <tr>
                            <td class="col-md-6">FIN</td>
                            <td class="col-md-6"><%=worker.getFinNumber()%></td>
                        </tr>
                        <tr>
                            <td class="col-md-6">Phone</td>
                            <td class="col-md-6"><%=(wkerphNum == "") ? "-" : wkerphNum%></td>
                        </tr>
                    </table>

                    <!--job stub-->
                    <div class="col-md-12 worker_profile_header text-center">Job Stub<a id="job_profile_details" style="color: white"  data-value='job' href="#" data-title="View Job Profile" data-toggle="modal" data-action="view" class="profile_details"><span class="glyphicon glyphicon-eye-open pull-right" pull-right></span></a>
                    </div>
                    <table class="table table-condensed" class="stub-table">
                        <tr>
                            <td class="col-md-6">Employer</td>
                            <td class="col-md-6"><%=latestJob.getEmployerName()%></td>
                        </tr>
                        <tr>
                            <td class="col-md-6">Work pass</td>
                            <td class="col-md-6"><%=latestJob.getWorkPassType()%></td>
                        </tr>
                        <tr>
                            <td class="col-md-6">Occupation</td>
                            <td class="col-md-6"><%=(latestJob.getOccupation() == null) ? "-" : latestJob.getOccupation()%></td>
                        </tr>
                        <tr>
                            <td class="col-md-6">Start date</td>
                            <td class="col-md-6"><%=(latestJob.getJobStartDate() == null) ? "-" : latestJob.getJobStartDate()%></td>
                        </tr>
                    </table>


                    <!--Problem Stub-->
                    <!--job stub-->
                    <div class="col-md-12 worker_profile_header text-center">Problem Stub<a id="problem_profile_details" style="color: white"  data-value='problem' href="#" data-title="View Problem Profile" data-toggle="modal" data-action="view" class="profile_details"><span class="glyphicon glyphicon-eye-open pull-right" pull-right></span></a>
                    </div>
                    <%
                        ArrayList<Integer> injuryList = ProblemComplementsDAO.retrieveProblemInjuryIdsOfProblem(latestProblem);
                        ProblemInjury injuryObj = null;
                        java.util.Date injuryDate = null;
                        if (injuryList != null && injuryList.size() > 0) {
                            injuryObj = ProblemComplementsDAO.retrieveProblemInjuryById(injuryList.get(injuryList.size() - 1));
                            injuryDate = injuryObj.getInjuryDate();
                        }

                        ArrayList<Integer> leadCaseWorkerList = ProblemComplementsDAO.retrieveLeadCaseWorkerIdsOfProblem(latestProblem);
                        ProblemLeadCaseWorker leadCaseWorkerObj = null;
                        String leadCaseWorkerName = null;
                        if (leadCaseWorkerList != null && leadCaseWorkerList.size() > 0) {
                            leadCaseWorkerObj = ProblemComplementsDAO.retrieveProblemLeadCaseWorkerById(leadCaseWorkerList.get(leadCaseWorkerList.size() - 1));
                            leadCaseWorkerName = leadCaseWorkerObj.getLeadCaseWorker();
                        }

                    %>
                    <table class="table table-condensed" class="stub-table">
                        <tr>
                            <td class="col-md-6">Problem</td>
                            <td class="col-md-6"><%=latestProblem.getProblem()%></td>
                        </tr>

                        <tr>
                            <td class="col-md-6">Registered date</td>
                            <td class="col-md-6"><%=sdf.format(latestProblem.getProblemRegisteredDate())%></td>
                        </tr>
                        <tr>
                            <td class="col-md-6">Injured date</td>
                            <td class="col-md-6"><%=(injuryDate == null) ? "-" : sdf.format(injuryDate)%></td>
                        </tr>
                        <tr>
                            <td class="col-md-6">Lead caseworker</td>
                            <td class="col-md-6"><%=(leadCaseWorkerName == null) ? "-" : leadCaseWorkerName%></td>
                        </tr>
                    </table>
                </div>
            </div>

            <div id="complement_details_div" class="col-md-offset-6 col-md-6">

                <div class="col-md-12 ">

                    <div  id="content" style="padding: 3% 1%">

                        <div class="tab-content ">
                            <% if (successAttachMsg != null || errorAttachMsg != null) {%>
                            <div class="tab-pane" id="worker_complement">
                                <% } else {%>    
                                <!--Worker Complement Tab--> 
                                <div class="tab-pane active" id="worker_complement"> 
                                    <% }%>    
                                    <br/>

                                    <!-- Worker Complement Success & Error Display -->

                                    <%

                                        if (successCaseMsg != null) {
                                            if (!successCaseMsg.equals("")) {%>

                                    <div class="alert alert-info" role="alert">
                                        <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                        <%=successCaseMsg%>
                                    </div>

                                    <% }
                                        }%>
                                    <%
                                        if (successWorkerMsg != null) {
                                            if (!successWorkerMsg.equals("")) {%>

                                    <div class="alert alert-info" role="alert">
                                        <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                        <%=successWorkerMsg%>
                                    </div>

                                    <% }
                                        }%>
                                    <% if (errorWorkerMsg != null) {
                                            if (!errorWorkerMsg.equals("")) {%>

                                    <div class="alert alert-danger" role="alert">
                                        <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                        <%=errorWorkerMsg%>
                                    </div>

                                    <% }
                                        }%>
                                    <!-- End of Worker Complement Success & Error Display -->

                                    <div class='row'>
                                        <!--Nickname-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">Nickname 
                                                    <a href="" id="nicknameAddBtn" data-class="worker"  data-toggle="modal" data-action = "add" data-title="Add A New Nickname" data-target="#nickname_pop_up" data-value='nickname' data-nickname='' class="add_btn pop_up_open pull-right">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                    </a>
                                                </h4>
                                            </div>
                                            <div class="panel-body ">
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
                                                            <td class="text-center" style="width:20%">
                                                                <a style="color: black"  data-class="worker" data-title="View Worker's Nickname" data-value='nickname' 
                                                                   data-nickname='<%=nicknameObj.getId()%>' href="" data-toggle="modal" data-action="viewedit" 
                                                                   data-target="#nickname_pop_up" class="edit_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                </a>  
                                                            </td>
                                                            <% if (userRole.equals("Administrator")) {%>
                                                            <td class="text-center" style="width:20%"> 
                                                                <a style="color: black"  data-class="worker" data-value='nickname' 
                                                                   data-nickname='<%=nicknameObj.getId()%>' href="" data-toggle="modal" data-action="delete" 
                                                                   data-target="#nickname_pop_up" class="delete_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                </a>   
                                                            </td>
                                                            <% }%>   
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
                                                            <td class="text-center" style="width:20%"><a style="color: black"  data-class="worker" data-title="View Worker's Nickname" data-value='nickname' data-nickname='<%=nicknameObj.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#nickname_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                    <% if (userRole.equals("Administrator")) {%>
                                                            <td class="text-center" style="width:20%"> 
                                                                <a style="color: black"  data-class="worker" data-value='nickname' 
                                                                   data-nickname='<%=nicknameObj.getId()%>' href="" data-toggle="modal" data-action="delete" 
                                                                   data-target="#nickname_pop_up" class="delete_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                </a>   
                                                            </td>
                                                            <% }%> 
                                                        </tr>
                                                    </table>
                                                </div>        
                                                <%
                                                        }

                                                    }
                                                    if (nickNameIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_nickname_seemore" onclick="seemore('.other_nickname');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_nickname_seemore" onclick="seemore('.other_nickname');">View Less</a>
                                                <%                                                }
                                                    }
                                                %>
                                            </div>   
                                        </div>

                                        <!--Passport Details-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Passport
                                                    <a href="" id="passportAddBtn" data-toggle="modal" data-target="#passport_pop_up" data-action = "add" data-title="Add A New Passport Details" data-value='passport' data-passport='' data-class="worker"  class="add_btn pop_up_open pull-right">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> passportDetailsIds = WorkerComplementsDAO.retrievePassportIdsOfWorker(worker);
                                                    if (passportDetailsIds != null && !passportDetailsIds.isEmpty()) {

                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class='tbl-20-col'>Passport country</th>
                                                        <th class='tbl-20-col'>Passport number</th>
                                                        <th class='tbl-20-col'>Issued date</th>
                                                        <th class='tbl-20-col'>Expiry date</th>
                                                        <th class="tbl-20-col">Action</th>
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
                                                        <td class="tbl-20-col"><a style="color: black" data-value='passport' data-passport='<%=passportDetails.getId()%>' 
                                                                                  data-title="View Passport Details" href="" data-toggle="modal" data-class="worker"  data-action="viewedit" 
                                                                                  data-target="#passport_pop_up" class="edit_btn pop_up_open text-center">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color:black" data-value='passport' data-passport='<%=passportDetails.getId()%>' 
                                                               href="" data-toggle="modal" data-class="worker" data-action="delete"
                                                               data-target="" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span></a>
                                                                <% }%> 
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
                                                        <td class="tbl-20-col"><a style="color: black" data-value='passport' data-passport='<%=passportDetails.getId()%>' 
                                                                                  data-title="View Passport Details" href="" data-toggle="modal" data-class="worker"  data-action="viewedit" 
                                                                                  data-target="#passport_pop_up" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color:black" data-value='passport' data-passport='<%=passportDetails.getId()%>' 
                                                               data-title="View Passport Details" href="" data-toggle="modal" data-class="worker" data-action="delete"
                                                               data-target="" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span></a>
                                                                <% }%>    
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

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_passport_seemore" onclick="seemore('.other_passport');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_passport_seemore" onclick="seemore('.other_passport');">View Less</a>
                                                <%                                            }
                                                %>
                                            </div>
                                        </div>

                                        <!--Singapore Phone Number-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">Singapore Phone Number <a data-value='sgphone' data-action = "add" data-sgphone='' data-title="Add A New Singapore Phone Number " href="" data-toggle="modal" data-class="worker"  data-target="#sgPhone_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>
                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> phoneNumberIds = WorkerComplementsDAO.retrieveSgCountryPhoneNumIdsOfWorker(worker);
                                                    if (phoneNumberIds != null && !phoneNumberIds.isEmpty()) {
                                                        for (int i = phoneNumberIds.size() - 1; i >= 0; i--) {
                                                            WorkerSgPhNum phNumObj = WorkerComplementsDAO.retrieveWorkerSgPhNumById(phoneNumberIds.get(i));
                                                            String phNum = phNumObj.getPhNumber();
                                                            java.util.Date obsolete = phNumObj.getObseleteDate();
                                                            if (obsolete != null) {
                                                                phNum = phNum + " (Obsolete on " + sdf.format(obsolete) + ")";
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
                                                            <td class="text-center" style="width:20%">
                                                                <a style="color: black" data-value='sgphone' data-title="View Singapore Phone Number Details" 
                                                                   data-sgphone='<%=phId%>' href="" data-toggle="modal" data-target="#sgPhone_pop_up" data-class="worker" 
                                                                   data-action="viewedit" class="edit_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                </a>
                                                            </td>
                                                            <% if (userRole.equals("Administrator")) {%>
                                                            <td class="text-center" style="width:20%">
                                                                <a style="color: black" data-value='sgphone'
                                                                   data-sgphone='<%=phId%>' href="" data-toggle="modal" data-target="#sgPhone_pop_up" data-class="worker" 
                                                                   data-action="delete" class="delete_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                </a>
                                                            </td>
                                                            <% }%>  
                                                        </tr>
                                                    </table>
                                                </div>

                                                <%} else {
                                                %>
                                                <div class="col-md-4">
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <td style="width:80%"><%=phNum%></td>
                                                            <td class="text-center" style="width:20%"><a style="color: black" data-value='sgphone' data-title="View Singapore Phone Number Details" data-sgphone='<%=phId%>' href="" data-toggle="modal" data-target="#sgPhone_pop_up" data-class="worker"  data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                    <% if (userRole.equals("Administrator")) {%>
                                                            <td class="text-center" style="width:20%">
                                                                <a style="color: black" data-value='sgphone'
                                                                   data-sgphone='<%=phId%>' href="" data-toggle="modal" data-target="#sgPhone_pop_up" data-class="worker" 
                                                                   data-action="delete" class="delete_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                </a>
                                                            </td>
                                                            <% }%> 
                                                        </tr>
                                                    </table> 
                                                </div>
                                                <%
                                                        }
                                                    }
                                                    if (phoneNumberIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_sgphone_seemore" onclick="seemore('.other_sgphone');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_sgphone_seemore" onclick="seemore('.other_sgphone');">View Less</a>
                                                <%                                                            }
                                                    }

                                                %>
                                            </div>
                                        </div>

                                        <!--Home Country Phone Number-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">

                                                <h4 class="panel-title">Home Country Phone Number 
                                                    <a data-value='homephone' data-action = "add" data-homephone='' data-title="Add A New Home Country Phone Number"
                                                       href="" data-toggle="modal" data-class="worker"  
                                                       data-target="#homePhone_pop_up" class="edit_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right>
                                                        </span></a></h4>


                                            </div>
                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> homePhIds = WorkerComplementsDAO.retrieveHomeCountryPhoneNumIdsOfWorker(worker);
                                                    if (homePhIds != null && !homePhIds.isEmpty()) {
                                                %>
                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th>Phone number</th>
                                                        <th>Owner of number</th>
                                                        <th>Obsolete</th>
                                                        <th class="tbl-20-col">Action</th>
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
                                                        <td class="tbl-20-col"><a style="color: black" data-value='homephone' 
                                                                                  data-title="View Home Country Phone Number Details" data-homephone='<%=homePhNum.getId()%>' href="" data-toggle="modal" 
                                                                                  data-class="worker"  data-target="#homePhone_pop_up" data-action="viewedit" 
                                                                                  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='homephone' 
                                                               data-homephone='<%=homePhNum.getId()%>' href="" data-toggle="modal" 
                                                               data-class="worker"  data-target="" data-action="delete" 
                                                               class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>     
                                                        </td>
                                                    </tr>     
                                                    <%} else {%>
                                                    <tr>
                                                        <td><%=phNum%></td>
                                                        <td><%=owner%></td>
                                                        <td><%=(oDate == null) ? "-" : sdf.format(oDate)%></td>
                                                        <td class="tbl-20-col"><a style="color: black" data-value='homephone' data-homephone='<%=homePhNum.getId()%>' 
                                                                                  data-title="View Home Country Phone Number Details" href="" data-toggle="modal" data-class="worker"  data-target="#homePhone_pop_up" 
                                                                                  data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='homephone' 
                                                               data-homephone='<%=homePhNum.getId()%>' href="" data-toggle="modal" 
                                                               data-class="worker"  data-target="" data-action="delete" 
                                                               class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>     
                                                        </td>                                                    </tr>    
                                                        <%
                                                                }
                                                            }
                                                        %>
                                                </table>
                                                <%
                                                    if (homePhIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_homephone_seemore" onclick="seemore('.other_homephone');">View Less</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_homephone_seemore" onclick="seemore('.other_homephone');">See More</a>
                                                <%                                                    }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Singapore Address-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">

                                                <h4 class="panel-title">Singapore Address <a data-value='sgadd' data-action = "add" data-sgadd='' data-title="Add A New Singapore Address" href="" data-toggle="modal" data-class="worker"  data-target="#sgAdd_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>


                                            </div>
                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> sgAddressIds = WorkerComplementsDAO.retrieveWorkerSgAddressIdsOfWorker(worker);
                                                    if (sgAddressIds != null && !sgAddressIds.isEmpty()) {
                                                        for (int i = sgAddressIds.size() - 1; i >= 0; i--) {
                                                            WorkerSgAddress sgAddress = WorkerComplementsDAO.retrieveWorkerSgAddressById(sgAddressIds.get(i));
                                                            String address = sgAddress.getAddress();
                                                            java.util.Date oDate = sgAddress.getObseleteDate();
                                                            if (oDate != null) {
                                                                address += " (Obsolete on " + sdf.format(oDate) + ")";
                                                            } else {
                                                                address += " (Active)";
                                                            }
                                                            if (i < sgAddressIds.size() - 1) {
                                                %>
                                                <div class="col-md-6 other_sgaddress moreObjs">

                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <td style="width:80%"><%=address%></td>
                                                            <td class="text-center" style="width:20%">
                                                                <a style="color: black" data-class="worker" data-title="View Singapore Address Details" 
                                                                   data-value='sgadd' data-sgadd='<%=sgAddress.getId()%>' href="" data-toggle="modal" 
                                                                   data-target="#sgAdd_pop_up" data-action="viewedit" class="edit_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                </a>
                                                            </td>
                                                            <% if (userRole.equals("Administrator")) {%>
                                                            <td class="text-center" style="width:20%">
                                                                <a style="color: black" data-class="worker" data-title="View Singapore Address Details" 
                                                                   data-value='sgadd' data-sgadd='<%=sgAddress.getId()%>' href="" data-toggle="modal" 
                                                                   data-target="#" data-action="delete" class="delete_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                </a>
                                                            </td>
                                                            <% }%> 
                                                        </tr>
                                                    </table> 
                                                </div>
                                                <%} else {
                                                %>
                                                <div class="col-md-6">
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <td style="width:87%"><%=address%></td>
                                                            <td class="text-center" style="width:13%"><a style="color: black" data-class="worker" data-title="View Singapore Address Details" data-value='sgadd' data-sgadd='<%=sgAddress.getId()%>' href="" data-toggle="modal" data-target="#sgAdd_pop_up" data-action="viewedit" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                    <% if (userRole.equals("Administrator")) {%>
                                                            <td class="text-center" style="width:20%">
                                                                <a style="color: black" data-class="worker" data-title="View Singapore Address Details" 
                                                                   data-value='sgadd' data-sgadd='<%=sgAddress.getId()%>' href="" data-toggle="modal" 
                                                                   data-target="#" data-action="delete" class="delete_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                </a>
                                                            </td>
                                                            <% }%>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <%
                                                        }

                                                    }
                                                    if (sgAddressIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_sgaddress_seemore" onclick="seemore('.other_sgaddress');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_sgaddress_seemore" onclick="seemore('.other_sgaddress');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Home Country Address-->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">

                                                <h4 class="panel-title">Home Country Address <a data-value='homeadd' data-action = "add" data-title="Add A New Home Country Address" data-homeadd='' href="" data-toggle="modal" data-class="worker"  data-target="#homeAdd_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>


                                            </div>
                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> homeCountryAddressIds = WorkerComplementsDAO.
                                                            retrieveWorkerHomeCountryAddressIdsOfWorker(worker);
                                                    if (homeCountryAddressIds != null && !homeCountryAddressIds.isEmpty()) {
                                                        for (int i = homeCountryAddressIds.size() - 1; i >= 0; i--) {
                                                            WorkerHomeCountryAddress addressObj = WorkerComplementsDAO.retrieveWorkerHomeCountryAddressById(homeCountryAddressIds.get(i));
                                                            String address = addressObj.getAddress();
                                                            java.util.Date oDate = addressObj.getObseleteDate();
                                                            if (oDate != null) {
                                                                address += " (Obsolete on " + sdf.format(oDate) + ")";
                                                            } else {
                                                                address += " (Active)";
                                                            }
                                                            if (i < homeCountryAddressIds.size() - 1) {
                                                %>

                                                <div class="col-md-6 other_homeaddress moreObjs" >
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <td style="width:80%"><%=address%></td>
                                                            <td class="text-center" style="width:20%">
                                                                <a style="color: black" data-class="worker" data-title="View Home Country Address Details" 
                                                                   data-value='homeadd' data-homeadd='<%=addressObj.getId()%>' href="" data-toggle="modal" 
                                                                   data-action="viewedit" data-target="#homeAdd_pop_up" class="edit_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                </a>
                                                            </td>
                                                            <% if (userRole.equals("Administrator")) {%>
                                                            <td class="text-center" style="width:20%">
                                                                <a style="color: black" data-class="worker" 
                                                                   data-value='homeadd' data-homeadd='<%=addressObj.getId()%>' href="" data-toggle="modal" 
                                                                   data-action="delete" data-target="#" class="delete_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                </a>
                                                            </td>
                                                            <% }%>
                                                        </tr>
                                                    </table>

                                                </div>
                                                <%} else {
                                                %>
                                                <div class="col-md-6">
                                                    <table class="table table-bordered">
                                                        <tr>
                                                            <td style="width:90%"><%=address%></td>
                                                            <td class="text-center" style="width:10%"><a style="color: black" data-class="worker" data-title="View Home Country Address Details" data-value='homeadd' data-homeadd='<%=addressObj.getId()%>' href="" data-toggle="modal" data-action="viewedit" data-target="#homeAdd_pop_up" class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a></td>
                                                                    <% if (userRole.equals("Administrator")) {%>
                                                            <td class="text-center" style="width:20%">
                                                                <a style="color: black" data-class="worker" 
                                                                   data-value='homeadd' data-homeadd='<%=addressObj.getId()%>' href="" data-toggle="modal" 
                                                                   data-action="delete" data-target="#" class="delete_btn pop_up_open">
                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                </a>
                                                            </td>
                                                            <% }%>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <%
                                                        }
                                                    }
                                                    if (homeCountryAddressIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_homeaddress_seemore" onclick="seemore('.other_homeaddress');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_homeaddress_seemore" onclick="seemore('.other_homeaddress');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Digital Contacts-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Digital Contacts
                                                    <a data-value='digcontact' data-class="worker"  data-digcontact='' href="" data-title="Add A New Digital Contact Address" data-action = "add" data-toggle="modal" data-target="#digContact_pop_up" class="edit_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> digitalContactsIds = WorkerComplementsDAO.retrieveDigitalContactIdsOfWorker(worker);
                                                    if (digitalContactsIds != null && !digitalContactsIds.isEmpty()) {

                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class='tbl-20-col'>Type</th>
                                                        <th class='tbl-20-col'>Email/QQ etc</th>
                                                        <th class='tbl-20-col'>Owner of address</th>
                                                        <th class='tbl-20-col'>Obsolete</th>
                                                        <th class="tbl-20-col">Action</th>
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
                                                        <td><%=(obDate == null) ? "Still In use" : sdf.format(obDate)%></td>
                                                        <td class="tbl-20-col"><a style="color: black" data-class="worker"  data-value='digcontact' 
                                                                                  data-title="View Digital Contact Details" data-digcontact='<%=digitalContact.getId()%>' href="" data-toggle="modal" 
                                                                                  data-action="viewedit" data-target="#digContact_pop_up" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-class="worker"  data-value='digcontact' 
                                                               data-digcontact='<%=digitalContact.getId()%>' href="" data-toggle="modal" 
                                                               data-action="delete" data-target="#" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
                                                        </td>                                                    </tr>
                                                        <%} else {%>
                                                    <tr>
                                                        <td><%=type%></td>
                                                        <td><%=contactAdd%></td>
                                                        <td><%=owner%></td>
                                                        <td><%=(obDate == null) ? "Still In use" : sdf.format(obDate)%></td>
                                                        <td class="tbl-20-col"><a style="color: black" data-class="worker"  data-value='digcontact' 
                                                                                  data-title="View Digital Contact Details" data-digcontact='<%=digitalContact.getId()%>' href="" data-toggle="modal" 
                                                                                  data-action="viewedit" data-target="#digContact_pop_up" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-class="worker"  data-value='digcontact' 
                                                               data-digcontact='<%=digitalContact.getId()%>' href="" data-toggle="modal" 
                                                               data-action="delete" data-target="#" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
                                                        </td>                                                    </tr>
                                                        <%
                                                                }
                                                            }
                                                        %>
                                                </table>
                                                <%
                                                    if (digitalContactsIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_digContact_seemore" onclick="seemore('.other_digContact');">See more</a>
                                                <a style="cursor:pointer; display:none" class="text-center col-sm-12 seemore_btn other_digContact_seemore" onclick="seemore('.other_digContact');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Next of Kins-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Next of Kin
                                                    <a data-value='nok' data-class="worker"  data-nok='' href="" data-toggle="modal" data-title="Add A New Next of Kin" data-action = "add" data-target="#nok_pop_up" class="edit_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> nextOfKinsIds = WorkerComplementsDAO.retrieveNextOfKinIdsOfWorker(worker);
                                                    if (nextOfKinsIds != null && !nextOfKinsIds.isEmpty()) {
                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class='tbl-20-col'>NOK name</th>
                                                        <th class="tbl-20-col">How related</th>
                                                        <th class='tbl-20-col'>NOK phone</th>
                                                        <th class='tbl-20-col'>NOK other contact</th>
                                                        <th class="tbl-20-col">Action</th>
                                                    </tr>

                                                    <%
                                                        for (int i = nextOfKinsIds.size() - 1; i >= 0; i--) {
                                                            WorkerNextOfKin nextOfKins = WorkerComplementsDAO.retrieveWorkerNextOfKinById(nextOfKinsIds.get(i));
                                                            String name = nextOfKins.getName();
                                                            String relationship = nextOfKins.getRelation();

                                                            if (relationship.length() > 60) {
                                                                relationship = relationship.substring(0, 60) + "...";
                                                            }

                                                            String phNum = nextOfKins.getPhoneNumber();
                                                            String otherContact = nextOfKins.getDigital();
                                                            if (i < nextOfKinsIds.size() - 1) {

                                                    %>
                                                    <tr class="other_nok moreObjs">
                                                        <td><%=name%></td>
                                                        <td><%=(relationship == null) ? "" : relationship%></td>
                                                        <td><%=(phNum == null) ? "" : phNum%></td>
                                                        <td><%=(otherContact == null) ? "" : otherContact%></td>
                                                        <td class="tbl-20-col"><a style="color: black"  data-class="worker" data-value='nok' 
                                                                                  data-title="View Next of Kin Details" data-nok='<%=nextOfKins.getId()%>' href="" data-toggle="modal" data-target="#nok_pop_up" 
                                                                                  data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black"  data-class="worker" data-value='nok' 
                                                               data-nok='<%=nextOfKins.getId()%>' href="" data-toggle="modal" data-target="#nok_pop_up" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
                                                        </td>

                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>
                                                        <td><%=name%></td>
                                                        <td><%=(relationship == null) ? "" : relationship%></td>
                                                        <td><%=(phNum == null) ? "" : phNum%></td>
                                                        <td><%=(otherContact == null) ? "" : otherContact%></td>
                                                        <td class="tbl-20-col"><a style="color: black"  data-class="worker" data-value='nok' 
                                                                                  data-title="View Next of Kin Details" data-nok='<%=nextOfKins.getId()%>' href="" data-toggle="modal" data-target="#nok_pop_up" 
                                                                                  data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black"  data-class="worker" data-value='nok' 
                                                               data-nok='<%=nextOfKins.getId()%>' href="" data-toggle="modal" data-target="#nok_pop_up" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                                <%
                                                    if (nextOfKinsIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_nok_seemore" onclick="seemore('.other_nok');">See more</a>
                                                <a style="cursor:pointer; display:none" class="text-center col-sm-12 seemore_btn other_nok_seemore" onclick="seemore('.other_nok');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Family Members-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Family Members
                                                    <a data-value='familymember' data-class="worker"  data-familymember='' href="" data-title="Add A New family Member" data-action = "add" data-toggle="modal" data-target="#familyMember_pop_up" class="edit_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> familyMmbrIds = WorkerComplementsDAO.retrieveFamilyMemberIdsOfWorker(worker);
                                                    if (familyMmbrIds != null && !familyMmbrIds.isEmpty()) {
                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class='tbl-20-col'>FamMem name</th>
                                                        <th class="tbl-20-col">How related</th>
                                                        <th class='tbl-20-col'>FamMem phone</th>
                                                        <th class='tbl-20-col'>FamMem other contact</th>
                                                        <th class="tbl-20-col">Action</th>
                                                    </tr>

                                                    <%
                                                        for (int i = familyMmbrIds.size() - 1; i >= 0; i--) {
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
                                                        <td class="tbl-20-col"><a style="color: black" data-class="worker"  data-value='familymember' 
                                                                                  data-title="View family Member Details" data-familymember='<%=familyMember.getId()%>' href="" data-toggle="modal" 
                                                                                  data-action="viewedit" data-target="#familyMember_pop_up" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-class="worker"  data-value='familymember' 
                                                               data-familymember='<%=familyMember.getId()%>' href="" data-toggle="modal" 
                                                               data-action="delete" data-target="#" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
                                                        </td>
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>
                                                        <td><%=name%></td>
                                                        <td><%=relationship%></td>
                                                        <td><%=phNum%></td>
                                                        <td><%=otherContact%></td>
                                                        <td class="tbl-20-col"><a style="color: black" data-class="worker"  data-value='familymember' 
                                                                                  data-title="View family Member Details" data-familymember='<%=familyMember.getId()%>' href="" data-toggle="modal" 
                                                                                  data-action="viewedit" data-target="#familyMember_pop_up" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-class="worker"  data-value='familymember' 
                                                               data-familymember='<%=familyMember.getId()%>' href="" data-toggle="modal" 
                                                               data-action="delete" data-target="#" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                                <%
                                                    if (familyMmbrIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_familyMember_seemore" onclick="seemore('.other_familyMember');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_familyMember_seemore" onclick="seemore('.other_familyMember');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Friends in Singapore-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Friends In Singapore
                                                    <a data-value='sgfri' data-sgfri='' data-class="worker"  href="" data-toggle="modal" data-title="Add A New friend in Singapore" data-action = "add" data-target="#sgFri_pop_up" class="edit_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> friendIds = WorkerComplementsDAO.retrieveFriendIdsOfWorker(worker);
                                                    if (friendIds != null && !friendIds.isEmpty()) {
                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class='tbl-20-col'>Friend name</th>
                                                        <th class='tbl-20-col'>Friend phone</th>
                                                        <th class="tbl-20-col">How related</th>
                                                        <th class='tbl-20-col'>Friend remarks</th>
                                                        <th class="tbl-20-col">Action</th>
                                                    </tr>

                                                    <%
                                                        for (int i = friendIds.size() - 1; i >= 0; i--) {
                                                            WorkerFriend friend = WorkerComplementsDAO.retrieveWorkerFriendById(friendIds.get(i));

                                                            String name = friend.getName();
                                                            String relationship = friend.getRelation();
                                                            String phNum = friend.getPhone();
                                                            String remark = friend.getRemark();
                                                            //java.util.Date obDate = friend.getObseleteDate();
                                                            if (i < friendIds.size() - 1) {
                                                    %>
                                                    <tr class="moreObjs other_friend">
                                                        <td><%=name%></td>
                                                        <td><%=phNum%></td>
                                                        <td><%=relationship%></td>
                                                        <td><%=(remark == null) ? "" : remark%></td>
                                                        <td class="tbl-20-col"><a style="color: black" data-class="worker"  data-value='sgfri' 
                                                                                  data-title="View Details of friend in Singapore" data-sgfri='<%=friend.getId()%>' href="" data-toggle="modal" data-target="#sgFri_pop_up" 
                                                                                  data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-class="worker"  data-value='sgfri' 
                                                               data-sgfri='<%=friend.getId()%>' href="" data-toggle="modal" data-target="#" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
                                                        </td>    
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>
                                                        <td><%=name%></td>
                                                        <td><%=phNum%></td>
                                                        <td><%=relationship%></td>
                                                        <td><%=(remark == null) ? "" : remark%></td>
                                                        <td class="tbl-20-col"><a style="color: black" data-class="worker"  data-value='sgfri' 
                                                                                  data-title="View Details of friend in Singapore" data-sgfri='<%=friend.getId()%>' href="" data-toggle="modal" data-target="#sgFri_pop_up" 
                                                                                  data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-class="worker"  data-value='sgfri' 
                                                               data-sgfri='<%=friend.getId()%>' href="" data-toggle="modal" data-target="#" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%> 
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                                <%
                                                    if (friendIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_friend_seemore" onclick="seemore('.other_friend');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_friend_seemore" onclick="seemore('.other_friend');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Worker's Language-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Language
                                                    <a data-value='language' data-class="worker"  data-language='' href="" data-toggle="modal" data-title="Add Worker's Language" data-action = "add" data-target="#language_pop_up" class="edit_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> languagueIds = WorkerComplementsDAO.retrieveLanguageIdsOfWorker(worker);
                                                    if (languagueIds != null && !languagueIds.isEmpty()) {
                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th>Main language</th>
                                                        <th>Spoken English</th>

                                                        <th class="tbl-20-col">Action</th>
                                                    </tr>

                                                    <%
                                                        for (int i = languagueIds.size()-1; i >= 0 ; i--) {
                                                            WorkerLanguage language = WorkerComplementsDAO.retrieveWorkerLanguageById(languagueIds.get(i));
                                                            String mlanguage = language.getMainLanguage();
                                                            String engStd = language.getSpokenLanguageStandard();
                                                            //String remark = language.getRemark();

                                                            if (i < languagueIds.size() - 1) {
                                                    %>
                                                    <tr class="other_language moreObjs">
                                                        <td><%=mlanguage%></td>
                                                        <td><%=engStd%></td>

                                                        <td class="tbl-20-col"><a style="color: black"  data-class="worker" data-value='language' data-title="View Details of Worker's Language" 
                                                                                  data-language='<%=language.getId()%>' href="" data-toggle="modal" data-target="#language_pop_up" 
                                                                                  data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>

                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black"  data-class="worker" data-value='language'
                                                               data-language='<%=language.getId()%>' href="" data-toggle="modal" data-target="#language_pop_up" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%> 
                                                        </td>   
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>
                                                        <td><%=mlanguage%></td>
                                                        <td><%=engStd%></td>

                                                        <td class="tbl-20-col"><a style="color: black"  data-class="worker" data-value='language' data-title='View Details of Worker Language' 
                                                                                  data-language='<%=language.getId()%>' href="" data-toggle="modal" data-target="#language_pop_up" 
                                                                                  data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>

                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black"  data-class="worker" data-value='language'
                                                               data-language='<%=language.getId()%>' href="" data-toggle="modal" data-target="#language_pop_up" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>
                                                        </td>   
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                                <%
                                                    if (languagueIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_language_seemore" onclick="seemore('.other_language');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_language_seemore" onclick="seemore('.other_language');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Bank Account Details-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Bank Account
                                                    <a data-value='bankacc' data-class="worker"  data-bankacc='' href="" data-toggle="modal" data-title='Add A New Bank Account Details' data-action = "add" data-target="#bankAcc_pop_up" class="edit_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> bankAcctDetailsIds = WorkerComplementsDAO.retrieveBankAccountDetailsIdsOfWorker(worker);
                                                    if (bankAcctDetailsIds != null && !bankAcctDetailsIds.isEmpty()) {
                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class='tbl-20-col'>Bank name</th>
                                                        <th class='tbl-20-col'>Account name</th>
                                                        <th class='tbl-20-col'>Account number</th>
                                                        <th class='tbl-20-col'>Obsolete</th>
                                                        <th class="tbl-20-col">Action</th>
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
                                                        <td class="tbl-20-col"><a style="color: black" data-value='bankacc' data-bankacc='<%=bankAcct.getId()%>' href="" 
                                                                                  data-toggle="modal" data-class="worker"  data-target="#bankAcc_pop_up" 
                                                                                  data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='bankacc' data-bankacc='<%=bankAcct.getId()%>' href="" 
                                                               data-title="View Bank Account Details" data-toggle="modal" data-class="worker"  data-target="#" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>     
                                                        </td>
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
                                                        <td class="tbl-20-col"><a style="color: black" data-value='bankacc' data-bankacc='<%=bankAcct.getId()%>' 
                                                                                  data-title="View Bank Account Details" href="" data-toggle="modal" data-class="worker"  data-target="#bankAcc_pop_up" 
                                                                                  data-action="viewedit" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='bankacc' data-bankacc='<%=bankAcct.getId()%>' href="" 
                                                               data-toggle="modal" data-class="worker"  data-target="#" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                                <%
                                                    if (bankAcctDetailsIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_bankacc_seemore" onclick="seemore('.other_bankacc');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_bankacc_seemore" onclick="seemore('.other_bankacc');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!--Job Complement Tab-->        
                                <div class="tab-pane " id="job_complement">
                                    <br/>
                                    <!-- Job Complement Success & Error Display -->

                                    <% if (successJobMsg != null) {
                                            if (!successJobMsg.equals("")) {%>

                                    <div class="alert alert-info" role="alert">
                                        <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                        <%=successJobMsg%>
                                    </div>

                                    <% }
                                        }%>
                                    <% if (errorJobMsg != null) {
                                            if (!errorJobMsg.equals("")) {%>

                                    <div class="alert alert-danger" role="alert">
                                        <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                        <%=errorJobMsg%>
                                    </div>

                                    <% }
                                        }%>
                                    <!-- End of Job Complement Success & Error Display -->
                                    <div class="row">
                                        <form method="POST" action="changeToSelected">
                                            <div class="form-group col-md-12">
                                                <label for="jobSelected" class="col-md-1 control-label">Select Job:</label>
                                                <div class="col-md-5">
                                                    <input type="hidden" name="workerFin" value="<%=workerFin%>"/>
                                                    <input type="hidden" name="selectedType" value="job"/>
                                                    <select class="form-control " id="jobSelected" name="selectedJob" required>
                                                        <%
                                                            for (int i = 0; i < jobIds.size(); i++) {
                                                                int Id = jobIds.get(i);
                                                                Job tempJob = JobDAO.retrieveJobByJobId(Id);
                                                                String jobEmp = tempJob.getEmployerName();
                                                                if (Id == latestJob.getJobKey()) {
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
                                                 <div class="form-group col-sm-15 text-right">
                                                    <button type='submit' onclick="" class="btn btn-blue  col-md-1">Submit</button>
                                                    <button type='button' data-title="Add New Job" data-action="add" data-value="job" class="btn btn-blue profile_details  pull-right">Add New Job</button>
                                                 </div>
                                            </div>
                                        </form>
                                        <!--need to change the vlaue of job id when the user change the dropdown value-->
                                    </div>


                                    <br/>


                                    <!--job complements here-->
                                    <div class="row">

                                        <!--Pass Details-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">


                                                <h4 class="panel-title">Currently Held Pass
                                                    <a style="color: black" data-class="job"  data-value='passdetails' data-passdetails='' href="" data-title="Add A New Pass Details" data-toggle="modal" data-target="#passdetails_pop_up" data-action="add" class="view_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> jobPassDetailsIds = JobComplementsDAO.retrievePassDetailsIdsOfJob(latestJob);
                                                    if (jobPassDetailsIds != null && !jobPassDetailsIds.isEmpty()) {

                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class="tbl-20-col">Pass type</th>
                                                        <th class="tbl-20-col">Pass number</th>
                                                        <th class="tbl-20-col">Issue date</th>
                                                        <th class="tbl-20-col">Expiry date</th>
                                                        <th class="tbl-20-col">Action</th>
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

                                                        <td class="tbl-20-col"><a style="color: black" data-class="job"  data-value="passdetails" data-passdetails="<%=tempPass.getId()%>" 
                                                                                  data-title="View Pass Details" href="" data-toggle="modal" data-action="viewedit" 
                                                                                  data-target="#passdetails_pop_up" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span></a>
                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-class="job"  data-value="passdetails" data-passdetails="<%=tempPass.getId()%>" 
                                                               href="" data-toggle="modal" data-action="delete" 
                                                               data-target="#passdetails_pop_up" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span></a>
                                                                <% }%>
                                                        </td>
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>
                                                        <td><%=passType%></td>
                                                        <td><%=passNo%></td>
                                                        <td><%=(isDate == null) ? "-" : sdf.format(isDate)%></td>
                                                        <td><%=(exDate == null) ? "-" : sdf.format(exDate)%></td>
                                                        <td class="tbl-20-col"><a style="color: black" data-class="job"  data-value="passdetails" data-passdetails="<%=tempPass.getId()%>" 
                                                                                  data-title="View Pass Details" href="" data-toggle="modal" data-action="viewedit" 
                                                                                  data-target="#passdetails_pop_up" class="edit_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-class="job"  data-value="passdetails" data-passdetails="<%=tempPass.getId()%>" 
                                                               href="" data-toggle="modal" data-action="delete" 
                                                               data-target="#passdetails_pop_up" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span></a>
                                                                <% }%>  
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                                <%
                                                    if (jobPassDetailsIds.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_jobpass_seemore" onclick="seemore('.other_jobpass');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_jobpass_seemore" onclick="seemore('.other_jobpass');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--IPA Details-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">IPA
                                                    <a style="color: black" data-value='ipa' data-ipa='' href="" data-toggle="modal" data-class="job" data-title="Add IPA details" data-target="#ipa_pop_up" data-action="add" class="view_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> ipaIdList = JobComplementsDAO.retrieveIPADetailsIdsOfJob(latestJob);
                                                    if (ipaIdList != null && !ipaIdList.isEmpty()) {

                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class="tbl-20-col">Specified workpass</th>
                                                        <th class="tbl-20-col">Applic date</th>
                                                        <th class="tbl-20-col">Employer</th>
                                                        <th class="tbl-20-col">Basic sal</th>
                                                        <th class="tbl-20-col">Action</th>
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
                                                        <td><%=(salary == 0.0) ? "" : df.format(salary)%></td>
                                                        <td>
                                                            <a style="color: black" data-value='ipa' data-ipa='<%=ipa.getId()%>' data-title="View IPA details"
                                                               data-class="job"   href="" data-toggle="modal" data-target="#ipa_pop_up" 
                                                               data-action="viewedit" class="view_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='ipa' data-ipa='<%=ipa.getId()%>'
                                                               data-class="job"   href="" data-toggle="modal" data-target="#ipa_pop_up" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>   
                                                        </td>
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>
                                                        <td><%=ipaPass%></td>
                                                        <td><%=(ipaAppDate == null) ? "-" : sdf.format(ipaAppDate)%></td>
                                                        <td><%=empName%></td>
                                                        <td><%=(salary == 0.0) ? "" : df.format(salary)%></td>
                                                        <td>
                                                            <a style="color: black" data-value='ipa' data-ipa='<%=ipa.getId()%>' data-title="View IPA details"
                                                               data-class="job"   href="" data-toggle="modal" data-target="#ipa_pop_up" 
                                                               data-action="viewedit" class="view_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='ipa' data-ipa='<%=ipa.getId()%>'
                                                               data-class="job"   href="" data-toggle="modal" data-target="#ipa_pop_up" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>   
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

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_ipa_seemore" onclick="seemore('.other_ipa');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_ipa_seemore" onclick="seemore('.other_ipa');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Verbal Assurance of Previous Job-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Verbal assurances pre-Job
                                                    <a style="color: black" data-value='assurance' data-assurance='' href=""  data-class="job" data-title="Add A New Verbal Assurance" data-toggle="modal" data-target="#assurance_pop_up" data-action="add" class="view_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> verbalIdsList = JobComplementsDAO.retrieveVerbalAssuranceOfJob(latestJob);
                                                    if (verbalIdsList != null && !verbalIdsList.isEmpty()) {

                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class="tbl-20-col">Who promised</th>
                                                        <th class="tbl-20-col">How related</th>
                                                        <th class="tbl-20-col">When promised</th>
                                                        <th class="tbl-20-col">Where promised</th>
                                                        <th class="tbl-20-col">Action</th>
                                                    </tr>

                                                    <%
                                                        for (int i = verbalIdsList.size() - 1; i >= 0; i--) {
                                                            JobVerbalAssurance assurance = JobComplementsDAO.retrieveVerbalAssuranceDetailsById(verbalIdsList.get(i));

                                                            String verbalName = assurance.getVerbalName();
                                                            String verbalRelation = assurance.getVerbalRelationship();

                                                            if (verbalRelation.length() > 60) {
                                                                verbalRelation = verbalRelation.substring(0, 60) + "...";
                                                            }
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
                                                            <a style="color: black" data-value='assurance' data-assurance='<%=assurance.getId()%>'  data-class="job" data-title="View Verbal Assurance Details"
                                                               href="" data-toggle="modal" data-target="#assurance_pop_up" data-action="viewedit" 
                                                               class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='assurance' data-assurance='<%=assurance.getId()%>'  data-class="job"
                                                               href="" data-toggle="modal" data-target="#assurance_pop_up" data-action="delete" 
                                                               class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>   
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
                                                            <a style="color: black" data-value='assurance' data-assurance='<%=assurance.getId()%>'  data-class="job" data-title="View Verbal Assurance Details"
                                                               href="" data-toggle="modal" data-target="#assurance_pop_up" data-action="viewedit" 
                                                               class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='assurance' data-assurance='<%=assurance.getId()%>'  data-class="job"
                                                               href="" data-toggle="modal" data-target="#assurance_pop_up" data-action="delete" 
                                                               class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
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

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_va_seemore" onclick="seemore('.other_va');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_va_seemore" onclick="seemore('.other_va');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Employment Contract-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Employment Contract
                                                    <a style="color: black"  data-class="job" data-value='empcontract' data-empcontract='' data-title="Add A New Employment Contract" href="" data-toggle="modal" data-target="#empcontract_pop_up" data-action="add" class="view_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> empContractIdsList = JobComplementsDAO.retrieveEmploymentContractIdsOfJob(latestJob);
                                                    if (empContractIdsList != null && !empContractIdsList.isEmpty()) {

                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class="tbl-20-col">Contract date</th>
                                                        <th class="tbl-20-col">Where signed</th>
                                                        <th class="tbl-20-col">Opposite party</th>
                                                        <th class="tbl-20-col">Basic sal</th>
                                                        <th class="tbl-20-col">Action</th>
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

                                                        <td><%=(contraDate == null) ? "-" : sdf.format(contraDate)%></td>
                                                        <td><%=contraWhere%></td>
                                                        <td><%=contraName%></td>
                                                        <td><%=contraSalary%></td>

                                                        <td class="tbl-20-col"><a style="color: black"  data-class="job" data-value='empcontract' data-title="View Employment Contract Details"
                                                                                  data-empcontract='<%=empContract.getId()%>' href="" 
                                                                                  data-toggle="modal" data-target="#empcontract_pop_up" 
                                                                                  data-action="viewedit" class="view_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span></a>
                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black"  data-class="job" data-value='empcontract'
                                                               data-empcontract='<%=empContract.getId()%>' href="" 
                                                               data-toggle="modal" data-target="#empcontract_pop_up" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span></a>
                                                                <% }%> 
                                                        </td>
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>

                                                        <td><%=(contraDate == null) ? "-" : sdf.format(contraDate)%></td>
                                                        <td><%=contraWhere%></td>
                                                        <td><%=contraName%></td>
                                                        <td><%=contraSalary%></td>

                                                        <td>
                                                            <a style="color: black"  data-class="job" data-value='empcontract' data-title="View Employment Contract Details"
                                                               data-empcontract='<%=empContract.getId()%>' 
                                                               href="" data-toggle="modal" data-target="#empcontract_pop_up" 
                                                               data-action="viewedit" class="view_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black"  data-class="job" data-value='empcontract'
                                                               data-empcontract='<%=empContract.getId()%>' href="" 
                                                               data-toggle="modal" data-target="#empcontract_pop_up" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span></a>
                                                                <% }%>    
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

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_contract_seemore" onclick="seemore('.other_contract');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_contract_seemore" onclick="seemore('.other_contract');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Intermediary Agent-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Intermediary Agent
                                                    <a style="color: black" data-value='agent' data-agent='' href="" data-toggle="modal" data-class="job" data-title="Add A New Intermediary Agent"  data-target="#agent_pop_up" data-action="add" class="view_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> agentIdsList = JobComplementsDAO.retrieveJobIntermediaryAgentIdsOfJob(latestJob);
                                                    if (agentIdsList != null && !agentIdsList.isEmpty()) {


                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class="tbl-20-col">Agency name</th>
                                                        <th class="tbl-20-col">Key person name</th>
                                                        <th class="tbl-20-col">S$ paid</th>
                                                        <th class="tbl-20-col">Where paid</th>
                                                        <th class="tbl-20-col">Action</th>
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
                                                        <td><%=(agentPaidAmt == 0.0) ? "" : df.format(agentPaidAmt)%></td>
                                                        <td><%=agentFWhere%></td>

                                                        <td>
                                                            <a style="color: black" data-value='agent' data-agent='<%=agent.getID()%>'  data-class="job" data-title="View Intermediary Agent"
                                                               href="" data-toggle="modal" data-target="#agent_pop_up" data-action="viewedit" 
                                                               class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='agent' data-agent='<%=agent.getID()%>'  data-class="job"
                                                               href="" data-toggle="modal" data-target="#agent_pop_up" data-action="delete" 
                                                               class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
                                                        </td>
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>
                                                        <td><%=agentName%></td>
                                                        <td><%=agentPName%></td>
                                                        <td><%=(agentPaidAmt == 0.0) ? "" : df.format(agentPaidAmt)%></td>
                                                        <td><%=agentFWhere%></td>

                                                        <td>
                                                            <a style="color: black" data-value='agent' data-agent='<%=agent.getID()%>'  data-class="job" data-title="View Intermediary Agent"
                                                               href="" data-toggle="modal" data-target="#agent_pop_up" data-action="viewedit" 
                                                               class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='agent' data-agent='<%=agent.getID()%>'  data-class="job"
                                                               href="" data-toggle="modal" data-target="#agent_pop_up" data-action="delete" 
                                                               class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
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

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_agent_seemore" onclick="seemore('.other_agent');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_agent_seemore" onclick="seemore('.other_agent');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Employer Details-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Employer details
                                                    <a style="color: black" data-class="job"  data-value='empdetails' data-empdetails='' href="" data-title="Add A New Employer" data-toggle="modal" data-target="#empdetails_pop_up" data-action="add" class="view_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> empIdsList = JobComplementsDAO.retrieveJobEmployerIdsOfJob(latestJob);
                                                    if (empIdsList != null && !empIdsList.isEmpty()) {

                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class="tbl-20-col">Employer name</th>
                                                        <th class="tbl-20-col">Employer ID</th>
                                                        <th class="tbl-20-col">Phone/email</th>
                                                        <th class="tbl-20-col">Key persons</th>
                                                        <th class="tbl-20-col">Action</th>
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
                                                        <td class="tbl-20-col"><a style="color: black"  data-class="job" data-value='empdetails' data-empdetails='<%=jobEmp.getId()%>' 
                                                                                  data-title="View Employer Details" href="" data-toggle="modal" data-target="#empdetails_pop_up" 
                                                                                  data-action="viewedit" class="view_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span></a>
                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black"  data-class="job" data-value='empdetails' data-empdetails='<%=jobEmp.getId()%>' 
                                                               href="" data-toggle="modal" data-target="#empdetails_pop_up" 
                                                               data-action="delete" class="view_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span></a>
                                                                <% }%> 
                                                        </td>
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>
                                                        <td><%=empName%></td>
                                                        <td><%=empId%></td>
                                                        <td><%=empContact%></td>
                                                        <td><%=empKeyPerson%></td>
                                                        <td class="tbl-20-col"><a style="color: black"  data-class="job" data-value='empdetails' data-empdetails='<%=jobEmp.getId()%>' 
                                                                                  data-title="View Employer Details" href="" data-toggle="modal" data-target="#empdetails_pop_up" 
                                                                                  data-action="viewedit" class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black"  data-class="job" data-value='empdetails' data-empdetails='<%=jobEmp.getId()%>' 
                                                               href="" data-toggle="modal" data-target="#empdetails_pop_up" 
                                                               data-action="delete" class="view_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span></a>
                                                                <% }%> 
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                                <%
                                                    if (empIdsList.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_employer_seemore" onclick="seemore('.other_employer');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_employer_seemore" onclick="seemore('.other_employer');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Work Place Details-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Workplace
                                                    <a style="color: black" data-value='wplace' data-wplace='' href="" data-toggle="modal"  data-class="job" data-title="Add A New Workplace" data-target="#wplace_pop_up" data-action="add" class="view_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> workPlaceIdsList = JobComplementsDAO.retrieveJobWorkplaceIdsOfJob(latestJob);
                                                    if (workPlaceIdsList != null && !workPlaceIdsList.isEmpty()) {

                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class="tbl-20-col">Workplace type</th>
                                                        <th class="tbl-20-col">Employer controlled</th>
                                                        <th class="tbl-20-col">When start here</th>
                                                        <th class="tbl-20-col">When cease here</th>
                                                        <th class="tbl-20-col">Action</th>
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
                                                            <a style="color: black" data-value='wplace' data-wplace='<%=workPlace.getId()%>' data-class="job" 
                                                               data-title="View Workplace Details" href="" data-toggle="modal" data-target="#wplace_pop_up" 
                                                               data-action="viewedit" class="view_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='wplace' data-wplace='<%=workPlace.getId()%>' data-class="job" 
                                                               href="" data-toggle="modal" data-target="#wplace_pop_up" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>     
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
                                                            <a style="color: black" data-value='wplace' data-wplace='<%=workPlace.getId()%>' data-class="job" 
                                                               data-title="View Workplace Details" href="" data-toggle="modal" data-target="#wplace_pop_up" 
                                                               data-action="viewedit" class="view_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='wplace' data-wplace='<%=workPlace.getId()%>' data-class="job" 
                                                               href="" data-toggle="modal" data-target="#wplace_pop_up" 
                                                               data-action="delete" class="delete_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>     
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

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_workplace_seemore" onclick="seemore('.other_workplace');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_workplace_seemore" onclick="seemore('.other_workplace');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Work History-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Work History
                                                    <a style="color: black" data-value='whistory' data-whistory='' href="" data-toggle="modal" data-title="Add A New Work History" data-class="job"  data-target="#whistory_pop_up" data-action="add" class="view_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> historyIdsList = JobComplementsDAO.retrieveJobWorkHistoryIdsOfJob(latestJob);
                                                    if (historyIdsList != null && !historyIdsList.isEmpty()) {

                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class="tbl-20-col">How found this job</th>
                                                        <th class="tbl-20-col">Date arrived Sg</th>
                                                        <th class="tbl-20-col">This first job here?</th>
                                                        <th class="tbl-20-col">First came to Sg</th>
                                                        <th class="tbl-20-col">Action</th>
                                                    </tr>

                                                    <%
                                                        for (int i = historyIdsList.size() - 1; i >= 0; i--) {
                                                            JobWorkHistory history = JobComplementsDAO.retrieveJobWorkHistoryById(historyIdsList.get(i));

                                                            String historyHow = history.getWorkHistHow();
                                                            String historyArrDate = history.getWorkHistDate();
                                                            String historyFirstJob = history.getWorkHistFirst();
                                                            String historyArrYear = history.getWorkHistYearArrive();
                                                            if (i < historyIdsList.size() - 1) {
                                                    %>
                                                    <tr class="other_workhistory moreObjs">
                                                        <td><%=historyHow%></td>
                                                        <td><%=(historyArrDate == null) ? "-" : historyArrDate%></td>                        
                                                        <td><%=historyFirstJob%></td>
                                                        <td><%=historyArrYear%></td>

                                                        <td class="tbl-20-col"><a style="color: black" data-value='whistory' data-whistory='<%=history.getId()%>' 
                                                                                  href="" data-title="View Work History Details" data-toggle="modal" 
                                                                                  data-class="job" data-target="#whistory_pop_up" data-action="viewedit" 
                                                                                  class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span></a>
                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='whistory' data-whistory='<%=history.getId()%>' 
                                                               href="" data-toggle="modal" 
                                                               data-class="job" data-target="#whistory_pop_up" data-action="delete" 
                                                               class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span></a>
                                                                <% }%>    
                                                        </td>
                                                    </tr>
                                                    <%
                                                    } else {
                                                    %>
                                                    <tr>
                                                        <td><%=historyHow%></td>
                                                        <td><%=(historyArrDate == null) ? "-" : historyArrDate%></td>                                       
                                                        <td><%=historyFirstJob%></td>
                                                        <td><%=historyArrYear%></td>

                                                        <td class="tbl-20-col"><a style="color: black" data-value='whistory' data-whistory='<%=history.getId()%>' href="" 
                                                                                  data-title="View Work History Details" data-toggle="modal"  data-class="job" 
                                                                                  data-target="#whistory_pop_up" data-action="viewedit" class="view_btn pop_up_open">
                                                                <span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='whistory' data-whistory='<%=history.getId()%>' 
                                                               href="" data-toggle="modal" 
                                                               data-class="job" data-target="#whistory_pop_up" data-action="delete" 
                                                               class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span></a>
                                                                <% }%>    
                                                        </td>
                                                    </tr>
                                                    <%
                                                            }
                                                        }
                                                    %>
                                                </table>
                                                <%
                                                    if (historyIdsList.size() > 1) {
                                                %>

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_workhistory_seemore" onclick="seemore('.other_workhistory');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_workhistory_seemore" onclick="seemore('.other_workhistory');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                        <!--Accommodation During Work-->
                                        <div class="panel panel-default">

                                            <div class="panel-heading">

                                                <h4 class="panel-title">Accommodation During Work
                                                    <a style="color: black" data-value='waccom' data-waccom='' href="" data-toggle="modal" data-title="Add A New Accommodation" data-class="job" data-target="#waccom_pop_up" data-action="add" class="view_btn pop_up_open">
                                                        <span class="glyphicon glyphicon-plus pull-right" pull-right></span></a></h4>
                                            </div>

                                            <div class="panel-body ">
                                                <%
                                                    ArrayList<Integer> accomodoIdsList = JobComplementsDAO.retrieveJobAccomodationIdsOfJob(latestJob);
                                                    if (accomodoIdsList != null && !accomodoIdsList.isEmpty()) {

                                                %>

                                                <table class="table table-condensed">
                                                    <tr>
                                                        <th class="tbl-20-col">Employer provide?</th>
                                                        <th class="tbl-20-col">Type</th>
                                                        <th class="tbl-20-col">Location</th>
                                                        <th class="tbl-20-col">When ended</th>
                                                        <th class="tbl-20-col">Action</th>
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

                                                        <td class="tbl-20-col"><a style="color: black" data-value='waccom' data-waccom='<%=accomodation.getId()%>'  data-class="job"  href="" data-toggle="modal" data-target="#waccom_pop_up" data-action="viewedit" data-title="View Accommodation Details"
                                                                                  class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='waccom' data-waccom='<%=accomodation.getId()%>'  data-class="job"  href="" 
                                                               data-toggle="modal" data-target="#waccom_pop_up" data-action="delete" 
                                                               class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
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

                                                        <td class="tbl-20-col"><a style="color: black" data-value='waccom' data-waccom='<%=accomodation.getId()%>' data-title="View Accommodation Details" data-class="job"  href="" data-toggle="modal" data-target="#waccom_pop_up" data-action="viewedit" 
                                                                                  class="view_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                            </a>
                                                            <% if (userLogin.getRole().equals("Administrator")) {%>
                                                            &nbsp;&nbsp;&nbsp;
                                                            <a style="color: black" data-value='waccom' data-waccom='<%=accomodation.getId()%>'  data-class="job"  href="" 
                                                               data-toggle="modal" data-target="#waccom_pop_up" data-action="delete" 
                                                               class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                            </a>
                                                            <% }%>    
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

                                                <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_accom_seemore" onclick="seemore('.other_accom');">See more</a>
                                                <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_accom_seemore" onclick="seemore('.other_accom');">View Less</a>
                                                <%                                                            }
                                                    }
                                                %>
                                            </div>
                                        </div>

                                    </div>
                                </div>

                                <!----Problem Complement Tab-->             
                                <div class="tab-pane " id="problem_complement" >
                                    <br/>
                                    <!-- Problem Complement Success & Error Display -->

                                    <% if (successProbMsg != null) {
                                            if (!successProbMsg.equals("")) {%>

                                    <div class="alert alert-info" role="alert">
                                        <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                        <%=successProbMsg%>
                                    </div>

                                    <% }
                                        }%>
                                    <% if (errorProbMsg != null) {
                                            if (!errorProbMsg.equals("")) {%>

                                    <div class="alert alert-danger" role="alert">
                                        <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                        <%=errorProbMsg%>
                                    </div>

                                    <% }
                                        }%>
                                    <!-- End of Problem Complement Success & Error Display -->

                                    <div class="row">
                                        <form method="POST" action='changeToSelected'>
                                            <div class="form-group col-md-12">
                                                <label for="probSelected" class="col-md-1 control-label">Select Problem:</label>
                                                <div class="col-md-4">
                                                    <input type="hidden" name="workerFin" value="<%=workerFin%>"/>
                                                    <input type="hidden" name="selectedType" value="problem"/>
                                                    <input type="hidden" name="jobKey" value="<%=latestJob.getJobKey()%>"/>
                                                    <input type="hidden" name="problemKey" value="<%=latestProblem.getProbKey()%>"/>
                                                    <select class="form-control " id="problemSelected" name="selectedProblem" required>
                                                        <%
                                                            for (int i = problemIds.size() - 1; i >= 0; i--) {
                                                                int Id = problemIds.get(i);
                                                                Problem tempProb = ProblemDAO.retrieveProblemByProblemId(Id);
                                                                String problemType = tempProb.getProblem();
                                                                java.util.Date tempDate = tempProb.getProblemRegisteredDate();

                                                                if (Id == latestProblem.getProbKey()) {
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
                                                <div class="form-group col-sm-15 text-right">
                                                    <button type='submit' onclick="" class="btn btn-blue changebtn">Submit</button>
                                                    <button type='button' onclick="referCase();" data-title="Case Referral" class="btn btn-blue changebtn" id="refer_case_btn">Refer Case</button>                                           
                                                    <button type='button' data-title="Add New Problem" data-action="add" data-value="problem" class="btn btn-blue profile_details">Add New Problem</button>
                                                </div>
                                           </div>            
                                        </form>
                                        <!--need to change the vlaue of job id when the user change the dropdown value-->
                                    </div>
                                    <div class='row'>
                                        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                                            <div class="panel panel-default">

                                                <!--common problem complements-->
                                                <div class="panel accordion_panel">
                                                    <div class="panel-heading accordion_panel_heading" role="tab" id="headingOne" style="border-bottom: 1px solid;">
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
                                                                        <a href="" id="issueAddBtn" data-toggle="modal" data-target="#aggravIssue_pop_up" data-title="Add A New Aggravating Issue" data-class="problem"  data-action = "add" data-value='aggravissue' data-aggravissue='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> aggravissueIds = ProblemComplementsDAO.retrieveAggravatingIssueIdsOfProblem(latestProblem);

                                                                        if (aggravissueIds != null && !aggravissueIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th class="tbl-20-col">Aggrav issue</th>
                                                                            <th class="tbl-20-col">Explain if other</th>
                                                                            <th class="tbl-20-col">Loss value</th>
                                                                            <th class="tbl-20-col">Remarks</th>
                                                                            <th class="tbl-20-col">Action</th>
                                                                        </tr>

                                                                        <%
                                                                            for (int i = aggravissueIds.size() - 1; i >= 0; i--) {
                                                                                ProblemAggravatingIssue aggravIs = ProblemComplementsDAO.retrieveProblemAggravatingIssueById(aggravissueIds.get(i));

                                                                                String issue = aggravIs.getAggravatingIssue();
                                                                                String issueMore = aggravIs.getAggravatingIssueMore();
                                                                                if (issueMore.length() > 60) {
                                                                                    issueMore = issueMore.substring(0, 60) + "...";
                                                                                }

                                                                                String remark = aggravIs.getAggravatingRemark();
                                                                                if (remark.length() > 60) {
                                                                                    remark = remark.substring(0, 60) + "...";
                                                                                }
                                                                                double loss = aggravIs.getAggravatingLoss();
                                                                                if (i < aggravissueIds.size() - 1) {
                                                                        %>
                                                                        <tr class="other_aggravissue moreObjs">
                                                                            <td><%=issue%></td>
                                                                            <td><%=(issueMore == null) ? "" : issueMore%></td>
                                                                            <td><%=(loss == 0) ? "" : df.format(loss)%></td>
                                                                            <td><%=remark%></td>
                                                                            <td>
                                                                                <a style="color: black" data-value='aggravissue' data-class="problem" data-title="View Aggravating Issue Details" 
                                                                                   data-aggravissue='<%=aggravIs.getId()%>' href="#" data-toggle="modal" data-action="viewedit" 
                                                                                   data-target="#aggravIssue_pop_up" class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-value='aggravissue' data-class="problem"
                                                                                   data-aggravissue='<%=aggravIs.getId()%>' href="#" data-toggle="modal" data-action="delete" 
                                                                                   data-target="#aggravIssue_pop_up" class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>     
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=issue%></td>
                                                                            <td><%=(issueMore == null) ? "" : issueMore%></td>
                                                                            <td><%=(loss == 0) ? "" : df.format(loss)%></td>
                                                                            <td><%=remark%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-value='aggravissue' data-class="problem" data-title="View Aggravating Issue Details" 
                                                                                                      data-aggravissue='<%=aggravIs.getId()%>' href="" data-toggle="modal" data-action="viewedit" 
                                                                                                      data-target="#aggravIssue_pop_up"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-value='aggravissue' data-class="problem"
                                                                                   data-aggravissue='<%=aggravIs.getId()%>' href="#" data-toggle="modal" data-action="delete" 
                                                                                   data-target="#aggravIssue_pop_up" class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (aggravissueIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_aggravissue_seemore" onclick="seemore('.other_aggravissue');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_aggravissue_seemore" onclick="seemore('.other_aggravissue');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>


                                                            <!--Lead case worker-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Lead Case Worker
                                                                        <a href="" id="lcwAddBtn" data-toggle="modal" data-action = "add" data-title="Add New Lead Caseworker"  data-class="problem"  data-target="#leadcaseworker_pop_up" data-value='leadcaseworker' data-leadcaseworker='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> lcwIds = ProblemComplementsDAO.retrieveLeadCaseWorkerIdsOfProblem(latestProblem);

                                                                        if (lcwIds != null && !lcwIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>Lead name</th>
                                                                            <th>Start date</th>
                                                                            <th>End date</th>
                                                                            <th class="tbl-20-col">Action</th>
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
                                                                            <td><%=(start == null) ? "-" : sdf.format(start)%></td>
                                                                            <td><%=(end == null) ? "-" : sdf.format(end)%></td>

                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#leadcaseworker_pop_up"  data-class="problem"  
                                                                                                      data-value='leadcaseworker' data-leadcaseworker='<%=icwid%>' href="" 
                                                                                                      data-toggle="modal" data-action="viewedit" data-title="View Lead Caseworker" class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#leadcaseworker_pop_up"  data-class="problem"  
                                                                                   data-value='leadcaseworker' data-leadcaseworker='<%=icwid%>' href="" 
                                                                                   data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=name%></td>
                                                                            <td><%=(start == null) ? "-" : sdf.format(start)%></td>
                                                                            <td><%=(end == null) ? "-" : sdf.format(end)%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#leadcaseworker_pop_up"  data-class="problem"  
                                                                                                      data-value='leadcaseworker' data-leadcaseworker='<%=icwid%>' href="" data-toggle="modal" 
                                                                                                      data-action="viewedit"  data-title="View Lead Caseworker" class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span></a>
                                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#leadcaseworker_pop_up"  data-class="problem"  
                                                                                   data-value='leadcaseworker' data-leadcaseworker='<%=icwid%>' href="" 
                                                                                   data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>     
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (lcwIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_leadcaseworker_seemore" onclick="seemore('.other_leadcaseworker');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_leadcaseworker_seemore" onclick="seemore('.other_leadcaseworker');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                            <!--Auxiliary Worker-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Auxiliary Case Worker
                                                                        <a href="" id="auxcaseAddBtn" data-toggle="modal"  data-class="problem" data-title="Add A New Auxiliary Caseworker"
                                                                           data-target="#auxcaseworker_pop_up" data-action = "add" data-value='auxcaseworker' 
                                                                           data-auxcaseworker='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> auxCWIds = ProblemComplementsDAO.retrieveProblemAuxiliaryCaseWorkerIdsOfProblem(latestProblem);

                                                                        if (auxCWIds != null && !auxCWIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">

                                                                        <tr>
                                                                            <th>Auxiliary name</th>
                                                                            <th>Start date</th>
                                                                            <th>End date</th>
                                                                            <th class="tbl-20-col">Action</th>
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
                                                                            <td><%=(start == null) ? "-" : sdf.format(start)%></td>
                                                                            <td><%=(end == null) ? "-" : sdf.format(end)%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-value='auxcaseworker' data-class="problem"  
                                                                                                      data-title="View Auxiliary Caseworker Details" data-auxcaseworker='<%=auxid%>' 
                                                                                                      href="" data-toggle="modal" data-action="viewedit" data-target="#auxcaseworker_pop_up"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-value='auxcaseworker' data-class="problem"  
                                                                                   data-auxcaseworker='<%=auxid%>' 
                                                                                   href="" data-toggle="modal" data-action="delete" data-target="#auxcaseworker_pop_up"  
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>   
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=name%></td>
                                                                            <td><%=(start == null) ? "-" : sdf.format(start)%></td>
                                                                            <td><%=(end == null) ? "-" : sdf.format(end)%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-value='auxcaseworker' data-class="problem" data-title="View Auxiliary Caseworker Details"  
                                                                                                      data-auxcaseworker='<%=auxid%>' href="" data-toggle="modal" data-action="viewedit" data-target="#auxcaseworker_pop_up"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-value='auxcaseworker' data-class="problem"  
                                                                                   data-auxcaseworker='<%=auxid%>' 
                                                                                   href="" data-toggle="modal" data-action="delete" data-target="#auxcaseworker_pop_up"  
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (auxCWIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_auxCaseworker_seemore" onclick="seemore('.other_auxCaseworker');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_auxCaseworker_seemore" onclick="seemore('.other_auxCaseworker');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                            <!--Case Discussion-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Case Discussion
                                                                        <a href="" id="casediscussionAddBtn" data-toggle="modal" data-class="problem"  data-title="Add A New Case Discussion" data-target="#casediscussion_pop_up" data-action = "add" data-value='casediscussion' data-casediscussion='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> caseDiscussIds = ProblemComplementsDAO.retrieveCaseDiscussionIdsOfProblem(latestProblem);

                                                                        if (caseDiscussIds != null && !caseDiscussIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th class='tbl-20-col'>Event date</th>
                                                                            <th class='tbl-20-col'>Where or how</th>
                                                                            <th class='tbl-20-col'>TWC2 person</th>
                                                                            <th class='tbl-20-col'>Topic</th>
                                                                            <th class="tbl-20-col">Action</th>
                                                                        </tr>

                                                                        <%
                                                                            for (int i = caseDiscussIds.size() - 1; i >= 0; i--) {
                                                                                int id = caseDiscussIds.get(i);
                                                                                ProblemCaseDiscussion caseDiscussion = ProblemComplementsDAO.retrieveProblemCaseDiscussionById(id);

                                                                                java.util.Date discussionDate = caseDiscussion.getCaseDiscussionDate();
                                                                                String mode = caseDiscussion.getCaseDiscussionWhere();
                                                                                String consultant = caseDiscussion.getCaseDiscussionTWC2Person1();
                                                                                String topic = caseDiscussion.getCaseDiscussionTopic();
                                                                                if (topic.length() > 60) {
                                                                                    topic = topic.substring(0, 60) + "...";
                                                                                }
                                                                                String location = caseDiscussion.getCaseDiscussionWhere();
                                                                                if (location.equals("other") || location.equals("Other") || location == null) {
                                                                                    location = caseDiscussion.getCaseDiscussionWhereMore();
                                                                                }

                                                                                if (i < caseDiscussIds.size() - 1) {
                                                                        %>
                                                                        <tr class="other_casediscuss moreObjs">
                                                                            <td><%=(discussionDate == null) ? "-" : sdf.format(discussionDate)%></td>
                                                                            <td><%=mode%></td>
                                                                            <td><%=consultant%></td>
                                                                            <td><%=topic%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-value='casediscussion' data-class="problem"  data-title="View Case Discussion Details" 
                                                                                                      data-casediscussion='<%=id%>' href="" data-toggle="modal" data-action="viewedit" 
                                                                                                      data-target="#casediscussion_pop_up"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-value='casediscussion' data-class="problem"
                                                                                   data-casediscussion='<%=id%>' href="" data-toggle="modal" data-action="delete" 
                                                                                   data-target="#casediscussion_pop_up"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {

                                                                        %>
                                                                        <tr>
                                                                            <td><%=(discussionDate == null) ? "-" : sdf.format(discussionDate)%></td>
                                                                            <td><%=mode%></td>
                                                                            <td><%=consultant%></td>
                                                                            <td class='tbl-20-col'><%=topic%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-value='casediscussion' data-class="problem" 
                                                                                                      data-title="View Case Discussion Details"  data-casediscussion='<%=id%>'
                                                                                                      href="" data-toggle="modal" data-action="viewedit" data-target="#casediscussion_pop_up"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-value='casediscussion' data-class="problem"
                                                                                   data-casediscussion='<%=id%>' href="" data-toggle="modal" data-action="delete" 
                                                                                   data-target="#casediscussion_pop_up"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (caseDiscussIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_casediscuss_seemore" onclick="seemore('.other_casediscuss');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_casediscuss_seemore" onclick="seemore('.other_casediscuss');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                            <!--Lawyer-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Lawyer
                                                                        <a href="" id="lawyerAddBtn" data-toggle="modal" data-target="#lawyer_pop_up" data-title="Add A New Law firm Status" data-class="problem"   data-action = "add" data-value='lawyer' data-lawyer='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> lawyerIds = ProblemComplementsDAO.retrieveProblemLawyerIdsOfProblem(latestProblem);

                                                                        if (lawyerIds != null && !lawyerIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>Update date</th>
                                                                            <th>Law firm</th>
                                                                            <th class="tbl-25-col">Lawyer/asst name</th>
                                                                            <th class="tbl-20-col">Action</th>
                                                                        </tr>

                                                                        <%
                                                                            for (int i = lawyerIds.size() - 1; i >= 0; i--) {
                                                                                int id = lawyerIds.get(i);

                                                                                ProblemLawyer lawyer = ProblemComplementsDAO.retrieveProblemLawyerById(id);

                                                                                String lawFirm = lawyer.getLawyerFirm();
                                                                                java.util.Date updateDate = lawyer.getLawyerUpdate();
                                                                                String lawyerName = lawyer.getLawyerName();

                                                                                if (lawyerName.length() > 60) {
                                                                                    lawyerName = lawyerName.substring(0, 60) + "...";
                                                                                }
                                                                                if (i < lawyerIds.size() - 1) {

                                                                        %>
                                                                        <tr class="other_lawyer moreObjs">
                                                                            <td><%=(updateDate == null) ? "-" : sdf.format(updateDate)%></td>
                                                                            <td><%=lawFirm%></td>
                                                                            <td><%=lawyerName%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-value='lawyer' data-lawyer='<%=id%>' data-title="View Law firm Status"
                                                                                                      data-class="problem"   href="" data-toggle="modal" data-action="viewedit" 
                                                                                                      data-target="#lawyer_pop_up"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-value='lawyer' data-lawyer='<%=id%>'
                                                                                   data-class="problem"   href="" data-toggle="modal" data-action="delete" 
                                                                                   data-target="#lawyer_pop_up"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>   
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(updateDate == null) ? "-" : sdf.format(updateDate)%></td>
                                                                            <td><%=lawFirm%></td>
                                                                            <td><%=lawyerName%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-value='lawyer' data-lawyer='<%=id%>' data-class="problem" 
                                                                                                      data-title="View Law firm Status"  href="" data-toggle="modal" data-action="viewedit" 
                                                                                                      data-target="#lawyer_pop_up"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-value="lawyer" data-lawyer="<%=id%>"
                                                                                   data-class="problem"   href="" data-toggle="modal" data-action="delete" 
                                                                                   data-target="#lawyer_pop_up"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>   
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>

                                                                    <%
                                                                        if (lawyerIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_lawyer_seemore" onclick="seemore('.other_lawyer');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_lawyer_seemore" onclick="seemore('.other_lawyer');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <!--salary complements-->
                                                <div class="panel accordion_panel">
                                                    <div class="panel-heading accordion_panel_heading" role="tab" id="headingTwo" style="border-bottom: 1px solid; border-top: 2px solid lightgray">
                                                        <h4 class="panel-title">
                                                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#salaryComps"  data-class="problem"  aria-expanded="true" aria-controls="collapseTwo">
                                                                Salary Complements
                                                            </a>
                                                        </h4>
                                                    </div>
                                                    <div id="salaryComps" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingTwo">
                                                        <div class="panel-body">

                                                            <!--salary related history-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Salary & Related History
                                                                        <a href="" id="salaryHistoryAddBtn" data-toggle="modal"  data-action = "add" data-class="problem" data-title="Add New Salary & Related History"  data-target="#salaryhistory_pop_up" data-value='salaryhistory' data-salaryhistory='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> salaryHistoryIds = ProblemComplementsDAO.retrieveProblemSalaryRelatedHistoryIdsOfProblem(latestProblem);

                                                                        if (salaryHistoryIds != null && !salaryHistoryIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th class='tbl-20-col'>Prob with basic sal</th>
                                                                            <th class='tbl-20-col'>Payment mode</th>
                                                                            <th class='tbl-20-col'>Total claim</th>
                                                                            <th class='tbl-20-col'>12 mths claim</th>
                                                                            <th class="tbl-20-col">Action</th>
                                                                        </tr>

                                                                        <%
                                                                            for (int i = salaryHistoryIds.size() - 1; i >= 0; i--) {
                                                                                int historyId = salaryHistoryIds.get(i);
                                                                                ProblemSalaryRelatedHistory salaryHistory = ProblemComplementsDAO.retrieveProblemSalaryRelatedHistoryById(historyId);

                                                                                String history = salaryHistory.getSalHistBasic();
                                                                                if(history.length() > 60){
                                                                                    history = history.substring(0, 60);
                                                                                }
                                                                                String mode = salaryHistory.getSalMode();
                                                                                double tClaim = salaryHistory.getSalLossTotal();
                                                                                double claim = salaryHistory.getSalLoss1Year();
                                                                                if (i < salaryHistoryIds.size() - 1) {
                                                                        %>
                                                                        <tr class="other_salaryhistory moreObjs">
                                                                            <td><%=history%></td>
                                                                            <td><%=mode%></td>
                                                                            <td><%=(tClaim == 0.0) ? "" : df.format(tClaim)%></td>
                                                                            <td><%=(claim == 0.0) ? "" : df.format(claim)%></td>
                                                                            <td>
                                                                                <a style="color: black" data-target="#salaryhistory_pop_up"  data-class="problem"  
                                                                                   data-value='salaryhistory' data-title="View Salary & Related History" 
                                                                                   data-salaryhistory='<%=historyId%>' href="" data-toggle="modal" data-action="viewedit" 
                                                                                   class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#salaryhistory_pop_up"  data-class="problem"  
                                                                                   data-value='salaryhistory' 
                                                                                   data-salaryhistory='<%=historyId%>' href="" data-toggle="modal" data-action="delete" 
                                                                                   class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>     
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=history%></td>
                                                                            <td><%=mode%></td>
                                                                            <td><%=(tClaim == 0.0) ? "" : df.format(tClaim)%></td>
                                                                            <td><%=(claim == 0.0) ? "" : df.format(claim)%></td>
                                                                            <td>
                                                                                <a style="color: black" data-target="#salaryhistory_pop_up"  data-class="problem"  
                                                                                   data-title="View Salary & Related History" data-value='salaryhistory' 
                                                                                   data-salaryhistory='<%=historyId%>' href="#" data-toggle="modal" data-action="viewedit"  
                                                                                   class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#salaryhistory_pop_up"  data-class="problem"  
                                                                                   data-value='salaryhistory' 
                                                                                   data-salaryhistory='<%=historyId%>' href="" data-toggle="modal" data-action="delete" 
                                                                                   class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
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

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_salaryhistory_seemore" onclick="seemore('.other_salaryhistory');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_salaryhistory_seemore" onclick="seemore('.other_salaryhistory');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                            <!--Salary Claim Lodged-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Salary Claim Lodged
                                                                        <a href="" id="salaryClaimAddBtn" data-toggle="modal" data-action = "add" data-class="problem" data-title="Add Salary Claim Lodged"  data-target="#salarycalim_pop_up" data-value='salarycalim' data-salarycalim='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        //ArrayList<Integer> salaryClaimIds = ProblemComplementsDAO.retrieveProblemSalaryRelatedHistoryIdsOfProblem(latestProblem);
                                                                        ArrayList<Integer> salaryClaimIds = ProblemComplementsDAO.retrieveSalaryClaimIdsOfProblem(latestProblem);
                                                                        if (salaryClaimIds != null && !salaryClaimIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>When lodged</th>
                                                                            <th>Claim value</th>

                                                                            <th class="tbl-20-col">Action</th>
                                                                        </tr>

                                                                        <%
                                                                            for (int i = salaryClaimIds.size() - 1; i >= 0; i--) {
                                                                                int salaryClaimId = salaryClaimIds.get(i);

                                                                                ProblemSalaryClaim salaryClaim = ProblemComplementsDAO.retrieveProblemSalaryClaimById(salaryClaimId);
                                                                                java.util.Date date = salaryClaim.getSalaryClaimDate();
                                                                                double loss = salaryClaim.getSalaryClaimLoss();
                                                                                //String basic = salaryClaim.getSalaryClaimBasis();
                                                                                if (i < salaryClaimIds.size() - 1) {
                                                                        %>
                                                                        <tr class="other_salaryClaim moreObjs">
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=(loss == 0.0) ? "" : df.format(loss)%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#salarycalim_pop_up" data-class="problem" 
                                                                                                      data-title="View Salary Claim Lodged Details"  data-value='salarycalim' 
                                                                                                      data-salarycalim='<%=salaryClaimId%>' href="" data-toggle="modal" 
                                                                                                      data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#salarycalim_pop_up" data-class="problem" 
                                                                                   data-value='salarycalim' 
                                                                                   data-salarycalim='<%=salaryClaimId%>' href="" data-toggle="modal" 
                                                                                   data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=(loss == 0.0) ? "" : df.format(loss)%></td>

                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#salarycalim_pop_up" data-class="problem" 
                                                                                                      data-title="View Salary Claim Lodged Details"  data-value='salarycalim' 
                                                                                                      data-salarycalim='<%=salaryClaimId%>' href="" data-toggle="modal" data-action="viewedit" 
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#salarycalim_pop_up" data-class="problem" 
                                                                                   data-value='salarycalim' 
                                                                                   data-salarycalim='<%=salaryClaimId%>' href="" data-toggle="modal" 
                                                                                   data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (salaryClaimIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_salaryClaim_seemore" onclick="seemore('.other_salaryClaim');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_salaryClaim_seemore" onclick="seemore('.other_salaryClaim');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                                <!--Medical Complements-->
                                                <div class="panel accordion_panel">
                                                    <div class="panel-heading accordion_panel_heading" role="tab" id="headingThree" style="border-bottom: 1px solid; border-top: 2px solid lightgray">
                                                        <h4 class="panel-title">
                                                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#medicalComps" data-class="problem"  aria-expanded="true" aria-controls="collapseThree">
                                                                Medical Complements
                                                            </a>
                                                        </h4>
                                                    </div>
                                                    <div id="medicalComps" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingThree">
                                                        <div class="panel-body">

                                                            <!--Injury History-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Injury History
                                                                        <a href="" id="injHistoryAddBtn" data-toggle="modal" data-action = "add" data-title="Add A New Injury History" data-class="problem"   data-target="#injurycase_pop_up" data-value='injurycase' data-injurycase='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> injuryIds = ProblemComplementsDAO.retrieveProblemInjuryIdsOfProblem(latestProblem);

                                                                        if (injuryIds != null && !injuryIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th class='tbl-20-col'>Injury date</th>
                                                                            <th class='tbl-20-col'>Location</th>
                                                                            <th class='tbl-20-col'>Body parts</th>
                                                                            <th class='tbl-20-col'>Initially treated at</th>
                                                                            <th class="tbl-20-col">Action</th>
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
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=location%></td>
                                                                            <td><%=bodyPart%></td>
                                                                            <td><%=treatment%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#injurycase_pop_up" data-class="problem" data-title="View Injury History Details" 
                                                                                                      data-value='injurycase' data-injurycase='<%=injuryId%>' href="" data-toggle="modal" data-action="viewedit" 
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#injurycase_pop_up" data-class="problem"
                                                                                   data-value='injurycase' data-injurycase='<%=injuryId%>' href="" data-toggle="modal" data-action="delete"  
                                                                                   class="edit_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>   
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=location%></td>
                                                                            <td><%=bodyPart%></td>
                                                                            <td><%=treatment%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#injurycase_pop_up" data-class="problem" data-title="View Injury History Details"  
                                                                                                      data-value='injurycase' data-injurycase='<%=injuryId%>' href="" data-toggle="modal" data-action="viewedit"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#injurycase_pop_up" data-class="problem"
                                                                                   data-value='injurycase' data-injurycase='<%=injuryId%>' href="" data-toggle="modal" data-action="delete"  
                                                                                   class="edit_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>   
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (injuryIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_injury_seemore" onclick="seemore('.other_injury');">See more</a>
                                                                    <a style="cursor:pointer;display:none"class="text-center col-sm-12 seemore_btn other_injury_seemore" onclick="seemore('.other_injury');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                            <!--Illness History-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Illness History
                                                                        <a href="" id="ttrAddBtn" data-toggle="modal" data-action = "add"  data-class="problem" data-title="Add A Illness History Details" data-target="#illnesscase_pop_up" data-value='illnesscase' data-illnesscase='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> illnessIds = ProblemComplementsDAO.retrieveIllnessIdsOfProblem(latestProblem);

                                                                        if (illnessIds != null && !illnessIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>When began</th>
                                                                            <th>When diagnosed</th>
                                                                            <th>Who diagnosed</th>
                                                                            <th>Nature of illness</th>
                                                                            <th class="tbl-20-col">Action</th>
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
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#illnesscase_pop_up" data-class="problem" 
                                                                                                      data-title="View Illness History Details"  data-value='illnesscase' data-illnesscase='<%=illnessId%>' 
                                                                                                      href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#illnesscase_pop_up" data-class="problem" 
                                                                                   data-value='illnesscase' data-illnesscase='<%=illnessId%>' 
                                                                                   href="" data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=date%></td>
                                                                            <td><%=dDate%></td>
                                                                            <td><%=dWho%></td>
                                                                            <td><%=nature%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#illnesscase_pop_up" data-class="problem" 
                                                                                                      data-title="View Illness History Details"  data-value='illnesscase' 
                                                                                                      data-illnesscase='<%=illnessId%>' href="" data-toggle="modal" data-action="viewedit"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#illnesscase_pop_up" data-class="problem" 
                                                                                   data-value='illnesscase' data-illnesscase='<%=illnessId%>' 
                                                                                   href="" data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (illnessIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_illness_seemore" onclick="seemore('.other_illness');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_illness_seemore" onclick="seemore('.other_illness');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>


                                                            <!--WICA Claim Lodged-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">WICA Claim Lodged
                                                                        <a href="" id="wicaclaimAddBtn" data-toggle="modal" data-action = "add" data-title="Add WICA Claim Lodged Details" data-class="problem"   data-target="#wicaclaim_pop_up" data-value='wicaclaim' data-wicaclaim='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> wicaclaimIds = ProblemComplementsDAO.retrieveWicaClaimIdsOfProblem(latestProblem);

                                                                        if (wicaclaimIds != null && !wicaclaimIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>When lodged</th>
                                                                            <th>WICA ref Number</th>
                                                                            <th>Insurer</th>
                                                                            <th>Policy number</th>
                                                                            <th class="tbl-20-col">Action</th>
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
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=refNo%></td>
                                                                            <td><%=insurer%></td>
                                                                            <td><%=policyNo%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#wicaclaim_pop_up" data-value='wicaclaim' 
                                                                                                      data-class="problem" data-title="View WICA Claim Lodged Details"  
                                                                                                      data-wicaclaim='<%=wicaclaimId%>' href="" data-toggle="modal" data-action="viewedit" 
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#wicaclaim_pop_up" data-value='wicaclaim' 
                                                                                   data-class="problem"
                                                                                   data-wicaclaim='<%=wicaclaimId%>' href="" data-toggle="modal" data-action="delete" 
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=refNo%></td>
                                                                            <td><%=insurer%></td>
                                                                            <td><%=policyNo%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#wicaclaim_pop_up" data-value='wicaclaim' 
                                                                                                      data-class="problem" data-title="View WICA Claim Lodged Details"  
                                                                                                      data-wicaclaim='<%=wicaclaimId%>' href="" data-toggle="modal" data-action="viewedit"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#wicaclaim_pop_up" data-value='wicaclaim' 
                                                                                   data-class="problem"
                                                                                   data-wicaclaim='<%=wicaclaimId%>' href="" data-toggle="modal" data-action="delete" 
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (wicaclaimIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_wicaClaim_seemore" onclick="seemore('.other_wicaClaim');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_wicaClaim_seemore" onclick="seemore('.other_wicaClaim');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>



                                                            <!--Non WICA Claim Lodged-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Non-WICA Medical Claim Lodged
                                                                        <a href="" id="nonwicaclaimAddBtn" data-toggle="modal" data-action = "add" data-title="Add Non-WICA Claim Lodged Details" data-class="problem"   data-target="#nonwicaclaim_pop_up" data-value='nonwicaclaim' data-nonwicaclaim='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> nonwicaClaimIds = ProblemComplementsDAO.retrieveNonWicaClaimIdsOfProblem(latestProblem);

                                                                        if (nonwicaClaimIds != null && !nonwicaClaimIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th class="tbl-20-col">Date MOM notified</th>
                                                                            <th class="tbl-20-col">Claim value</th>
                                                                            <th class="tbl-20-col">Insurer</th>
                                                                            <th class="tbl-20-col">Policy number</th>
                                                                            <th class="tbl-20-col">Action</th>
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
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=(loss == 0.0) ? "" : df.format(loss)%></td>
                                                                            <td><%=insurer%></td>
                                                                            <td><%=pNo%></td>
                                                                            <td class="tbl-20-col"><a style="color: black"  data-target="#nonwicaclaim_pop_up"  data-class="problem" 
                                                                                                      data-title="View Non-WICA Claim Lodged Details" data-value='nonwicaclaim' 
                                                                                                      data-nonwicaclaim='<%=nonwicaClaimId%>' href="" data-toggle="modal" 
                                                                                                      data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black"  data-target="#nonwicaclaim_pop_up"  data-class="problem" 
                                                                                   data-value='nonwicaclaim' 
                                                                                   data-nonwicaclaim='<%=nonwicaClaimId%>' href="" data-toggle="modal" 
                                                                                   data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=(loss == 0.0) ? "" : df.format(loss)%></td>
                                                                            <td><%=insurer%></td>
                                                                            <td><%=pNo%></td>
                                                                            <td class="tbl-20-col"><a style="color: black"  data-target="#nonwicaclaim_pop_up"  data-class="problem" 
                                                                                                      data-title="View Non-WICA Claim Lodged Details" data-value='nonwicaclaim' 
                                                                                                      data-nonwicaclaim='<%=nonwicaClaimId%>' href="" data-toggle="modal" 
                                                                                                      data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black"  data-target="#nonwicaclaim_pop_up"  data-class="problem" 
                                                                                   data-value='nonwicaclaim' 
                                                                                   data-nonwicaclaim='<%=nonwicaClaimId%>' href="" data-toggle="modal" 
                                                                                   data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (nonwicaClaimIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_nonWica_seemore" onclick="seemore('.other_nonWica');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_nonWica_seemore" onclick="seemore('.other_nonWica');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>


                                                            <!-- WICA Status -->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">WICA Status
                                                                        <a href="" id="wicaAddBtn" data-toggle="modal" data-action = "add" data-title="Add A New WICA Status" data-class="problem"   data-target="#wica_pop_up" data-value='wica' data-wica='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> wicaIds = ProblemComplementsDAO.retrieveWicaIdsOfProblem(latestProblem);

                                                                        if (wicaIds != null && !wicaIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>Status</th>
                                                                            <th>Update date</th>
                                                                            <th>WICA points</th>
                                                                            <th>WICA S$ comp</th>
                                                                            <th class="tbl-20-col">Action</th>
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
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=(point == 0.0) ? "" : df.format(point)%></td>
                                                                            <td><%=(comp == 0.0) ? "" : df.format(comp)%></td>
                                                                            <td class="tbl-20-col"><a style="color: black"  data-target="#wica_pop_up" data-value='wica' 
                                                                                                      data-class="problem" data-title="View WICA Status Details"  data-wica='<%=wicaId%>' 
                                                                                                      href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black"  data-target="#wica_pop_up" data-value='wica' 
                                                                                   data-class="problem" data-wica='<%=wicaId%>' 
                                                                                   href="" data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=status%></td>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=(point == 0.0) ? "" : df.format(point)%></td>
                                                                            <td><%=(comp == 0.0) ? "" : df.format(comp)%></td>
                                                                            <td class="tbl-20-col"><a style="color: black"  data-target="#wica_pop_up" data-value='wica' data-class="problem" 
                                                                                                      data-title="View WICA Status Details"  data-wica='<%=wicaId%>' href="" data-toggle="modal" 
                                                                                                      data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black"  data-target="#wica_pop_up" data-value='wica' 
                                                                                   data-class="problem" data-wica='<%=wicaId%>' 
                                                                                   href="" data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (wicaIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_wicaStatus_seemore" onclick="seemore('.other_wicaStatus');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_wicaStatus_seemore" onclick="seemore('.other_wicaStatus');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                            <!-- Hospital Treatment  -->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Hospital Providing Treatment
                                                                        <a href="" id="hospitalAddBtn" data-toggle="modal" data-action = "add"  data-class="problem" data-title="Add A New Hospital Providing Treatment"  data-target="#hospital_pop_up" data-value='hospital' data-hospital='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> hospitalIds = ProblemComplementsDAO.retrieveProblemHospitalIdsOfProblem(latestProblem);

                                                                        if (hospitalIds != null && !hospitalIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>

                                                                            <th>Update date</th>
                                                                            <th>Hospital</th>
                                                                            <th class="tbl-20-col">Dept/Doctor</th>
                                                                            <th class="tbl-20-col">Action</th>
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
                                                                                if (doctor.length() > 60) {
                                                                                    doctor = doctor.substring(0, 60) + "...";
                                                                                }
                                                                                java.util.Date date = hospital.getHospitalUpdate();

                                                                                if (i < hospitalIds.size() - 1) {
                                                                        %>
                                                                        <tr class="other_hospital moreObjs">

                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=name%></td>
                                                                            <td><%=doctor%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#hospital_pop_up"  data-class="problem" 
                                                                                                      data-title="View Hospital Providing Treatment Details" data-value='hospital' 
                                                                                                      data-hospital='<%=hospitalId%>' href="" data-toggle="modal" data-action="viewedit"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#hospital_pop_up"  data-class="problem" 
                                                                                   data-value='hospital' 
                                                                                   data-hospital='<%=hospitalId%>' href="" data-toggle="modal" data-action="delete"  
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>

                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=name%></td>
                                                                            <td><%=doctor%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#hospital_pop_up"  data-class="problem" 
                                                                                                      data-title="View Hospital Providing Treatment Details" data-value='hospital' 
                                                                                                      data-hospital='<%=hospitalId%>' href="" data-toggle="modal" data-action="viewedit"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#hospital_pop_up"  data-class="problem" 
                                                                                   data-value='hospital' 
                                                                                   data-hospital='<%=hospitalId%>' href="" data-toggle="modal" data-action="delete"  
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (hospitalIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_hospital_seemore" onclick="seemore('.other_hospital');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_hospital_seemore" onclick="seemore('.other_hospital');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>


                                                            <!-- MC/Light Duty Status  -->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">MC/Light Duty Status
                                                                        <a href="" id="mcAddBtn" data-toggle="modal" data-action = "add"  data-class="problem" data-title="Add A New MC/Light Duty Status"  data-target="#mc_pop_up" data-value='mc' data-mc='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> mcIds = ProblemComplementsDAO.retrieveProblemMCStatusIdsOfProblem(latestProblem);

                                                                        if (mcIds != null && !mcIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>

                                                                            <th>Update date</th>
                                                                            <th>Current status</th>
                                                                            <th>MC expiry date</th>
                                                                            <th>Cumul MC days</th>
                                                                            <th class="tbl-20-col">Action</th>
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

                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=status%></td>
                                                                            <td><%=(exDate == null) ? "-" : sdf.format(exDate)%></td>
                                                                            <td><%=cdays%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#mc_pop_up" data-value='mc' data-class="problem" 
                                                                                                      data-title="View MC/Light Duty Status Details"  data-mc='<%=mcId%>' 
                                                                                                      href="" data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#mc_pop_up" data-value='mc' data-class="problem" 
                                                                                   data-mc='<%=mcId%>' 
                                                                                   href="" data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>

                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=status%></td>
                                                                            <td><%=(exDate == null) ? "-" : sdf.format(exDate)%></td>
                                                                            <td><%=cdays%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#mc_pop_up" data-value='mc' data-class="problem" 
                                                                                                      data-title="View MC/Light Duty Status Details" data-mc='<%=mcId%>' href="" 
                                                                                                      data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#mc_pop_up" data-value='mc' data-class="problem" 
                                                                                   data-mc='<%=mcId%>' 
                                                                                   href="" data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (mcIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_mc_seemore" onclick="seemore('.other_mc');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_mc_seemore" onclick="seemore('.other_mc');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>


                                                            <!-- R2R Appointments  -->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">R2R Appointments
                                                                        <a href="" id="r2rAddBtn" data-toggle="modal" data-action = "add"  data-class="problem"  data-title="Add A New R2R Appointment" data-target="#r2r_pop_up" data-value='r2r' data-r2r='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> r2rIds = ProblemComplementsDAO.retrieveProblemR2RIdsOfProblem(latestProblem);

                                                                        if (r2rIds != null && !r2rIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>

                                                                            <th>Appt date</th>
                                                                            <th>Appt time</th>
                                                                            <th>Hospital</th>
                                                                            <th>R2R 1st volunteer</th>
                                                                            <th class="tbl-20-col">Action</th>
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

                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=time%></td>
                                                                            <td><%=hospital%></td>
                                                                            <td><%=r2r1%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#r2r_pop_up" data-value='r2r' data-class="problem" 
                                                                                                      data-title="View R2R Appointment Details"  data-r2r='<%=r2rId%>' href="" 
                                                                                                      data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#r2r_pop_up" data-value='r2r' data-class="problem" 
                                                                                   data-r2r='<%=r2rId%>' href="" 
                                                                                   data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>
                                                                            <td><%=time%></td>
                                                                            <td><%=hospital%></td>
                                                                            <td><%=r2r1%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#r2r_pop_up" data-value='r2r' data-class="problem" 
                                                                                                      data-title="View R2R Appointment Details" data-r2r='<%=r2rId%>' href="" data-toggle="modal"
                                                                                                      data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#r2r_pop_up" data-value='r2r' data-class="problem" 
                                                                                   data-r2r='<%=r2rId%>' href="" 
                                                                                   data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>      
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (r2rIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_r2r_seemore" onclick="seemore('.other_r2r');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_r2r_seemore" onclick="seemore('.other_r2r');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                </div>

                                                <!--Other Complements-->
                                                <div class="panel accordion_panel">
                                                    <div class="panel-heading accordion_panel_heading" role="tab" id="headingThree" style="border-bottom: 1px solid; border-top: 2px solid lightgray">
                                                        <h4 class="panel-title">
                                                            <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#otherComps" data-class="problem"   aria-expanded="true" aria-controls="collapseThree">
                                                                Other Complements
                                                            </a>
                                                        </h4>
                                                    </div>
                                                    <div id="otherComps" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingThree">
                                                        <div class="panel-body">

                                                            <!--Details & History of Other Problem-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Details & History of Other Problem
                                                                        <a href="" id="otherProbAddBtn" data-toggle="modal" data-action = "add" data-class="problem" data-title="Add Details & history of other problems"  data-target="#othercase_pop_up" data-value='othercase' data-othercase='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> otherCaseIds = ProblemComplementsDAO.retrieveOtherProblemIdsOfProblem(latestProblem);

                                                                        if (otherCaseIds != null && !otherCaseIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>Description</th>
                                                                            <th class="tbl-20-col">Claim value</th>

                                                                            <th class="tbl-20-col">Action</th>
                                                                        </tr>

                                                                        <%
                                                                            for (int i = otherCaseIds.size() - 1; i >= 0; i--) {
                                                                                int otherCaseId = otherCaseIds.get(i);

                                                                                ProblemOtherProblems otherCase = ProblemComplementsDAO.retrieveProblemOtherProblemsById(otherCaseId);

                                                                                String description = otherCase.getOtherProblemDesc();
                                                                                if (description.length() > 60) {
                                                                                    description = description.substring(0, 60) + "...";
                                                                                }
                                                                                double loss = otherCase.getOtherProblemLoss();
                                                                                //String remark = otherCase.getOtherProblemRemark();
                                                                                if (i < otherCaseIds.size() - 1) {
                                                                        %>
                                                                        <tr class="other_othercase moreObjs">
                                                                            <td><%=description%></td>
                                                                            <td><%=(loss == 0.0) ? "" : df.format(loss)%></td>

                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#othercase_pop_up" data-value='othercase' 
                                                                                                      data-class="problem" data-title="View Details & history of other problems"  
                                                                                                      data-othercase='<%=otherCaseId%>' href="" data-toggle="modal" data-action="viewedit"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#othercase_pop_up" data-value='othercase' 
                                                                                   data-class="problem"
                                                                                   data-othercase='<%=otherCaseId%>' href="" data-toggle="modal" data-action="delete"  
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>   
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>

                                                                        <tr>
                                                                            <td><%=description%></td>
                                                                            <td><%=(loss == 0.0) ? "" : df.format(loss)%></td>

                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#othercase_pop_up" data-value='othercase' 
                                                                                                      data-class="problem" data-title="View Details & history of other problems"  
                                                                                                      data-othercase='<%=otherCaseId%>' href="" data-toggle="modal" data-action="viewedit"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#othercase_pop_up" data-value='othercase' 
                                                                                   data-class="problem"
                                                                                   data-othercase='<%=otherCaseId%>' href="" data-toggle="modal" data-action="delete"  
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (otherCaseIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_othercase_seemore" onclick="seemore('.other_othercase');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_othercase_seemore" onclick="seemore('.other_othercase');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>


                                                            <!--Police Report Lodged-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Police Report Lodged
                                                                        <a href="" id="policareportAddBtn" data-toggle="modal" data-action = "add" data-title="Add A New Police Report Lodged" data-class="problem"   data-target="#policareport_pop_up" data-value='policareport' data-policareport='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> policeReportIds = ProblemComplementsDAO.retrievePoliceReportIdsOfProblem(latestProblem);

                                                                        if (policeReportIds != null && !policeReportIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th class="tbl-20-col">When lodged</th>
                                                                            <th class="tbl-20-col">Police station</th>
                                                                            <th class="tbl-20-col">TWC2 escort</th>
                                                                            <th class="tbl-20-col">Report Ref number</th>
                                                                            <th class="tbl-20-col">Action</th>
                                                                        </tr>

                                                                        <%
                                                                            for (int i = policeReportIds.size() - 1; i >= 0; i--) {
                                                                                int policeReportId = policeReportIds.get(i);

                                                                                ProblemPoliceReport policeReport = ProblemComplementsDAO.retrieveProblemPoliceReportById(policeReportId);

                                                                                java.util.Date date = policeReport.getPoliceReportDate();
                                                                                String station = policeReport.getPoliceReportStation();
                                                                                String accompany = policeReport.getPoliceReportPerson();
                                                                                if(accompany.length() > 60){
                                                                                    accompany = accompany.substring(0,60) + "...";
                                                                                }
                                                                                String reference = policeReport.getPoliceReportReferenceNumber();
                                                                                if (i < policeReportIds.size() - 1) {
                                                                        %>
                                                                        <tr class="other_police moreObjs">
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td> 
                                                                            <td><%=station%></td>
                                                                            <td><%=accompany%></td>
                                                                            <td><%=reference%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#policareport_pop_up" data-value='policareport'
                                                                                                      data-class="problem" data-title="View Police Report Lodged Details"  
                                                                                                      data-policareport='<%=policeReportId%>' href="" data-toggle="modal" data-action="viewedit" 
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#policareport_pop_up" data-value='policareport'
                                                                                   data-class="problem" 
                                                                                   data-policareport='<%=policeReportId%>' href="" data-toggle="modal" data-action="delete" 
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td> 
                                                                            <td><%=station%></td>
                                                                            <td><%=accompany%></td>
                                                                            <td><%=reference%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#policareport_pop_up" data-value='policareport'
                                                                                                      data-class="problem" data-title="View Police Report Lodged Details"  
                                                                                                      data-policareport='<%=policeReportId%>' href="" data-toggle="modal" data-action="viewedit" 
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#policareport_pop_up" data-value='policareport'
                                                                                   data-class="problem" 
                                                                                   data-policareport='<%=policeReportId%>' href="" data-toggle="modal" data-action="delete" 
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (policeReportIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_police_seemore" onclick="seemore('.other_police');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_police_seemore" onclick="seemore('.other_police');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                            <!--Other Complaint Lodged-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Other Complaint Lodged
                                                                        <a href="" id="otherComplaintAddBtn" data-toggle="modal" data-action = "add" data-class="problem"  data-title="Add A New Other Complaint Lodged" data-target="#othercomplaint_pop_up" data-value='othercomplaint' data-othercomplaint='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> otherComplaintIds = ProblemComplementsDAO.retrieveOtherComplaintIdsOfProblem(latestProblem);

                                                                        if (otherComplaintIds != null && !otherComplaintIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>When lodged</th>
                                                                            <th>Complained to</th>
                                                                            <th>Complainant</th>
                                                                            <th>How lodged</th>
                                                                            <th class="tbl-20-col">Action</th>
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
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td> 
                                                                            <td><%=agency%></td>
                                                                            <td><%=by%></td>
                                                                            <td><%=mode%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#othercomplaint_pop_up" data-class="problem" 
                                                                                                      data-title="View Other Complaint Lodged Details" data-value='othercomplaint' 
                                                                                                      data-othercomplaint='<%=otherComplaintId%>' href="" data-toggle="modal" data-action="viewedit"  
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#othercomplaint_pop_up" data-class="problem" 
                                                                                   data-value='othercomplaint' 
                                                                                   data-othercomplaint='<%=otherComplaintId%>' href="" data-toggle="modal" data-action="delete"  
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td> 
                                                                            <td><%=agency%></td>
                                                                            <td><%=by%></td>
                                                                            <td><%=mode%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#othercomplaint_pop_up" data-class="problem" 
                                                                                                      data-title="View Other Complaint Lodged Details" data-value='othercomplaint' 
                                                                                                      data-othercomplaint='<%=otherComplaintId%>' href="" data-toggle="modal" data-action="viewedit" 
                                                                                                      class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#othercomplaint_pop_up" data-class="problem" 
                                                                                   data-value='othercomplaint' 
                                                                                   data-othercomplaint='<%=otherComplaintId%>' href="" data-toggle="modal" data-action="delete"  
                                                                                   class="delete_btn pop_up_open"><span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>     
                                                                            </td>
                                                                        </tr>

                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (otherComplaintIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_othercomplaints_seemore" onclick="seemore('.other_othercomplaints');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_othercomplaints_seemore" onclick="seemore('.other_othercomplaints');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                            <!--Case Milestone Reached(non-criminal)-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Case Milestone Reached(non-criminal)
                                                                        <a href="" id="cmncAddBtn" data-toggle="modal" data-action = "add" data-class="problem" data-title="Add A New Case Milestone (Non-Criminal)" data-target="#milestonenc_pop_up" data-value='ncmilestone' data-ncmilestone='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> nCaseMSIds = ProblemComplementsDAO.retrieveProblemCaseMilestoneNCIdsOfProblem(latestProblem);


                                                                        if (nCaseMSIds != null && !nCaseMSIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>Milestone date</th>
                                                                            <th>Milestone reached</th>

                                                                            <th class="tbl-20-col">Action</th>
                                                                        </tr>

                                                                        <%
                                                                            for (int i = nCaseMSIds.size() - 1; i >= 0; i--) {
                                                                                int nCaseMSId = nCaseMSIds.get(i);

                                                                                ProblemCaseMilestoneNC casemsNc = ProblemComplementsDAO.retrieveProblemCaseMilestoneNCById(nCaseMSId);
                                                                                java.util.Date date = casemsNc.getMilesNCDate();
                                                                                String reached = casemsNc.getMilesNCReached();
                                                                                //String remark = casemsNc.getMilesNCRem();

                                                                                if (reached == null || reached.equals("other") || reached.equals("Other")) {
                                                                                    reached = casemsNc.getMilesNCReachedMore();
                                                                                }

                                                                                if (i < nCaseMSIds.size() - 1) {
                                                                        %>
                                                                        <tr class="other_casemsnc moreObjs">
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td> 
                                                                            <td><%=reached%></td>

                                                                            <td>
                                                                                <a style="color: black" data-target="#milestonenc_pop_up" data-title="View Case Milestone (Non-Criminal) Details"
                                                                                   data-class="problem"  data-value='ncmilestone' data-ncmilestone='<%=nCaseMSId%>' href="" data-toggle="modal" 
                                                                                   data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#milestonenc_pop_up"
                                                                                   data-class="problem"  data-value='ncmilestone' data-ncmilestone='<%=nCaseMSId%>' href="" data-toggle="modal" 
                                                                                   data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>     
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td> 
                                                                            <td><%=reached%></td>

                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#milestonenc_pop_up"  data-class="problem" data-title="View Case Milestone (Non-Criminal) Details" 
                                                                                                      data-value='ncmilestone' data-ncmilestone='<%=nCaseMSId%>' href="" data-toggle="modal" 
                                                                                                      data-action="viewedit"  class="edit_btn pop_up_open"><span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#milestonenc_pop_up"
                                                                                   data-class="problem"  data-value='ncmilestone' data-ncmilestone='<%=nCaseMSId%>' href="" data-toggle="modal" 
                                                                                   data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (nCaseMSIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_casemsnc_seemore" onclick="seemore('.other_casemsnc');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_casemsnc_seemore" onclick="seemore('.other_casemsnc');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                            <!--Case Milestone Reached(criminal)-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Case Milestone Reached(Criminal)
                                                                        <a href="" id="cmilestoneAddBtn" data-toggle="modal" data-action = "add" data-title="Add A New Case Milestone (Criminal)" data-target="#milestonecr_pop_up"  data-class="problem"  data-value='cmilestone' data-cmilestone='' class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> caseMSIds = ProblemComplementsDAO.retrieveProblemCaseMilestoneCRIdsOfProblem(latestProblem);


                                                                        if (caseMSIds != null && !caseMSIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>Milestone date</th>
                                                                            <th>Milestone reached</th>

                                                                            <th class="tbl-20-col">Action</th>
                                                                        </tr>

                                                                        <%
                                                                            for (int i = caseMSIds.size() - 1; i >= 0; i--) {
                                                                                int caseMSId = caseMSIds.get(i);

                                                                                ProblemCaseMilestoneCR casemsc = ProblemComplementsDAO.retrieveProblemCaseMilestoneCRById(caseMSId);
                                                                                java.util.Date date = casemsc.getMilesCRDate();
                                                                                String reached = casemsc.getMilesCRReached();
                                                                                //String remark = casemsc.getMilesCRRem();

                                                                                if (reached == null || reached.equals("other") || reached.equals("Other")) {
                                                                                    reached = casemsc.getMilesCRReachedMore();
                                                                                }

                                                                                if (i < caseMSIds.size() - 1) {
                                                                        %>
                                                                        <tr class="other_casemscr moreObjs">
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td> 
                                                                            <td><%=reached%></td>

                                                                            <td>
                                                                                <a style="color: black" data-target="#milestonecr_pop_up" data-title="View Case Milestone (Criminal) Details" 
                                                                                   data-value='cmilestone' data-cmilestone='<%=caseMSId%>' data-class="problem"  href="" 
                                                                                   data-toggle="modal" data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#milestonecr_pop_up" data-title="View Case Milestone (Criminal) Details" 
                                                                                   data-value='cmilestone' data-cmilestone='<%=caseMSId%>' data-class="problem"  href="" 
                                                                                   data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td> 
                                                                            <td><%=reached%></td>
                                                                            <td>
                                                                                <a style="color: black" data-target="#milestonecr_pop_up" data-title="View Case Milestone (Criminal) Details"
                                                                                   data-value='cmilestone' data-cmilestone='<%=caseMSId%>' data-class="problem"  href="" data-toggle="modal" 
                                                                                   data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#milestonecr_pop_up" data-title="View Case Milestone (Criminal) Details" 
                                                                                   data-value='cmilestone' data-cmilestone='<%=caseMSId%>' data-class="problem"  href="" 
                                                                                   data-toggle="modal" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
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

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_casemscr_seemore" onclick="seemore('.other_casemscr');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_casemscr_seemore" onclick="seemore('.other_casemscr');">View Less</a>
                                                                    <%                                                            }
                                                                        }
                                                                    %>
                                                                </div>
                                                            </div>

                                                            <!--Transfer, TJS & Repatriation-->
                                                            <div class="panel panel-default">

                                                                <div class="panel-heading">
                                                                    <h4 class="panel-title">Transfer, TJS & Repatriation
                                                                        <a href="" id="ttrAddBtn" data-toggle="modal" data-action = "add" data-title="Add A New Transfer, TJS & Repatriation" data-target="#ttr_pop_up" data-value='ttr' data-ttr='' data-class="problem" class="add_btn pop_up_open pull-right">
                                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                                        </a>
                                                                    </h4>
                                                                </div>
                                                                <div class="panel-body ">
                                                                    <%
                                                                        ArrayList<Integer> ttrIds = ProblemComplementsDAO.retrieveProblemTTRIdsOfProblem(latestProblem);

                                                                        if (ttrIds != null && !ttrIds.isEmpty()) {
                                                                    %>

                                                                    <table class="table table-condensed">
                                                                        <tr>
                                                                            <th>Updated date</th>
                                                                            <th>Status</th>
                                                                            <th>Depart SG date</th>
                                                                            <th class="tbl-20-col">New employer</th>
                                                                            <th class="tbl-20-col">Action</th>
                                                                        </tr>

                                                                        <%
                                                                            for (int i = ttrIds.size() - 1; i >= 0; i--) {
                                                                                int ttrId = ttrIds.get(i);

                                                                                ProblemTTR ttr = ProblemComplementsDAO.retrieveProblemTTRById(ttrId);
                                                                                java.util.Date date = ttr.getTTRUpdate();
                                                                                String dDate = ttr.getDepartureDate();
                                                                                String status = ttr.getTTRStatus();
                                                                                String name = ttr.getNewEmployerName();

                                                                                if (i < ttrIds.size() - 1) {
                                                                        %>
                                                                        <tr class="other_ttr moreObjs">
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>                                                         
                                                                            <td><%=status%></td>
                                                                            <td><%=(dDate == null) ? "-" : dDate%></td>
                                                                            <td><%=(name == null)? "" : name%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#ttr_pop_up" data-value='ttr' data-ttr='<%=ttrId%>' 
                                                                                                      data-title="Add A New Transfer, TJS & Repatriation" href="" data-toggle="modal" 
                                                                                                      data-class="problem" data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#ttr_pop_up" data-value='ttr' data-ttr='<%=ttrId%>' 
                                                                                   data-title="Add A New Transfer, TJS & Repatriation" href="" data-toggle="modal" 
                                                                                   data-class="problem" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>    
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                        } else {
                                                                        %>
                                                                        <tr>
                                                                            <td><%=(date == null) ? "-" : sdf.format(date)%></td>                                                         
                                                                            <td><%=status%></td>
                                                                            <td><%=(dDate == null) ? "-" : dDate%></td>
                                                                            <td><%=(name == null)? "" : name%></td>
                                                                            <td class="tbl-20-col"><a style="color: black" data-target="#ttr_pop_up" data-value='ttr' data-ttr='<%=ttrId%>' 
                                                                                                      data-title="Add A New Transfer, TJS & Repatriation" href="" data-toggle="modal" 
                                                                                                      data-class="problem" data-action="viewedit"  class="edit_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-eye-open"></span>
                                                                                </a>
                                                                                <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <a style="color: black" data-target="#ttr_pop_up" data-value='ttr' data-ttr='<%=ttrId%>' 
                                                                                   data-title="Add A New Transfer, TJS & Repatriation" href="" data-toggle="modal" 
                                                                                   data-class="problem" data-action="delete"  class="delete_btn pop_up_open">
                                                                                    <span class="glyphicon glyphicon-trash"></span>
                                                                                </a>
                                                                                <% }%>   
                                                                            </td>
                                                                        </tr>
                                                                        <%
                                                                                }
                                                                            }
                                                                        %>
                                                                    </table>
                                                                    <%
                                                                        if (ttrIds.size() > 1) {
                                                                    %>

                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_ttr_seemore" onclick="seemore('.other_ttr');">See more</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_ttr_seemore" onclick="seemore('.other_ttr');">View Less</a>
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
                                </div>

                                <!----Benefits Complement Tab-->                             
                                <div class="tab-pane" id="benefit_complement" >
                                    <br/>
                                    <!-- Benefits Success & Error Display -->

                                    <% if (successBenefitMsg != null) {
                                            if (!successBenefitMsg.equals("")) {%>

                                    <div class="alert alert-info" role="alert">
                                        <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                        <%=successBenefitMsg%>
                                    </div>

                                    <% }
                                        }%>
                                    <% if (errorBenefitMsg != null) {
                                            if (!errorBenefitMsg.equals("")) {%>

                                    <div class="alert alert-danger" role="alert">
                                        <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                        <%=errorBenefitMsg%>
                                    </div>

                                    <% }
                                        }%>
                                    <!-- End of Benefits Success & Error Display -->
                                    <div class='row'>
                                        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="false">
                                            <!--meal-->
                                            <div class="panel panel-default">
                                                <div class="panel-heading" role="tab" id="foodbeneHead">
                                                    <h4 class="panel-title">
                                                        <a data-toggle="collapse" data-parent="#accordion" href="#foodBeneCol" aria-expanded="true" aria-controls="foodBeneCol">
                                                            Meal </a>
                                                        <a href="" id="foodbeneAddBtn" data-toggle="modal" data-class="benefection" 
                                                           data-target="#foodbene_pop_up"   data-title='Add New Meal Benefection'  
                                                           data-action = "add" data-value='foodbene' data-foodbene='' class="add_btn pop_up_open pull-right">

                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                        </a>

                                                    </h4>
                                                </div>
                                                <div id="foodBeneCol" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="foodbeneHead">
                                                    <div class="panel-body">
                                                        
                                                        <%
                                                        
                                                            ArrayList<Benefit> mealBenefits = new ArrayList<Benefit>();
                                                            ArrayList<String> list = DropdownDAO.retreiveAllDropdownListOfBenefits("Food");
                                                            ArrayList<Integer> ids = new ArrayList<Integer>();
                                                            for (String string : list) {

                                                                ids = BenefitDAO.retrieveBenefitsIdsOfProblem(latestProblem, string);
                                                                for (int id = 0; id < ids.size(); id++) {
                                                                    Benefit benefit = BenefitDAO.retrieveBenefitById(ids.get(id));
                                                                    mealBenefits.add(benefit);
                                                                }
                                                            }
                                                            Collections.sort(mealBenefits, new BenefitComparator());
                                                            if (mealBenefits != null && !mealBenefits.isEmpty()) {
                                                                
                                                        %>

                                                        <table class="table table-condensed">
                                                            <tr>
                                                                <th class='tbl-20-col'>Date benefit given</th>
                                                                <th class='tbl-20-col'>Benefit given by</th>
                                                                <th class='tbl-20-col'>Type</th>
                                                                <th class='tbl-20-col'>Value</th>
                                                                <th class="tbl-20-col">Action</th>
                                                            </tr>
                                                            <%
                                                                for (int i = mealBenefits.size() - 1; i >= 0; i--) {
                                                                    Benefit benefit = mealBenefits.get(i);
                                                                    
                                                                    if (i < mealBenefits.size() - 1) {
                                                            %>
                                                            <tr class="other_foodbene moreObjs">
                                                                <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                                <td><%=benefit.getBenefitGiver()%></td>
                                                                <td><%=benefit.getBenefitType()%></td>
                                                                <td><%=(benefit.getBenefitValue() == 0.0) ? "" : df.format(benefit.getBenefitValue())%></td>
                                                                <td class="tbl-20-col">
                                                                    <a style="color: black" data-target="#foodbene_pop_up"  data-class="benefection" 
                                                                       data-value='foodbene' data-title='View Meal Benefection' 
                                                                       data-foodbene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="viewedit" class="edit_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                                    </a>
                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                    &nbsp;&nbsp;&nbsp;
                                                                    <a style="color: black" data-target="#foodbene_pop_up"  data-class="benefit" 
                                                                       data-value='foodbene'  
                                                                       data-foodbene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="delete" class="delete_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-trash"></span>
                                                                    </a>
                                                                    <% }%>   
                                                                </td>
                                                            </tr>
                                                            <% } else { %>
                                                            <tr class="foodbene">
                                                                <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                                <td><%=benefit.getBenefitGiver()%></td>
                                                                <td><%=benefit.getBenefitType()%></td>
                                                                <td><%=(benefit.getBenefitValue() == 0.0) ? "" : df.format(benefit.getBenefitValue())%></td>
                                                                <td class="tbl-20-col">
                                                                    <a style="color: black" data-target="#foodbene_pop_up"  data-class="benefection" 
                                                                       data-value='foodbene' data-title='View Meal Benefection' 
                                                                       data-foodbene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="viewedit" class="edit_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                                    </a>
                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                    &nbsp;&nbsp;&nbsp;
                                                                    <a style="color: black" data-target="#foodbene_pop_up"  data-class="benefit" 
                                                                       data-value='foodbene'  
                                                                       data-foodbene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="delete" class="delete_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-trash"></span>
                                                                    </a>
                                                                    <% }%>   
                                                                </td>
                                                            </tr>
                                                          <% } //else 
                                                         } //for %>  
                                                        </table>
                                                            <% 
                                                                if (mealBenefits.size() > 1) {
                                                            %>
                                                                    <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_foodbene_seemore" onclick="seemore('.other_foodbene');">See More</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_foodbene_seemore" onclick="seemore('.other_foodbene');">View Less</a>
                                                            <%
                                                                   } //if seemore
                                                          }//if
                                                        %>
                                                        
                                                    </div>
                                                </div>
                                            </div>

                                            <!--transportation-->
                                            <div class="panel panel-default">
                                                <div class="panel-heading" role="tab" id="transpoBeneHead">
                                                    <h4 class="panel-title">
                                                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#transpoBeneCol" aria-expanded="true" aria-controls="transpoBeneCol">
                                                            Transportation</a>
                                                        <a href="" id="transpobeneAddBtn" data-toggle="modal" data-target="#transpobene_pop_up"  data-class="benefection" data-title='Add New Transportation Benefection'  data-action = "add" data-value='transpobene' data-transpobene='' class="add_btn pop_up_open pull-right">
                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                        </a>

                                                    </h4>
                                                </div>
                                                <div id="transpoBeneCol" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="transpoBeneHead">
                                                    <div class="panel-body">
                                                        <%
                                                            ArrayList<Benefit> transportBenefits = new ArrayList<Benefit>();
                                                            list = DropdownDAO.retreiveAllDropdownListOfBenefits("Transport");
                                                            ids = new ArrayList<Integer>();
                                                            for (String string : list) {

                                                                ids = BenefitDAO.retrieveBenefitsIdsOfProblem(latestProblem, string);
                                                                for (int id = 0; id < ids.size(); id++) {
                                                                    Benefit benefit = BenefitDAO.retrieveBenefitById(ids.get(id));
                                                                    transportBenefits.add(benefit);
                                                                }
                                                            }
                                                            Collections.sort(transportBenefits, new BenefitComparator());
                                                            if (transportBenefits != null && !transportBenefits.isEmpty()) {


                                                        %>
                                                        <table class="table table-condensed">
                                                            <tr>
                                                                <th class='tbl-20-col'>Date benefit given</th>
                                                                <th class='tbl-20-col'>Benefit given by</th>
                                                                <th class='tbl-20-col'>Type</th>
                                                                <th class='tbl-20-col'>Value</th>
                                                                <th class="tbl-20-col">Action</th>
                                                            </tr>
                                                            <%
                                                                for (int i = transportBenefits.size() - 1; i >= 0; i--) {
                                                                    Benefit benefit = transportBenefits.get(i);
                                                                    if (i < transportBenefits.size() - 1) {
                                                            %>
                                                            <tr class="other_transpoBene moreObjs">
                                                                <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                                <td><%=benefit.getBenefitGiver()%></td>
                                                                <td><%=benefit.getBenefitType()%></td>
                                                                <td><%=(benefit.getBenefitValue() == 0.0) ? "" : df.format(benefit.getBenefitValue())%></td>
                                                                <td class="tbl-20-col">
                                                                    <a style="color: black" data-target="#transpobene_pop_up"  data-class="benefection" 
                                                                       data-value='transpobene' data-title='View Transportation Benefection' 
                                                                       data-transpobene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="viewedit" class="edit_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                                    </a>
                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>   
                                                                    &nbsp;&nbsp;&nbsp;
                                                                    <a style="color: black" data-target="#transpobene_pop_up"  data-class="benefit" 
                                                                       data-value='transpobene' 
                                                                       data-transpobene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="delete" class="delete_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-trash"></span>    
                                                                        <% }%>     
                                                                </td>
                                                            </tr>
                                                            <% } else { %>
                                                            <tr class="transpoBene">
                                                                <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                                <td><%=benefit.getBenefitGiver()%></td>
                                                                <td><%=benefit.getBenefitType()%></td>
                                                                <td><%=(benefit.getBenefitValue() == 0.0) ? "" : df.format(benefit.getBenefitValue())%></td>
                                                                <td class="tbl-20-col">
                                                                    <a style="color: black" data-target="#transpobene_pop_up"  data-class="benefection" 
                                                                       data-value='transpobene' data-title='View Transportation Benefection' 
                                                                       data-transpobene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="viewedit" class="edit_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                                    </a>
                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>   
                                                                    &nbsp;&nbsp;&nbsp;
                                                                    <a style="color: black" data-target="#transpobene_pop_up"  data-class="benefit" 
                                                                       data-value='transpobene' 
                                                                       data-transpobene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="delete" class="delete_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-trash"></span>    
                                                                        <% }%>     
                                                                </td>
                                                            </tr>
                                                       <%   } //else 
                                                         } //for %> 
                                                        </table>
                                                           <% 
                                                                if (transportBenefits.size() > 1) {
                                                            %>
                                                            <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_transpoBene_seemore" onclick="seemore('.other_transpoBene');">See More</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_transpoBene_seemore" onclick="seemore('.other_transpoBene');">View Less</a>
                                                       <%
                                                                   } //if seemore
                                                            }
                                                        %>
                                                    </div>
                                                </div>
                                            </div>

                                            <!--medical-->
                                            <div class="panel panel-default">
                                                <div class="panel-heading" role="tab" id="mediBeneHead">
                                                    <h4 class="panel-title">
                                                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#mediBeneCol" aria-expanded="true" aria-controls="mediBeneCol">
                                                            Medical</a>
                                                        <a href="" id="medibeneAddBtn" data-toggle="modal" data-target="#medibene_pop_up"  data-class="benefection" data-title='Add New Medical Benefection'  data-action = "add" data-value='medibene' data-medibene='' class="add_btn pop_up_open pull-right">
                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="mediBeneCol" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="mediBeneHead">
                                                    <div class="panel-body">
                                                        <%
                                                            ArrayList<Benefit> medicalBenefits = new ArrayList<Benefit>();
                                                            list = DropdownDAO.retreiveAllDropdownListOfBenefits("Medical & Karunya");
                                                            ids = new ArrayList<Integer>();
                                                            for (String string : list) {

                                                                ids = BenefitDAO.retrieveBenefitsIdsOfProblem(latestProblem, string);
                                                                for (int id = 0; id < ids.size(); id++) {
                                                                    Benefit benefit = BenefitDAO.retrieveBenefitById(ids.get(id));
                                                                    medicalBenefits.add(benefit);
                                                                }
                                                            }
                                                            Collections.sort(medicalBenefits, new BenefitComparator());
                                                            if (medicalBenefits != null && !medicalBenefits.isEmpty()) {


                                                        %>
                                                        <table class="table table-condensed">
                                                            <tr>
                                                                <th class='tbl-20-col'>Date benefit given</th>
                                                                <th class='tbl-20-col'>Benefit given by</th>
                                                                <th class='tbl-20-col'>Type</th>
                                                                <th class='tbl-20-col'>Value</th>
                                                                <th class="tbl-20-col">Action</th>
                                                            </tr>
                                                            <%
                                                                for (int i = medicalBenefits.size() - 1; i >= 0; i--) {
                                                                    
                                                                    Benefit benefit = medicalBenefits.get(i);
                                                                     if (i < medicalBenefits.size() - 1) {
                                                            %>
                                                            <tr class="other_mediBene moreObjs">
                                                                <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                                <td><%=benefit.getBenefitGiver()%></td>
                                                                <td><%=benefit.getBenefitType()%></td>
                                                                <td><%=(benefit.getBenefitValue() == 0.0) ? "" : df.format(benefit.getBenefitValue())%></td>
                                                                <td class="tbl-20-col">
                                                                    <a style="color: black" data-target="#medibene_pop_up"  data-class="benefection" 
                                                                       data-value='medibene' data-title='View Medical Benefection' 
                                                                       data-medibene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="viewedit" class="edit_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                                    </a>
                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                    &nbsp;&nbsp;&nbsp;
                                                                    <a style="color: black" data-target="#medibene_pop_up"  data-class="benefit" 
                                                                       data-value='medibene' 
                                                                       data-medibene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="delete" class="delete_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-trash"></span>
                                                                    </a>
                                                                    <% }%>    

                                                                </td>
                                                            </tr>
                                                             <% } else { %>
                                                            <tr class="mediBene">
                                                                <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                                <td><%=benefit.getBenefitGiver()%></td>
                                                                <td><%=benefit.getBenefitType()%></td>
                                                                <td><%=(benefit.getBenefitValue() == 0.0) ? "" : df.format(benefit.getBenefitValue())%></td>
                                                                <td class="tbl-20-col">
                                                                    <a style="color: black" data-target="#medibene_pop_up"  data-class="benefection" 
                                                                       data-value='medibene' data-title='View Medical Benefection' 
                                                                       data-medibene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="viewedit" class="edit_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                                    </a>
                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                    &nbsp;&nbsp;&nbsp;
                                                                    <a style="color: black" data-target="#medibene_pop_up"  data-class="benefit" 
                                                                       data-value='medibene' 
                                                                       data-medibene='<%=benefit.getId()%>' href="" data-toggle="modal" 
                                                                       data-action="delete" class="delete_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-trash"></span>
                                                                    </a>
                                                                    <% }%>    

                                                                </td>
                                                            </tr>
                                                            <%
                                                                } //else
                                                             } //for        
                                                            %>                                                    
                                                        </table>
                                                         <% 
                                                                if (medicalBenefits.size() > 1) {
                                                            %>
                                                            <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_mediBene_seemore" onclick="seemore('.other_mediBene');">See More </a>
                                                            <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_mediBene_seemore" onclick="seemore('.other_mediBene');">View Less</a>
                                                        <%
                                                                 }
                                                            }
                                                        %>
                                                    </div>
                                                </div>
                                            </div>

                                            <!--roof-->
                                            <div class="panel panel-default">
                                                <div class="panel-heading" role="tab" id="roofBeneHead">
                                                    <h4 class="panel-title">
                                                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#roofBeneCol" data-title='Add New Roof Benefections' aria-expanded="true" aria-controls="roofBeneCol">
                                                            Shelter</a>
                                                        <a href="" id="roofbeneAddBtn" data-toggle="modal" data-target="#roofbene_pop_up"  data-class="benefection" data-title='Add New Roof Benefection'  data-action = "add" data-value='roofbene' data-roofbene='' class="add_btn pop_up_open pull-right">
                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                        </a>

                                                    </h4>
                                                </div>
                                                <div id="roofBeneCol" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="roofBeneHead">
                                                    <div class="panel-body">
                                                        <%
                                                            ArrayList<Benefit> roofBenefits = new ArrayList<Benefit>();
                                                            list = DropdownDAO.retreiveAllDropdownListOfBenefits("Roof");
                                                            ids = new ArrayList<Integer>();
                                                            for (String string : list) {

                                                                ids = BenefitDAO.retrieveBenefitsIdsOfProblem(latestProblem, string);
                                                                
                                                                for (int id = 0; id < ids.size(); id++) {
                                                                    Benefit benefit = BenefitDAO.retrieveBenefitById(ids.get(id));
                                                                    roofBenefits.add(benefit);
                                                                }
                                                            }
                                                            Collections.sort(roofBenefits, new BenefitComparator());
                                                            if (roofBenefits != null && !roofBenefits.isEmpty()) {


                                                        %>
                                                        <table class="table table-condensed">
                                                            <tr>
                                                                <th class='tbl-20-col'>Date benefit given</th>
                                                                <th class='tbl-20-col'>Benefit given by</th>
                                                                <th class='tbl-20-col'>Type</th>
                                                                <th class='tbl-20-col'>Value</th>
                                                                <th class="tbl-20-col">Action</th>
                                                            </tr>
                                                            <%
                                                                for (int i = roofBenefits.size() - 1; i >= 0; i--) {
                                                                    Benefit benefit = roofBenefits.get(i);
                                                                     if (i < roofBenefits.size() - 1) {
                                                            %>
                                                            <tr class="other_roofBene moreObjs">
                                                                <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                                <td><%=benefit.getBenefitGiver()%></td>
                                                                <td><%=benefit.getBenefitType()%></td>
                                                                <td><%=(benefit.getBenefitValue() == 0.0) ? "" : df.format(benefit.getBenefitValue())%></td>
                                                                <td class="tbl-20-col">
                                                                    <a style="color: black" data-target="#roofbene_pop_up"  data-class="benefection" 
                                                                       data-value='roofbene' data-title='View Roof Benefection' data-roofbene='<%=benefit.getId()%>' 
                                                                       href="" data-toggle="modal" data-action="viewedit" class="edit_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                                    </a>
                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                    &nbsp;&nbsp;&nbsp;
                                                                    <a style="color: black" data-target="#roofbene_pop_up"  data-class="benefit" 
                                                                       data-value='roofbene' data-roofbene='<%=benefit.getId()%>' 
                                                                       href="" data-toggle="modal" data-action="delete" class="delete_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-trash"></span>
                                                                    </a>
                                                                    <% }%>    
                                                                </td>
                                                            </tr>
                                                            <% } else { %>
                                                            <tr class="roofBene">
                                                                <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                                <td><%=benefit.getBenefitGiver()%></td>
                                                                <td><%=benefit.getBenefitType()%></td>
                                                                <td><%=(benefit.getBenefitValue() == 0.0) ? "" : df.format(benefit.getBenefitValue())%></td>
                                                                <td class="tbl-20-col">
                                                                    <a style="color: black" data-target="#roofbene_pop_up"  data-class="benefection" 
                                                                       data-value='roofbene' data-title='View Roof Benefection' data-roofbene='<%=benefit.getId()%>' 
                                                                       href="" data-toggle="modal" data-action="viewedit" class="edit_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                                    </a>
                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>
                                                                    &nbsp;&nbsp;&nbsp;
                                                                    <a style="color: black" data-target="#roofbene_pop_up"  data-class="benefit" 
                                                                       data-value='roofbene' data-roofbene='<%=benefit.getId()%>' 
                                                                       href="" data-toggle="modal" data-action="delete" class="delete_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-trash"></span>
                                                                    </a>
                                                                    <% }%>    
                                                                </td>
                                                            </tr>
                                                            <%
                                                                } //else
                                                             } //for        
                                                            %>          
                                                        </table>
                                                        <% 
                                                                if (roofBenefits.size() > 1) {
                                                            %>
                                                            <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_roofBene_seemore" onclick="seemore('.other_roofBene');">See More</a>
                                                                    <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_roofBene_seemore" onclick="seemore('.other_roofBene');">View Less</a>
                                                            <%
                                                                   } //if seemore
                                                            }
                                                        %>
                                                    </div>
                                                </div>
                                            </div>

                                            <!--other-->
                                            <div class="panel panel-default">
                                                <div class="panel-heading" role="tab" id="otherBeneHead">
                                                    <h4 class="panel-title">
                                                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#otherBeneCol">
                                                            Others</a>
                                                        <a href="" id="otherbeneAddBtn" data-toggle="modal" data-target="#otherbene_pop_up"  
                                                           data-class="benefection" data-title='Add New Benefection (Others)'  data-action = "add" 
                                                           data-value='otherbene' data-otherbene='' class="add_btn pop_up_open pull-right">
                                                            <span class="glyphicon glyphicon-plus pull-right" pull-right></span>
                                                        </a>
                                                    </h4>
                                                </div>
                                                <div id="otherBeneCol" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="otherBeneHead">
                                                    <div class="panel-body">
                                                        <%
                                                            ArrayList<Benefit> otherBenefits = new ArrayList<Benefit>();
                                                            list = DropdownDAO.retreiveAllDropdownListOfBenefits("Other");
                                                            ids = new ArrayList<Integer>();
                                                            for (String string : list) {

                                                                ids = BenefitDAO.retrieveBenefitsIdsOfProblem(latestProblem, string);
                                                                for (int id = 0; id < ids.size(); id++) {
                                                                    Benefit benefit = BenefitDAO.retrieveBenefitById(ids.get(id));
                                                                    otherBenefits.add(benefit);
                                                                }
                                                            }
                                                            Collections.sort(otherBenefits, new BenefitComparator());
                                                            if (otherBenefits != null && !otherBenefits.isEmpty()) {


                                                        %>
                                                        <table class="table table-condensed">
                                                            <tr>
                                                                <th class='tbl-20-col'>Date benefit given</th>
                                                                <th class='tbl-20-col'>Benefit given by</th>
                                                                <th class='tbl-20-col'>Type</th>
                                                                <th class='tbl-20-col'>Value</th>
                                                                <th class="tbl-20-col">Action</th>
                                                            </tr>
                                                            <%
                                                                for (int i = otherBenefits.size() - 1; i >= 0; i--) {
                                                                    
                                                                    Benefit benefit = otherBenefits.get(i);
                                                                    if (i < otherBenefits.size() - 1) {
                                                            %>
                                                            <tr class="other_Bene">
                                                                <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                                <td><%=benefit.getBenefitGiver()%></td>
                                                                <td><%=benefit.getBenefitType()%></td>
                                                                <td><%=(benefit.getBenefitValue() == 0.0) ? "" : df.format(benefit.getBenefitValue())%></td>
                                                                <td class="tbl-20-col">
                                                                    <a style="color: black" data-target="#otherbene_pop_up"  data-class="benefection" 
                                                                       data-value='otherbene' data-title='View Benefection' data-otherbene='<%=benefit.getId()%>' 
                                                                       href="" data-toggle="modal" data-action="viewedit" class="edit_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                                    </a>
                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>   
                                                                    &nbsp;&nbsp;&nbsp;   
                                                                    <a style="color: black" data-target="#otherbene_pop_up"  data-class="benefit" 
                                                                       data-value='otherbene' data-otherbene='<%=benefit.getId()%>' 
                                                                       href="" data-toggle="modal" data-action="delete" class="delete_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-trash"></span>
                                                                    </a> 
                                                                    <% }%>   
                                                                </td>
                                                            </tr>
                                                             <% } else { %>
                                                             <tr class="Bene">
                                                                <td><%=sdf.format(benefit.getIssueDate())%></td>
                                                                <td><%=benefit.getBenefitGiver()%></td>
                                                                <td><%=benefit.getBenefitType()%></td>
                                                                <td><%=(benefit.getBenefitValue() == 0.0) ? "" : df.format(benefit.getBenefitValue())%></td>
                                                                <td class="tbl-20-col">
                                                                    <a style="color: black" data-target="#otherbene_pop_up"  data-class="benefection" 
                                                                       data-value='otherbene' data-title='View Benefection' data-otherbene='<%=benefit.getId()%>' 
                                                                       href="" data-toggle="modal" data-action="viewedit" class="edit_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-eye-open"></span>
                                                                    </a>
                                                                    <% if (userLogin.getRole().equals("Administrator")) {%>   
                                                                    &nbsp;&nbsp;&nbsp;   
                                                                    <a style="color: black" data-target="#otherbene_pop_up"  data-class="benefit" 
                                                                       data-value='otherbene' data-otherbene='<%=benefit.getId()%>' 
                                                                       href="" data-toggle="modal" data-action="delete" class="delete_btn pop_up_open">
                                                                        <span class="glyphicon glyphicon-trash"></span>
                                                                    </a> 
                                                                    <% }%>   
                                                                </td>
                                                            </tr>
                                                            <%
                                                                } //else
                                                             } //for        
                                                            %>
                                                        </table>
                                                         <% 
                                                                if (otherBenefits.size() > 1) {
                                                            %>
                                                            <a style="cursor:pointer;display:none" class="text-center col-sm-12 seemore_btn other_Bene_seemore" onclick="seemore('.other_Bene');">See More</a>
                                                            <a style="cursor:pointer" class="text-center col-sm-12 seemore_btn other_Bene_seemore" onclick="seemore('.other_Bene');">View Less</a>
                                                            <%
                                                                   } //if seemore
                                                            }
                                                        %>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <!----Attachments Complement Tab-->          
                                <% if (successAttachMsg != null || errorAttachMsg != null) {%>
                                <div class="tab-pane active" id="attachment_complement">
                                    <% } else {%>    
                                    <div class="tab-pane" id="attachment_complement"> 
                                        <% }%> 
                                        <br/><br/>
                                        <!-- Attachments Success & Error Display -->

                                        <% if (successAttachMsg != null) {%>

                                        <div class="alert alert-info" role="alert">
                                            <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                            <%=successAttachMsg%>
                                        </div>

                                        <% }%>
                                        <% if (errorAttachMsg != null) {%>

                                        <div class="alert alert-danger" role="alert">
                                            <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
                                            <%=errorAttachMsg%>
                                        </div>

                                        <% }%>
                                        <!-- End of Attachments Success & Error Display -->
                                        <div class="panel panel-default">
                                            <div class="panel-body">
                                                <form id="uploadAttachForm" action="fileUpload.do" method="post" enctype="multipart/form-data"> 
                                                    <input type="hidden" name="workerFin" value="<%=workerFin%>"/>
                                                    <label>File Upload</label><br/>
                                                    Select file to upload: <input type="file" name="fileInput" multiple="multiple"/><br/> 
                                                    <button type="submit">Upload file</button><br/><br/>
                                                    <small class=help-block"></small>
                                                </form>
                                            </div>
                                        </div>
                                        <p class="color-header text-center">Existing Attachments</p>
                                        <%
                                            //See if there is any file
                                            ArrayList<Integer> workerAttachList = WorkerComplementsDAO.retrieveAttachmentIdsOfWorker(worker);
                                            if (workerAttachList != null && !workerAttachList.isEmpty()) {
                                        %>
                                        <!--- only if file exits -->
                                        <table class="table table-striped table-hover" id="worker_attachment">
                                            <thead bgcolor="#4c98b8">
                                                <tr>
                                                    <th class='tbl-3-col'><font color="#FFF">S/N</font></th>
                                                    <th class='tbl-20-col'><font color="#FFF">Name</font></th>
                                                    <th class='tbl-20-col'><font color="#FFF">Date & Time uploaded</font></th>
                                                    <th class='tbl-20-col'><font color="#FFF">Upload By</font></th>
                                                    <th class="tbl-35-col"><font color="#FFF">Actions</font></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
                                                    for (int i = 0; i < workerAttachList.size(); i++) {
                                                        WorkerAttachment workerAttachment = WorkerComplementsDAO.retrieveAttachmentDetailsById(workerAttachList.get(i));
                                                        String docName = workerAttachment.getDocumentName();
                                                        java.sql.Timestamp timeStamp = WorkerComplementsDAO.retrieveTimeStamp(workerAttachment);
                                                        String submitBy = workerAttachment.getSubmitBy();
                                                %>
                                                <tr bgcolor="">
                                                    <td class="tbl-3-col"><%=i + 1%></td>
                                                    <td class="tbl-20-col"><%=docName%></td>
                                                    <td class="tbl-20-col"><%=sdf2.format(timeStamp)%></td>
                                                    <td class="tbl-20-col"><%=submitBy%></td>
                                                    <td class="tbl-35-col">
                                                        <% String extension = docName.substring(docName.lastIndexOf(".") + 1);
                                                            if (extension.equalsIgnoreCase("jpeg") || extension.equalsIgnoreCase("jpg")
                                                                    || extension.equalsIgnoreCase("png") || extension.equalsIgnoreCase("bmp")) {
                                                                if (worker.getPhotoPath() == null || !worker.getPhotoPath().equals(workerAttachment.getFilePath())) {%>
                                                        <a style="color: black" href="#" class="photo_popup" data-docpath='<%=workerAttachment.getFilePath()%>'
                                                           data-id='<%=workerAttachment.getId()%>' data-toggle="modal" data-target="#attach_photo_confirm">
                                                            <span data-toggle="tooltip" title="Make as Profile Picture" class="glyphicon glyphicon-user"></span>
                                                        </a>&nbsp; &nbsp; &nbsp; &nbsp;  
                                                        <%  }
                                                            }%>
                                                        <a style="color: black"
                                                           href="fileUpload.do?action=download&attachId=<%=workerAttachment.getId()%>" >
                                                            <span data-toggle="tooltip" title="Download" class="glyphicon glyphicon-download-alt"></span>
                                                        </a>&nbsp; &nbsp; &nbsp; &nbsp;
                                                        <a style="color: black" href="#" class="edit_popup" data-doc='<%=docName.substring(0, docName.indexOf("."))%>'
                                                           data-id='<%=workerAttachment.getId()%>' data-toggle="modal" data-target="#attach_edit_popup">
                                                            <span data-toggle="tooltip" title="Rename" class="glyphicon glyphicon-pencil"></span>
                                                        </a>&nbsp; &nbsp; &nbsp; &nbsp;
                                                        <a style="color: black" href="#" class="delete_popup" data-doc='<%=docName%>'
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
                                    <!----End of Attachments Complement Tab--> 
                                </div>
                            </div>

                        </div> 

                        <div id="pop_up_content" ></div>

                        <div id="delete-dialog" title="Confirmation" visible="false">
                            <br/>
                            <p>Are you sure you want to delete this item?</p>
                            <br/>
                            <form method="POST" action="deleteComplement.do" id='delete_pop_up' class="delete_confirmation_form"  >
                                <input type="hidden" id="hidden-id" name="id" />
                                <input type="hidden" id="hidden-name" name="name"/>
                                <input type="hidden" id="hidden-complement" name="complement"/>
                                <input type="hidden" name="workerFinNum" value="<%=workerFin%>" />
                                <input type="hidden" name="jobkey" value="<%=latestJob.getJobKey()%>" />
                                <input type="hidden" name="probKey" value="<%=latestProblem.getProbKey()%>" />
                                <div class="form-group pull-right">
                                    <button type='submit' class="btn btn-blue">Okay</button>
                                    <button type='button' class='btn cancel_btn'>Cancel</button>
                                </div>
                            </form> 

                        </div>	

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
                                            Delete file
                                        </h3>
                                    </div> <!--modal-header-->
                                    <form id="deleteConfirmForm" method="post" action="fileUpload.do">
                                        <div class="modal-body">
                                            <input type="hidden" name="attachId" id="InputID" value=""/>
                                            <input type="hidden" name="action" value="delete"/>
                                            <input type="hidden" name="workerFin" value="<%=workerFin%>"/>
                                            Are you sure you want to delete this file?
                                            <label id="InputDocName" readOnly="readOnly"></label>
                                            <!--<label id="InputDocName" name="InputDocName"></label> Try Later-->
                                        </div> <!--modal body -->

                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary">Ok</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                        </div>
                                    </form>

                                </div> <!--modal content -->
                            </div> <!--modal dialog -->
                        </div> 
                        <!-- End of Confirm Attachment Delete Modal -->

                        <!-- Rename Attachment Modal -->
                        <div class="modal fade" id="attach_edit_popup" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" 
                             aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">
                                            <span aria-hidden="true">&times;</span>
                                            <span class="sr-only">Close</span>
                                        </button>
                                        <h3 class="modal-title" id="attach_pop_up_label" style="color:#2980b9" align="center">
                                            Rename file
                                        </h3>
                                    </div> <!--modal-header-->
                                    <form id="editAttachForm" method="post" action="fileUpload.do" class="form-horizontal">
                                        <div class="modal-body">

                                            <div class="form-group">
                                                <label class="col-sm-3" for="InputDocName">Old file Name</label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="InputDocName" name="fileName" readOnly="readOnly">
                                                </div>    
                                            </div>

                                            <div class="form-group">
                                                <label class="col-sm-3" for="InputDocName">New file Name<span style="color: red">*</span></label>
                                                <div class="col-sm-9">
                                                    <input type="text" class="form-control" id="InputNewFileName" name="nFileName" required>
                                                </div>    
                                            </div>

                                        </div> <!--modal body -->

                                        <div class="modal-footer">

                                            <input type="hidden" name="attachId" id="InputID" value=""/>
                                            <input type="hidden" name="action" value="edit"/>
                                            <input type="hidden" name="workerFin" value="<%=workerFin%>"/>  
                                            <button type="submit" class="btn btn-primary">Ok</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                        </div>
                                    </form>

                                </div> <!--modal content -->
                            </div> <!--modal dialog -->
                        </div>                  
                        <!-- End of Rename Attachment Modal -->

                        <!-- Photo Profile Confirm Modal -->
                        <div class="modal fade" id="attach_photo_confirm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" 
                             aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">

                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal">
                                            <span aria-hidden="true">&times;</span>
                                            <span class="sr-only">Close</span>
                                        </button>
                                        <h3 class="modal-title" id="attach_pop_up_label" style="color:#2980b9" align="center">
                                            Profile Photo
                                        </h3>
                                    </div> <!--modal-header-->
                                    <form id="photoAttachForm" method="post" action="fileUpload.do" class="form-horizontal">
                                        <div class="modal-body">

                                            Are you sure you want to set this image as profile picture? <br/><br/>

                                            <div class="fileinput-new thumbnail" style="width: 150px; height: 150px;">
                                                <img id="InputDocPath" data-src="">
                                            </div>

                                        </div> <!--modal body -->

                                        <div class="modal-footer">

                                            <input type="hidden" name="attachId" id="InputID" value=""/>
                                            <input type="hidden" name="action" value="profilepic"/>
                                            <input type="hidden" name="workerFin" value="<%=workerFin%>"/>  
                                            <button type="submit" class="btn btn-primary">Ok</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                                        </div>
                                    </form>

                                </div> <!--modal content -->
                            </div> <!--modal dialog -->
                        </div>                  
                        <!-- End of Photo Profile Confirm Modal -->
                    </div>

                </div>
            </div>
            <!--breadcrumbs-->
            <div class="col-md-offset-6" id="breadcrumb_div">
                <ol class="breadcrumb col-md-12" style="background-color: white ">
                    <li><a href="home.jsp" id="schwker_bc">Search worker</a></li>
                    <li class="active"><%=worker.getFinNumber()%></li>
                </ol>
            </div>

            <div class="col-md-offset-6" id="complement_header_tab">
                <ul class="nav nav-tabs " role="tablist" id="sub_nav_tabs">
                    <%  if (successAttachMsg != null || errorAttachMsg != null) {%>
                    <li id="worker_complement_tab" class="complement_tabs"><a href="#worker_complement" role="tab" data-toggle="tab">Worker</a></li>
                    <li id="job_complement_tab" class="complement_tabs"><a href="#job_complement" role="tab" data-toggle="tab">Job</a></li>
                    <li id="problem_complement_tab" class="complement_tabs"><a href="#problem_complement" role="tab" data-toggle="tab">Problem</a></li>
                    <li id="benefit_complement_tab" class="complement_tabs"><a href="#benefit_complement" role="tab" data-toggle="tab">Benefit</a></li>
                    <li id="attachment_complement_tab" class="complement_tabs active"><a href="#attachment_complement" role="tab" data-toggle="tab">Attachment</a></li>                
                        <%  } else {%>
                    <li id="worker_complement_tab" class="complement_tabs active"><a href="#worker_complement" role="tab" data-toggle="tab">Worker</a></li>
                    <li id="job_complement_tab" class="complement_tabs"><a href="#job_complement" role="tab" data-toggle="tab">Job</a></li>
                    <li id="problem_complement_tab" class="complement_tabs"><a href="#problem_complement" role="tab" data-toggle="tab">Problem</a></li>
                    <li id="benefit_complement_tab" class="complement_tabs"><a href="#benefit_complement" role="tab" data-toggle="tab">Benefit</a></li>
                    <li id="attachment_complement_tab" class="complement_tabs"><a href="#attachment_complement" role="tab" data-toggle="tab">Attachment</a></li>
                        <%  }%>
                </ul>
            </div>
            <script>

            $(document).on("click", ".profile_details", function() {
                var div_id = $(this).data('value');
                var div_action_val = $(this).data('action');
                var div_title = $(this).data('title');

                $("#pop_up_content").load('include/createcaseForm.jsp?workerFin=<%=workerFin%>' 
                    + "&jobkey=<%=latestJob.getJobKey()%>" + "&probkey=<%=latestProblem.getProbKey()%>" 
                    + '&profile=' + div_id + '&action=' + div_action_val).dialog({modal: true,
                    position: ['center', 80],
                    minWidth: $(window).width() * 0.5,
                    title: div_title,
                    resizable: false,
                    draggable: true, close: function() {
                        $(this).dialog('destroy');
                        $('#pop_up_content').empty();
                    }
                });

            });

            $(document).on("click", ".pop_up_open", function() {
                var div_id = $(this).data('value'); //passport 
                var div_value = $(this).data(div_id); //id
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
                    $("#pop_up_content").load('include/' + url + '?workerFin=<%=workerFin%>&' +
                            div_id + '=' + div_value + "&jobkey=<%=latestJob.getJobKey()%>" +
                            "&probkey=<%=latestProblem.getProbKey()%>&" + div_id + "=" + div_value + "&" +
                            "&action=" + div_action_val).dialog({
                        modal: true,
                        position: ['center', 80],
                        minWidth: $(window).width() * 0.5,
                        title: div_title,
                        resizable: false,
                        draggable: true,
                        close: function() {
                            $(this).dialog('destroy');
                            $('#pop_up_content').empty();
                        }
                    });
                } else if (div_action_val === 'add') {
                    $("#pop_up_content").load('include/addPopUp.jsp?workerFin=<%=workerFin%>&complement=' + div_id
                            + "&jobkey=<%=latestJob.getJobKey()%>" + "&probkey=<%=latestProblem.getProbKey()%>" +
                            "&action='add'").dialog({
                        modal: true,
                        position: ['center', 80],
                        minWidth: $(window).width() * 0.5,
                        title: div_title,
                        resizable: false,
                        draggable: true,
                        close: function() {
                            $(this).dialog('destroy');
                            $('#pop_up_content').empty();
                        }
                    });
                    //added by soemyatmayt for passing data to delete confirmation modal    
                } else if (div_action_val === 'delete') {
                    $("#hidden-name").val(div_class);
                    $("#hidden-complement").val(div_id);
                    $("#hidden-id").val(div_value);
                    $('#delete-dialog').dialog('open');
                    //return false;

                }



            });

            function referCase() {
                $("#pop_up_content").load('include/referCase.jsp?workerFin=<%=workerFin%>&jobkey=<%=latestJob.getJobKey()%>&probkey=<%=latestProblem.getProbKey()%>&user=<%= userLogin.getNricNumber()%>').dialog({
                    modal: true,
                    position: ['center', 80],
                    minWidth: $(window).width() * 0.5,
                    title: "Case Referral",
                    resizable: false,
                    draggable: true,
                    close: function() {
                        $(this).dialog('destroy');
                        $('#pop_up_content').empty();
                    }});
            }

            $(document).ready(function() {
                $('.other').hide();
                $('#delete-dialog').dialog({
                    modal: true,
                    autoOpen: false,
                    position: ['center', 80],
                    minWidth: $(window).width() * 0.5,
                    resizable: false,
                    draggable: true
                })

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

            //close the delete confirm dialog - added by soemyatmyat
            $('.cancel_btn').click(function() {
                $('#delete-dialog').dialog("close");
            });

            //ready the data in tables - added by soemyatmyat
            $(document).ready(function() {
                $('#worker_attachment').dataTable();
            });

            //passing data for attachment delete confirm - added by soemyatmyat
            $(document).on("click", '.delete_popup', function() {
                var attachId = $(this).data('id');
                var attachDocName = $(this).data('doc');
                $(".modal-body #InputID").val(attachId);
                //document.getElementById("InputDocName").innerHTML = attachDocName;
                $(".modal-body #InputDocName").val(attachDocName);
            });

            //passing data for attachment rename  - added by soemyatmyat
            $(document).on("click", '.edit_popup', function() {
                var attachId = $(this).data('id');
                var attachDocName = $(this).data('doc');
                $(".modal-footer #InputID").val(attachId);
                //document.getElementById("InputDocName").innerHTML = attachDocName;
                $(".modal-body #InputDocName").val(attachDocName);
            });

            //passing data for profile picture popup - added by soemyatmyat
            $(document).on("click", '.photo_popup', function() {
                var attachId = $(this).data('id');
                var attachDocPath = $(this).data('docpath');
                $(".modal-footer #InputID").val(attachId);
                //document.getElementById("InputDocName").innerHTML = attachDocName;
                $(".modal-body #InputDocPath").attr('src', attachDocPath);
            });

            //file size validation
            $(document).ready(function() {
                $('#uploadAttachForm').bootstrapValidator({
                    live: 'enabled',
                    icon: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        fileInput: {
                            validators: {
                                file: {
                                    extension: 'doc,docx,pdf,xls,xlsx,csv,ppt,ppts,gif,jpeg,jpg,png,bmp,css,html,htm,shtml,txt,xml',
                                    type: 'application/*,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet,application/pdf,application/vnd.openxmlformats-officedocument.presentationml.presentation,application/vnd.ms-excel,application/vnd.ms-powerpoint,image/gif,image/jpeg,image/png,image/bmp,text/css,text/html,text/plain,text/xml,text/csv',
                                    maxSize: 10 * 1024 * 1024,
                                    message: 'Please choose a valid file with a size less than 10M only. The valid file types are doc, docx, pdf, xls, xlsx, csv, ppt, ppts, gif, jpeg, jpg, bmp, css, html, htm, shtml. txt, xml.  '
                                }
                            }
                        }
                    }
                });
            })
            .on('success.form.fv', function(e) {
                e.preventDefault();
                $('#uploadAttachForm').data('formValidation').disableSubmitButtons(true);
            });

            //reset password form validation check - added by soemyatmyat 
            $(document).ready(function() {
                $('#editAttachForm').bootstrapValidator({
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        nFileName: {
                            validators: {
                                notEmpty: {
                                    message: 'The new file name cannot be empty.'
                                },
                                regexp: {
                                    regexp: /^[0-9a-z\s_]+$/i,
                                    message: 'File name can consist of alphabetical, numerical character, underscore and spaces only.'
                                },
                                stringLength: {
                                    max: 190,
                                    message: 'File name cannot be more than 190 characters.'
                                }
                            }
                        }
                    }
                });
            });

            //to reset all the fields whenever the modal is opened - added by soemyatmyat
            $('#attach_edit_popup').on('shown.bs.modal', function() {
                $('#editAttachForm').bootstrapValidator('resetForm', true);
            });

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

        </div>
    </body>
</html>
