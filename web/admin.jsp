<%--
    Document   : admin
    Created on : Jan 7, 2015, 4:22:18 PM
    Author     : soemyatmyat
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    //HashMap<String, ArrayList<String>> errList = (HashMap<String, ArrayList<String>>) request.getSession().getAttribute("bootstrapResult");
    //request.getSession().removeAttribute("bootstrapResult");
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
            
            <div class="row">
                <div class="col-xs-6">
                    <h3 style="color:#2980b9">Bootstrap</h3><br>
                    <form id="" method="post" action="processBootstrap" enctype="multipart/form-data">           
                        Select file to upload: <input type="file" name="zip" accept="application/zip"/><br>                                   
                        To bootstrap, please select a ZIP file <br>then click on Load Data.<br/><br/>                    
                        <button class="btn btn-primary" type="submit">Load Data</button>

                    </form>
                    <br/>
                </div> 
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
                        <h3 class="modal-title" id="myModalLabel">Bootstrap     
                        <% /*
                            if (errList == null || errList.isEmpty()) {
                                out.println("<font color=\"green\">Successful</font></h3>");
                            } else {
                                out.println("<font color=\"red\">Successful with following errors</font></h3>");
                            } */   
                        %>
                    </div> <!--header -->
                    <div class="modal-body"> 

                        <!-- record loaded -->
                        <table class="table table-curved table-hover table-condensed">                                         
                            <th style="text-align:center;">File Name</th>
                            <th style="text-align:center;">Records Loaded</th>                                          
                        </table>
                        
                        <div class="panel-group" id="accordion">

                        </div> <%--end accordion--%>
 
                    </div> <!--body-->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>                                
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->

        <% //if (errList != null) {%>                
        <script>
                    $(window).load(function() {
                        $('#myModal').modal('show');
                    });
        </script>
        <%// } %>
        <script>
            //session time out
            $(document).ready(function () {
                $.sessionTimeout({
                    message: 'Your session will be expired in one minute.',
                    keepAliveUrl: 'keep-alive.html',
                    logoutUrl: 'index.jsp',
                    redirUrl: 'logout.jsp',
                    warnAfter: 900000,
                    redirAfter: 120000
                });
            });
        </script>
    </body>
</html>
