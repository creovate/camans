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
String userName = userLogin.getFullName();
ArrayList<Problem> problemList = CaseManagementDAO.getUnassignedCases();
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
        
        <div class="col-md-10 panel-group" id="content" role="tablist" aria-multiselectable="true">
            
            <%
if(problemList.size() > 0){
            for(int i=problemList.size()-1; i >= 0; i--){
                Problem problem = problemList.get(i);
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
                WorkerSgPhNum sgPhone = WorkerComplementsDAO.retrieveWorkerSgPhNumById(idList.size()-1);
                String phNum = "-";
                if(sgPhone != null){
                    phNum = sgPhone.getPhNumber();
                }
                
                
                %>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingOne">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            Collapsible Group Item #1
                        </a>
                    </h4>
                </div>
                <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
                    <div class="panel-body">
                        <form method="post" action="assignCase.do">
                        <table>
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
                        </table>
                            <input type="hidden" name="workerFin" value="<%=workerFin%>">
                            <input type="hidden" name="userLogin" value="<%=userNric%>">
                            <input type="hidden" name="probKey" value="<%=probKey%>">
                            <button class="btn" type="submit">Take</button>
                        </form>
                    </div>
                </div>
            </div>
            <%
                
            }
}else{
    %>
            <div class="jumbotron">
  <h3>Dear, <%=userName%>!</h3>
  <p>There's no new case available now! Please check at a later time!</p>
</div>
            
            <%
}
            %>
            
        </div>
    </body>
</html>
