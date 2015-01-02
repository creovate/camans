<%-- 
    Document   : caseReferral
    Created on : Dec 18, 2014, 1:12:49 PM
    Author     : Nyein Su
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    User userLogin = (User) request.getSession().getAttribute("userLogin");
    String userNric = userLogin.getNricNumber();
    String username = userLogin.getUsername();
    String userFullName = userLogin.getFullName();
    ArrayList<Problem> problemList = CaseManagementDAO.retrieveUnassignedCases();

    ArrayList<Problem> recentAssignedProblems = CaseManagementDAO.retrieveRecentAssignedCases(userNric);
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
        <link rel="stylesheet" href="css/jquery-ui-1.9.2.custom.css">

        <link rel="stylesheet" href="css/jquery-ui.structure.css">
        <link rel="stylesheet" href="css/jquery-ui.theme.css">

        <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>
        <!--jasny-bootstrap v3.1.3, added by soemyatmayt-->
        <link rel="stylesheet" href="css/jasny-bootstrap.css"/>
        <!-- DataTables CSS, added by soemyatmyat -->
        <link rel="stylesheet" href="css/dataTables.bootstrap.css"/>

        <script src="js/jquery-2.1.3.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery-ui-1.9.2.custom.js"></script>
        <script src="js/jquery.steps.js"></script>
        <script src="jquery.ui.position.js"></script>
        <script type="text/javascript" src="js/bootstrapValidator.min.js"></script>        
        <!--jasny-bootstrap v3.1.3, added by soemyatmyat-->
        <script src="js/jasny-bootstrap.js"></script>  
        <!-- DataTables JS, Added by soemyatmyat -->
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>

        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>Case Referral</title>
    </head>
    <body>
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>

        <div class="col-md-10 panel-group" id="referredCase" role="tablist" aria-multiselectable="true">

            <%
                if (problemList != null && problemList.size() > 0) {

            %>
            <h3>Referred Cases</h3>
            <%
                for (int i = problemList.size() - 1; i >= 0; i--) {
                    Problem problem = problemList.get(i);

                    String referredByFin = problem.getReferredBy();
                    User referredByUser = UserDAO.retrieveUserByNRIC(referredByFin);
                    String referredByFullName = referredByUser.getFullName();
                    java.util.Date referredDate = problem.getReferredDate();
                    String refDescription = problem.getReferralDescription();

                    String workerFin = problem.getWorkerFinNum();
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
                    String workerName = worker.getName();
                    int probKey = problem.getProbKey();
                    int jobKey = problem.getJobKey();
                    Job job = JobDAO.retrieveJobByJobId(jobKey);
                    String empName = job.getEmployerName();
                    String jobStartDate = job.getJobStartDate();
                    String chiefProb = problem.getProblem();
                    java.util.Date probRegDate = problem.getProblemRegisteredDate();
                    ArrayList<Integer> idList = WorkerComplementsDAO.retrieveSgCountryPhoneNumIdsOfWorker(worker);
                    WorkerSgPhNum sgPhone = WorkerComplementsDAO.retrieveWorkerSgPhNumById(idList.size() - 1);
                    String phNum = "-";
                    if (sgPhone != null) {
                        phNum = sgPhone.getPhNumber();
                    }
            %>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingOne">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapse<%=i%>" aria-expanded="true" aria-controls="collapse<%=i%>">
                            Case Referred By : <%=referredByFullName%> <p class="pull-right">Referred Date : <%= referredDate%></p>
                        </a>
                    </h4>
                </div>

                <%
                    if (i == problemList.size() - 1) {
                %>
                <div id="collapse<%=i%>" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                    <%                } else {
                    %>
                    <div id="collapse<%=i%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <%                    }
                        %>

                        <div class="panel-body">
                            <form method="post" action="assignCase.do">
                                <table class="col-md-12 table table-condensed pull-left">
                                    <tr>
                                        <td class="col-md-6">Referee: </td>
                                        <td><%=referredByFullName%></td>
                                    </tr>
                                    <tr>
                                        <td>Referred Date: </td>
                                        <td><%=referredDate%></td>
                                    </tr>
                                    <tr>
                                        <td>Worker Name: </td>
                                        <td><%=workerName%></td>
                                    </tr>
                                    <tr>
                                        <td>Worker FIN Number: </td>
                                        <td><%=workerFin%></td>
                                    </tr>
                                    <tr>
                                        <td>Worker's Phone Number: </td>
                                        <td><%=phNum%></td>
                                    </tr>
                                    <tr>
                                        <td>Employer: </td>
                                        <td><%=empName%></td>
                                    </tr>
                                    <tr>
                                        <td>Chief Problem: </td>
                                        <td><%=chiefProb%></td>
                                    </tr>
                                    <tr>
                                        <td>Brief Description: </td>
                                        <td><%=(refDescription == null) ? "-" : refDescription%></td>
                                    </tr>
                                </table>
                                <input type="hidden" name="workerFin" value="<%=workerFin%>">
                                <input type="hidden" name="userLogin" value="<%=username%>">
                                <input type="hidden" name="probKey" value="<%=probKey%>">
                                <button class="btn pull-right" type="submit">Take</button>
                            </form>
                        </div>
                    </div>
                </div>
                <%

                    }
                } else {
                %>
                <div class="jumbotron">
                    <h3>Dear, <%=userFullName%>!</h3>
                    <p>There's no new case available now! Please check at a later time!</p>
                </div>

                <%
                    }
                %>

            </div>
        </div>

        <div class="col-md-10 panel-group" id="recentAssingedCases" role="tablist" aria-multiselectable="true">

            <%
                if (recentAssignedProblems != null && recentAssignedProblems.size() > 0) {

            %>
            <h3>Recently Taken Cases</h3>
            <%
                for (int i = recentAssignedProblems.size() - 1; i >= 0; i--) {
                    Problem problem = recentAssignedProblems.get(i);

                    String referredByUsername = problem.getReferredBy();
                    User referredByUser = UserDAO.retrieveUserByUsername(referredByUsername);
                    String referredByFullName = referredByUser.getFullName();
                    java.util.Date referredDate = problem.getReferredDate();
                    String refDescription = problem.getReferralDescription();

                    String workerFin = problem.getWorkerFinNum();
                    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
                    String workerName = worker.getName();
                    int probKey = problem.getProbKey();
                    int jobKey = problem.getJobKey();
                    Job job = JobDAO.retrieveJobByJobId(jobKey);
                    String empName = job.getEmployerName();
                    String jobStartDate = job.getJobStartDate();
                    String chiefProb = problem.getProblem();
                    java.util.Date probRegDate = problem.getProblemRegisteredDate();
                    ArrayList<Integer> idList = WorkerComplementsDAO.retrieveSgCountryPhoneNumIdsOfWorker(worker);
                    WorkerSgPhNum sgPhone = WorkerComplementsDAO.retrieveWorkerSgPhNumById(idList.size() - 1);
                    String phNum = "-";
                    if (sgPhone != null) {
                        phNum = sgPhone.getPhNumber();
                    }
            %>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingOne">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#recent<%=i%>" aria-expanded="true" aria-controls="recent<%=i%>">
                            Case Referred By : <%=referredByFullName%> <p class="pull-right">Referred Date : <%= referredDate%></p>
                        </a>
                    </h4>
                </div>

                <%
                    if (i == recentAssignedProblems.size() - 1) {
                %>
                <div id="recent<%=i%>" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                    <%                } else {
                    %>
                    <div id="recent<%=i%>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                        <%                    }
                        %>

                        <div class="panel-body">
                            <table class="col-md-12 table table-condensed pull-left">
                                <tr>
                                    <td class="col-md-6">Referee: </td>
                                    <td><%=referredByFullName%></td>
                                </tr>
                                <tr>
                                    <td>Referred Date: </td>
                                    <td><%=referredDate%></td>
                                </tr>
                                <tr>
                                    <td>Worker Name: </td>
                                    <td><%=workerName%></td>
                                </tr>
                                <tr>
                                    <td>Worker FIN Number: </td>
                                    <td><%=workerFin%></td>
                                </tr>
                                <tr>
                                    <td>Worker's Phone Number: </td>
                                    <td><%=phNum%></td>
                                </tr>
                                <tr>
                                    <td>Employer: </td>
                                    <td><%=empName%></td>
                                </tr>
                                <tr>
                                    <td>Chief Problem: </td>
                                    <td><%=chiefProb%></td>
                                </tr>
                                <tr>
                                    <td>Brief Description: </td>
                                    <td><%=(refDescription == null) ? "-" : refDescription%></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <%

                    }
                } else {
                %>
                <div class="jumbotron">
                    <h3>Dear, <%=userFullName%>!</h3>
                    <p>You haven't taken any cases in the past month.</p>
                </div>

                <%
                    }
                %>

            </div>
        </div>
    </body>
</html>
