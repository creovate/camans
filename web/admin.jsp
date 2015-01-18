<%--
    Document   : admin
    Created on : Jan 7, 2015, 4:22:18 PM
    Author     : soemyatmyat
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HashMap<String, ArrayList<String>> errList = (HashMap<String, ArrayList<String>>) request.getSession().getAttribute("bootstrapResult");
    request.getSession().removeAttribute("bootstrapResult");
    HashMap<String, Integer> successList = (HashMap<String, Integer>) request.getSession().getAttribute("successList");
    request.getSession().removeAttribute("successList");
    String error = (String) request.getSession().getAttribute("error");
    request.getSession().removeAttribute("error");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />
        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
          
        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>         
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script> 
        
        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>Camans</title>
    </head>
    <body>
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>
        <div class="col-md-10">
            
            <!-- Page Header -->
            <div class="page-header">
            <center><h2 style="color:#2980b9">Administration <small> Dashboard</small></h2>   
            </div>
            <!-- end of page header -->
            
            <div class="row">
                <!-- bootstrap -->
                <div class="col-xs-6">
                    <h3 style="color:#2980b9">Bootstrap</h3><br>
                    <form id="" method="post" action="processBootstrap" enctype="multipart/form-data">           
                        Select file to upload: <input type="file" name="zip" accept="application/zip"/><br>                                   
                        To bootstrap, please select a ZIP file <br>then click on Load Data.<br/><br/>                    
                        <button class="btn btn-primary" type="submit">Load Data</button>
                        <% if (errList != null) {%>
                        <!-- Show View Results Button to trigger modal if response is not null -->
                        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#myModal">
                            View Results
                        </button>
                        <% }%>
                    </form>
                    <br/><font color ="red"><%=(error==null)?"":error%></font>
                    <br/>
                </div> 
                <!-- end of bootstrap -->
                <div class="col-xs-6">
                    <h3 style="color:#2980b9">Import/ Export Data</h3><br/>
                </div>
            </div>
            
        </div>
        
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <label class="modal-title" id="myModalLabel">Bootstrap     
                        <% 
                            if (errList == null || errList.isEmpty()) {
                                out.println("<font color=\"green\">Successful</font></label>");
                            } else {
                                out.println("<font color=\"red\">Successful with following errors</font></label>");
                            }    
                        %>
                    </div> <!--header -->
                    <div class="modal-body"> 

                        <!-- record loaded -->
                        <table class="table table-curved table-hover table-condensed">                                         
                            <tr><th style="text-align:center;">File Name</th>
                            <th style="text-align:center;">Records Loaded</th></tr>
<%                          if (successList != null && !successList.isEmpty()) {
                                for (String fileName: successList.keySet()) {
                                    int recordsLoaded = successList.get(fileName);
%>
                                    <tr><td style="text-align:center;"><%=fileName%></td>
                                    <td style="text-align:center;"><%=recordsLoaded%></td></tr>
<%                            }
                            }    
%>                            
                        </table>
                        
                        <div class="panel-group" id="accordion">
<%
                            if (errList != null && !errList.isEmpty()) {
                                for (String key: errList.keySet()) {
                                    ArrayList<String> errArray = errList.get(key);
                                    String tmp = key.substring(0, key.indexOf("."));
%>
                                <div class="panel panel-warning">
                                    <div class="panel-heading">
                                        <h4 class="panel-title">
                                            <a class="accordion-toggle"  data-toggle="collapse" data-target="#<%=tmp%>" href="#">
                                                <b><%=key%> (<%=errArray.size()%> errors)</b>
                                            </a>
                                        </h4>
                                    </div> <!--heading-->
                                </div> <!--panel default-->
                                
                                <div id="<%=tmp%>" class="panel-collapse collapse">
                                    <div class="panel-body">
                                        <table class="table table-curved table-hover table-condensed">
<%
                                            for (int i = 0; i < errArray.size(); i++) {
                                                String errDesc = errArray.get(i);
                                                String lineNum = errDesc.substring(0,errDesc.indexOf(":"));
                                                String errMsg = errDesc.substring(errDesc.indexOf(":")+1,errDesc.lastIndexOf(","));
%>                                      
                                                <tr><td><b>Line <%=lineNum%></b></td><td><%=errMsg%></td></tr>
<%
                                           }
%>
                                        </table>
                                    </div> <!-- panel body -->
                                </div>
<%
                                }
                            }
%>
                        </div> <%--end accordion--%>
 
                    </div> <!--body-->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>                                
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <% if (successList != null) {%>                
        <script>
                    $(window).load(function() {
                        $('#myModal').modal('show');
                    });
        </script>
        <% } %>
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
        </script>
    </body>
</html>
