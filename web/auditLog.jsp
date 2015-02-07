<%-- 
    Document   : auditLog
    Created on : Dec 26, 2014, 2:28:33 AM
    Author     : soemyatmyat
--%>

<%@page import="camans.entity.UserAuditLog"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.dao.UserAuditLogDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy HH:mm:ss");
    //Data collection//
    String errMsg = (String) request.getSession().getAttribute("errMsg");
    request.getSession().removeAttribute("errMsg");
    String startDateIn = (String) request.getSession().getAttribute("startDate");
    String endDateIn = (String) request.getSession().getAttribute("endDate");
    ArrayList<Integer> result = (ArrayList<Integer>) request.getSession().getAttribute("queryResult");
    request.getSession().removeAttribute("startDate");
    request.getSession().removeAttribute("endDate");
    request.getSession().removeAttribute("queryResult");
    //end of data collection//
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <!-- DataTables CSS, added by soemyatmyat -->
        <link rel="stylesheet" href="css/dataTables.bootstrap.css"/>
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
        
        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
        <!-- DataTables JS, Added by soemyatmyat -->
        <script src="js/jquery.dataTables.js"></script>
        <script src="js/dataTables.bootstrap.js"></script>            
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script>  
        
        <link rel="shortcut icon" href="img/twc_logo.png">
   
        <title>CAMANS</title>
     
    </head>
    
    <body id="auditLog" style='background:white'>
        <jsp:include page="include/navbartop.jsp"/>
        <div class="row-offcanvas row-offcanvas-left">
            <jsp:include page="include/navbarside.jsp"/> 
            <div class="col-md-offset-2 col-md-10">

                <div class="page-header">
                    <center><h2>Audit Logs</h2></center>    
                </div>
                <div class="panel panel-default">
                    <p bgcolor="#3579BC" class="color-header text-center">Search By</p>
                    <div class="panel-body">
                        <form id="searchForm" method="post" action="searchAuditLog.do">
                            <div class="row">
                                <div class="form-group col-sm-3">
                                    <label>Start Date</label>
                                    <input type="text" id="reg_StartDate_In" name="startDate" 
                                           class="form-control startDate" data-date-format="dd-mm-yyyy" 
                                           value="<%=(startDateIn==null) ? "":startDateIn%>" required>
                                </div>
                                <div class="form-group col-sm-3">
                                    <label>End Date</label>
                                    <input type="text" id="reg_EndDate_In" name="endDate" 
                                           class="form-control endDate" data-date-format="dd-mm-yyyy" 
                                           value="<%=(endDateIn==null) ? "":endDateIn%>" required>
                                </div>
                                <br/>
                                <div class="form-group col-sm-3">
                                    <button type="submit" class="btn btn-blue" id="btnSearch">Search</button>
                                    <button type="button" class="btn btn-info" style="border-radius: 2px" id="btnReset" 
                                                        type="reset" onClick="window.location.href=window.location.href">Reset</button>
                                </div>
                            </div>
                        </form>    
                    </div>
                </div>
                <!-- Audit Log Table -->
    <%
                    ArrayList<Integer> ids = new ArrayList<Integer>();
                    if (result == null) {
                        ids = UserAuditLogDAO.retrievelast7daysUserAuditLogIds();
                        out.println("<h4>Audit Logs - Last 7 days records</h4>");
                    } else {
                        ids = result;
                        if (!ids.isEmpty()) {
                            out.println("<h4>Audit Logs - Search Results</h4>");
                        }
                    }            
    %>
                <!--<div class="panel panel-default">
                    <div class="panel-body">-->       
                        <table class="table table-bordered table-hover col-md-12" id="auditLogs-table">
                            <thead bgcolor="#4c98b8">
                                <tr>
                                    <th style="width: 7vw" class="text-center"><font color="#FFF">Date & Time</font></th>
                                    <th class="col-md-1 text-center"><font color="#FFF">Username</font></th>
                                    <th class="col-md-1 text-center"><font color="#FFF">Worker Fin Number</font></th>
                                    <th class="col-md-1 text-center"><font color="#FFF">Action Type</font></th>
                                    <th class="text-center"><font color="#FFF">Action Description</font></th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (!ids.isEmpty()) {
                                        for (int i = 0; i < ids.size(); i++) {
                                            UserAuditLog userAuditLog = UserAuditLogDAO.retrieveUserAduitLogById(ids.get(i));
                                            java.sql.Timestamp timeStamp = UserAuditLogDAO.retrieveTimeStamp(userAuditLog);
                                            String username = userAuditLog.getUsername();
                                            String workerFinNum = userAuditLog.getWorkerFin();
                                            String actionType = userAuditLog.getActionType();
                                            String actionDesc = userAuditLog.getActionDesc();

                                    %>
                                        <tr>
                                            <!--<td><%=ids.get(i)%></td>-->
                                            <td><%=sdf.format(timeStamp)%></td>
                                            <td><%=username%></td>
                                            <td><%=workerFinNum%></td>
                                            <td><%=actionType%></td>
                                            <td><%=actionDesc%></td>
                                        </tr>
                                <%      }
                                    }   %>
                            </tbody>
                        </table>
                    <!--</div> //panel body
                </div>//panel -->
                <!-- End of Users Table -->    

            </div>                 
        </div>             
        <script>
            //session time out
            $(document).ready(function () {
                $.sessionTimeout({
                    message: 'Your session will be expired in one minute.',
                    keepAliveUrl: 'keep-alive.html',
                    logoutUrl: 'index.jsp',
                    redirUrl: 'logout.jsp',
                    warnAfter: 900000,
                    redirAfter: 960000
                });
            });
            
            
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
            
            $(document).ready(function() {
                $('#auditLogs-table').dataTable( {
                    aaSorting: [[0,'desc']]
                } );
            } );
            
            
        </script>
        
    </body>
</html>
    