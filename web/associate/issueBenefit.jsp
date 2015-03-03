<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");


    User userLogin = (User) request.getSession().getAttribute("userLogin");

    ArrayList<Worker> searchWorkers = (ArrayList<Worker>) request.getSession().getAttribute("searchWorkers");
    request.getSession().removeAttribute("searchWorkers");

    String fin = (String) request.getSession().getAttribute("fin");
    request.getSession().removeAttribute("fin");



%>
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
            label{
                color: #006c9a;
            }
        </style>
    </head>
    <body>
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
                    <%
                        if (fin != null) {
                    %>
                    <input type="text" class="form-control" id="finNum" name="fin" value="<%=fin%>" placeholder="FIN Number" required>
                    <%
                    } else {
                    %>
                    <input type="text" class="form-control" id="finNum" name="fin" placeholder="FIN Number" required>
                    <%                    }
                    %>

                </div>
                <input type="hidden" name="associate" value="associate"/>
                <button type="submit" class="btn btn-blue col-xs-3">Search</button>
            </form>

        </div>
        <!-- End of Search Box -->

        <%
            if (searchWorkers != null && searchWorkers.size() > 0) {
                //there will be only one worker with this fin number
                Worker worker = searchWorkers.get(0);
                String workerName = worker.getName();
                String workerFin = worker.getFinNumber();
                ArrayList<Integer> jobIdList = JobDAO.retrieveJobIdsOfWorker(worker);
        %>
        <!-- Search Result & issue Benefits -->

        <!-- Search Result -->
        <br/>
        <!--div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 col-xs-12" id="searcResult"-->
        <div class="col-md-12 col-sm-12 col-xs-12" id="searcResult">
            <label class="col-xs-6">Worker Name</label><p class="col-xs-6"><%=workerName%></p>
            <label class="col-xs-6">FIN Number</label><p class="col-xs-6"><%=workerFin%></p>
            <label class="col-xs-6">Employer</label>
            <div class="col-xs-6">
            <select class="col-xs-6 col-md-6 form-control input-sm">
                <%
                    for (int i = jobIdList.size()-1; i >= 0; i--) {
                        Job job = JobDAO.retrieveJobByJobId(jobIdList.get(i));
                        String employer = job.getEmployerName();
                %>
            <option><%=employer%></option>
            <%                }
            %>


        </select>
            </div>
            
            
    </div>

    <!-- End of Search Result -->

    <!-- Issue Benefits -->
    <!-- End of Issue Benefits -->
    <!-- End of Search Result & issue Benefits -->
    <%        } else {
    %>
    <!-- Not Found Message & Directory -->
    <div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 col-xs-12" id="searcResult">
        <p style="color:red">Sorry! The worker (<%=fin%>) does not exist in the system.
        </p>
        <p>Do you want to create new case?</p>

        <!--To do : option buttons to create worker-->
    </div>

    <!-- End of Not Found Message & Directory -->
    <%        }
    %>



</body>
</html>
