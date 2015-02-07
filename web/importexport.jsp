<%--
    Document   : importexport
    Created on : Jan 7, 2015, 4:22:18 PM
    Author     : soemyatmyat
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HashMap<String, Integer> errList = (HashMap<String, Integer>) request.getSession().getAttribute("bootstrapResult");
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
        <title>CAMANS</title>
    </head>
    <body id="importexport">
        <jsp:include page="include/navbartop.jsp"/>
        <div class="row-offcanvas row-offcanvas-left">
            <jsp:include page="include/navbarside.jsp"/>
            <div class="col-md-offset-2 col-md-10">

                <!-- Page Header -->
                <div class="page-header">
                <center><h2>Import/Export Dashboard</h2>   
                </div>
                <!-- end of page header -->

                <div class="row">
                    <!-- bootstrap -->
                    <div class="col-md-6">
                        <h3 style="color:#2980b9">Data Import</h3><br>
                        <!--<form id="" method="post" action="processBootstrap" enctype="multipart/form-data">-->  
                            <!--
                            Please choose whether you wish to <b>append the data (Import)</b><br/> or <b>clear the database and upload new sets of data (Bootstrap)</b>.<br/><br/>
                           
                            <input type="radio" name="import" value="bootstrap"> Bootstrap
                            <input type="radio" name="import" value="import" checked="check"> Import<br/><br/>
                            -->
                       <form id="" method="post" action="processBootstrap" enctype="multipart/form-data">      
                            Select file to upload: <input type="file" name="zip" accept="application/zip"/><br/>                                   
                            To upload, please select a ZIP file then click on Load Data.<br/><br/>                    
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
                    <div class="col-md-6">
                        <form name="exportform" method="post" action="exportData.do">
                            <h3 style="color:#2980b9">Data Export</h3>
                        
                            <div class="col-xs-6">
                                <label>Main</label><br/>
                                <input type="checkbox" name="select" value="worker" />&nbsp;Worker&nbsp;
                                <input type="checkbox" name="select" value="benefit" />&nbsp;Benefits<br/>
                                <input type="checkbox" name="select" value="job" />&nbsp;Job&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="checkbox" name="select" value="audit" />&nbsp;Audit Logs<br/>
                                <input type="checkbox" name="select" value="problem" />&nbsp;Problem<br/><br/>
                         
                                <label>Problem Complements</label><br/>
                                <input type="checkbox" name="select" value="aggravatingissue" />&nbsp;Aggravating Issues<br/>
                                <input type="checkbox" name="select" value="leadcaseworker" />&nbsp;Lead Case Workers<br/>
                                <input type="checkbox" name="select" value="auxiliarycaseworker" />&nbsp;Auxiliary Case Workers<br/>
                                <input type="checkbox" name="select" value="salaryrelatedhistory" />&nbsp;Salary History<br/>
                                <input type="checkbox" name="select" value="injury" />&nbsp;Injury<br/>
                                <input type="checkbox" name="select" value="illness" />&nbsp;Illness<br/>
                                <input type="checkbox" name="select" value="otherproblems" />&nbsp;Other problems<br/>
                                <input type="checkbox" name="select" value="salaryclaim" />&nbsp;Salary Claimed Lodged<br/>
                                <input type="checkbox" name="select" value="wica" />&nbsp;WICA<br/>
                                <input type="checkbox" name="select" value="wicaclaim" />&nbsp;WICA Claims<br/>
                                <input type="checkbox" name="select" value="nonwicaclaim" />&nbsp;Non-WICA Claims<br/>
                                <input type="checkbox" name="select" value="policereport" />&nbsp;Police Reports<br/>
                                <input type="checkbox" name="select" value="othercomplaints" />&nbsp;Other Complaints<br/>
                                <input type="checkbox" name="select" value="casediscussion" />&nbsp;Case Discussions<br/>
                                <input type="checkbox" name="select" value="hospital" />&nbsp;Hospitals<br/>
                                <input type="checkbox" name="select" value="mcstatus" />&nbsp;MC Status<br/>
                                <input type="checkbox" name="select" value="r2r" />&nbsp;R2R<br/>
                                <input type="checkbox" name="select" value="lawyer" />&nbsp;Lawyers<br/>
                                <input type="checkbox" name="select" value="casemilestonenc" />&nbsp;Non-criminal Case Milestones<br/>
                                <input type="checkbox" name="select" value="casemilestonecr" />&nbsp;Criminal Case Milestones<br/>
                                <input type="checkbox" name="select" value="ttr" />&nbsp;TTR<br/>
                            </div> <!-- end col -->
                            
                            <div class="col-xs-6">
                                <!--<button class="btn btn-info check">Check All</button> -->
                                <input type="button" class="btn btn-info" name="checkbutton" value="Check All" onClick="Check(document.exportform.select)" />
                                <button class="btn btn-primary" type="submit">Export</button><br/><br/>
                                <label>Worker Complements</label><br/>
                                <input type="checkbox" name="select" value="nickname" />&nbsp;Nickname<br/>
                                <input type="checkbox" name="select" value="passport" />&nbsp;Passport Details<br/>
                                <input type="checkbox" name="select" value="homecountryph" />&nbsp;Home Country Phone Number<br/>
                                <input type="checkbox" name="select" value="homecountryaddress" />&nbsp;Home Country Address<br/>
                                <input type="checkbox" name="select" value="sgph" />&nbsp;Singapore Phone Number<br/>
                                <input type="checkbox" name="select" value="sgaddress" />&nbsp;Singapore Address<br/>
                                <input type="checkbox" name="select" value="digitalcontact" />&nbsp;Digital Contact<br/>
                                <input type="checkbox" name="select" value="nextofkin" />&nbsp;Next of Kins<br/>
                                <input type="checkbox" name="select" value="familymember" />&nbsp;Family Members<br/>
                                <input type="checkbox" name="select" value="sgfriend" />&nbsp;Singapore Friends<br/>
                                <input type="checkbox" name="select" value="language" />&nbsp;Language<br/>
                                <input type="checkbox" name="select" value="bankacct" />&nbsp;Bank Account Details<br/><br/>
                                <label>Job Complements</label><br/>
                                <input type="checkbox" name="select" value="currentpass" />&nbsp;Current Pass Details<br/>
                                <input type="checkbox" name="select" value="ipa" />&nbsp;IPA Pass Details<br/>
                                <input type="checkbox" name="select" value="verbalassurance" />&nbsp;Verbal Assurance Details<br/>
                                <input type="checkbox" name="select" value="employmentcontract" />&nbsp;Employment Contract Details<br/>
                                <input type="checkbox" name="select" value="intermediaryagent" />&nbsp;Intermediary Agents<br/>
                                <input type="checkbox" name="select" value="employer" />&nbsp;Employer Details<br/>
                                <input type="checkbox" name="select" value="workplace" />&nbsp;Work Place<br/>
                                <input type="checkbox" name="select" value="workhistory" />&nbsp;Work History<br/>
                                <input type="checkbox" name="select" value="accomodation" />&nbsp;Accommodation<br/><br/>
                            </div>
                            </div>
                        </form>
                    </div> <!--row-->
                </div> <!--fixed paged length-->

            </div> <!--wrap-->
        
        </div>
        <!-- Modal for Record Loaded -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <label class="modal-title" id="myModalLabel">Data Import <font color="green">Successful </font> 
                        <% 
                            if (errList != null) {
                                if (!errList.isEmpty()){
                                    out.println("with <font color=\"red\">errors</font></label>");
                                }
                            }   
                        %>
                        </label>
                    </div> <!--header -->
                    <div class="modal-body"> 

                        <!-- record loaded -->
                        <table class="table table-curved table-hover table-condensed">                                         
                            <tr><th style="text-align:center;">File Name</th>
                            <th style="text-align:center;">Records Loaded</th>
                            <th style="text-align:center;">Errors Count</th></tr>
<%                          if (successList != null && !successList.isEmpty()) {
                                for (String fileName: successList.keySet()) {
                                    int recordsLoaded = successList.get(fileName);
                                    int errCount = 0;
                                    if (errList != null & !errList.isEmpty() & errList.containsKey(fileName)) {
                                        errCount = errList.get(fileName);
                                    }
%>
                                    <tr><td style="text-align:center;"><%=fileName%></td>
                                    <td style="text-align:center;"><%=recordsLoaded%></td>
                                    <td style="text-align:center;color:red"><%=errCount%></td></tr>
<%                            }
                            }    
%>                            
                        </table>
                        
                        <a href="fileUpload.do?action=downloaderrzipfile"><b>Download the error files heres.</b></a>
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
            
            function Check(chk) {
                if (document.exportform.checkbutton.value=="Check All") {
                    for (i = 0; i < chk.length; i++) {
                        chk[i].checked = true;
                        document.exportform.checkbutton.value="UnCheck All";
                    }
                } else {
                    for (i = 0; i < chk.length; i++) {
                        chk[i].checked = false;
                        document.exportform.checkbutton.value="Check All";
                    }
                }
            }
            
            $(document).ready(function () {
                //session timeout
                
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
