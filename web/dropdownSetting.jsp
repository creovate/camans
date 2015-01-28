<%-- 
    Document   : dropdownSetting
    Created on : Dec 29, 2014, 2:40:15 PM
    Author     : soemyatmyat
--%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page import="camans.entity.Dropdown"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="protect.jsp"%>
<%
    ArrayList<String> dropdownType = DropdownDAO.retrieveAllDropdownType();
    String dropdownname = request.getParameter("name");
    if (dropdownname == null) {
        dropdownname = "Accommodation_type";
    }
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
        <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script> 
        
        <link rel="shortcut icon" href="img/twc_logo.png">
        
        <title>CAMANS</title>    
    </head>
<style>
    ul.ul-sortable {
        margin: 0;
        padding: 0;
        width: 20em;
        float: left;
    }

    ul.ul-sortable li {
        border: 0;
        padding: 0.2em;
        margin-bottom: 0.2em;
        border: 1px solid #CCC;
        list-style-type: none;
        cursor: move;
    }

</style>
    <body>
        <jsp:include page="include/navbartop.jsp"/>
        <div class="row-offcanvas row-offcanvas-left" style="padding:1% 0% 0%;">
            <jsp:include page="include/navbarside.jsp"/>

            <div class="col-md-10">
                <!--Page Header-->
                <div class="page-header">
                    <center><h2 style="color:#2980b9">Configure Dropdown Settings</h2></center>    
                </div>
                <!-- End of Page Header -->
                <%
                    String type = dropdownname;
                    ArrayList<String> list = null;
                    if (type.startsWith("Bene_type")) {
                        if (type.endsWith("food")) {
                            list = DropdownDAO.retreiveAllDropdownListOfBenefits("Food");
                        } else if (type.endsWith("medical")) {
                            list = DropdownDAO.retreiveAllDropdownListOfBenefits("Medical & Karunya");
                        } else if (type.endsWith("roof")) {
                            list = DropdownDAO.retreiveAllDropdownListOfBenefits("Roof");
                        } else if (type.endsWith("transport")) {
                            list = DropdownDAO.retreiveAllDropdownListOfBenefits("Transport");
                        } else if (type.endsWith("other")) {
                            list = DropdownDAO.retreiveAllDropdownListOfBenefits("Other");
                        }
                    } else {
                        if (type == null) {
                            type = "Accommodation_type";
                        }
                        list = DropdownDAO.retrieveAllDropdownListByType(type);
                    }    
                    String title = "Accommodation Type";
                    String successMsg = (String) request.getSession().getAttribute("successMsg");
                    request.getSession().removeAttribute("successMsg");
                    String errMsg = (String) request.getSession().getAttribute("errMsg");
                    request.getSession().removeAttribute("errMsg");
                %>
                <!-- success & error display -->
                <% if (successMsg != null)  { %>

                 <div class="alert alert-info" role="alert">
                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                    <%=successMsg%>
                </div>

                <% } %>

                <% if (errMsg != null)  { %>

                 <div class="alert alert-danger" role="alert">
                    <a href="#" class="close" data-dismiss="alert">&times;</a>
                    <%=errMsg%>
                </div>

                <% } %>
                <div id="panelbox" class="col-md-6">
                <%
                        if (title != null) {
                %>

                    <!--Panel Box-->
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-12 text-center">
                                    <b><%=type%></b>
                                </div>
                            </div>
                        </div> <!--heading-->
                        <div class="panel-body">
                            <form id="deleteItems" method="post" action="dropdownProcess.do" class="form-horizontal">
                            <div class="row">
                                <div class="col-xs-12 text-center">
                                    <button type="submit" class="btn btn-primary">Delete Selected</button>
                                    <button type="button" class="btn btn-primary add_new_item" data-toggle="modal" data-target="#add_new_item" 
                                            data-type='<%=type%>' data-rank='<%=list.size()+1%>'>
                                        <span data-toggle="tooltip" title="Add" class="glyphicon glyphicon-plus"></span>&nbsp;Add New
                                    </button>
                                    <button type="button" class="btn btn-primary" id="save" onclick="saveChanges()">Save Ordering</button>
                                    <br/><br/>
                                </div> 
                            </div> <!--row1-->
                            <div class="row">
                                <div class="col-xs-9 pull-right">
                                    <ul class="ul-sortable" id="sortable">
                                        <%
                                            for (String str: list) {
                                                Dropdown dropdown = null;
                                                if (type.startsWith("Bene_type")) {
                                                    dropdown = DropdownDAO.retrieveDropdownItem("Bene_type", str);
                                                } else {
                                                    dropdown = DropdownDAO.retrieveDropdownItem(type, str);
                                                }
                                                int id = dropdown.getId();
                                        %>
                                        <li id="item-<%=id%>"><input type="checkbox" name="select" value=<%=id%> />&nbsp;<%=str%></li>
                                        <%  }   %>
                                    </ul>
                                </div>
                            </div> <!--row2-->
                                <input type="hidden" name="name" value="<%=type%>"/>
                                <input type="hidden" name="action" value="delete"/>
                            </form>
                        </div> <!--panel body-->
                    </div>    <!--panel primary-->  
                    <!--End of Panel -->
                <%    
                     }
                %>               
                </div> <!--col-md-6-->
                 <div class="col-xs-4 text-left pull-right">
                     
                 Please Choose the drop-down type from here.<br/>
                 <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                 <%
                 if (type.equals("Accommodation_type")) { 
                    out.println("Accommodation Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Accommodation_type">Accommodation Type</a><br/>            
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Accom_provided_type")) { 
                    out.println("Accommodation Provided Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Accom_provided_type">Accommodation Provided Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Agent_location_type")) { 
                    out.println("Agent Location Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Agent_location_type">Agent Location Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Bene_type_food")) { 
                    out.println("Benefit Type (Food)<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Bene_type_food">Benefit Type (Food)</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Bene_type_medical")) { 
                    out.println("Benefit Type (Medical & Karunya)<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Bene_type_medical">Benefit Type (Medical & Karunya)</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Bene_type_roof")) { 
                    out.println("Benefit Type (Roof)<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Bene_type_roof">Benefit Type (Roof)</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Bene_type_transport")) { 
                    out.println("Benefit Type (Transport)<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Bene_type_transport">Benefit Type (Transport)</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Bene_type_other")) { 
                    out.println("Benefit Type (Other)<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Bene_type_other">Benefit Type (Other)</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Complaint_mode_type")) { 
                    out.println("Complaint Mode Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Complaint_mode_type">Complaint Mode Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Complaint_type")) { 
                    out.println("Complaint Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Complaint_type">Complaint Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Casemilestone_criminal_type")) { 
                    out.println("Criminal Mile Stone<br/>");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Casemilestone_criminal_type">Criminal Mile Stone</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Pass_type")) { 
                    out.println("Current Pass Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Pass_type">Current Pass Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("DigitalType")) { 
                    out.println("Digital Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=DigitalType">Digital Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Discuss_where_type")) { 
                    out.println("Discuss where Type<br/>");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Discuss_where_type">Discuss where Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Hospital_name")) { 
                    out.println("Hospital Name<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Hospital_name">Hospital Name</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("IPA_pass_type")) { 
                    out.println("IPA Pass Type<br/>");
                    } else { %>
                <a href="dropdownSetting.jsp?name=IPA_pass_type">IPA Pass Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Job_sector_type")) { 
                    out.println("Job Sector<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Job_sector_type">Job Sector</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Lawyer_firm")) { 
                    out.println("Lawyer Firm<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Lawyer_firm">Lawyer Firm</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("MainLang")) { 
                    out.println("Main Language Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=MainLang">Main Language Type</a><br/> 
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("MC_status_type")) { 
                    out.println("MC Status<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=MC_status_type">MC Status</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Nationality_type")) { 
                    out.println("Nationality<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Nationality_type">Nationality</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Miles_nc_reached")) { 
                    out.println("Non Criminal Mile Stones<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Miles_nc_reached">Non Criminal Mile Stones</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Problem_type")) { 
                    out.println("Problem Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Problem_type">Problem Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Salary_payment_type")) { 
                    out.println("Salary Payment Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Salary_payment_type">Salary Payment Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Spoken_english_standard")) { 
                    out.println("Spoken English Standard<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Spoken_english_standard">Spoken English Standard</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Ttr_status_type")) { 
                    out.println("TTR Status<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Ttr_status_type">TTR Status</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Wicamon_status")) { 
                    out.println("Wica Status<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Wicamon_status">Wica Status</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Work_history_how_type")) { 
                    out.println("Work History How Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Work_history_how_type">Work History How Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Work_pass_type")) { 
                    out.println("Work Pass Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Work_pass_type">Work Pass Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Workplace_direct_type")) { 
                    out.println("Work Place Direct Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Workplace_direct_type">Work Place Direct Type</a><br/>
                <% }%>
                <span class="glyphicon glyphicon-play" style="color:cadetblue"></span>
                <% if (type.equals("Workplace_type")) { 
                    out.println("Work Place Type<br/> ");
                    } else { %>
                <a href="dropdownSetting.jsp?name=Workplace_type">Work Place Type</a>
                <% }%>
                 </div>
                <br/><br/>


                <!-- Add new Item Modal -->
                <div class="modal fade" id="add_new_item" tabindex="-1" role="dialog" 
                     aria-labelledby="myModalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                    <div class="modal-content">

                      <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span>
                            <span class="sr-only">Close</span>
                        </button>
                        <h3 class="modal-title" id="dropdown_new_item" style="color:#2980b9" align="center">
                            Add New Item
                        </h3>
                      </div> <!--modal-header-->
                      <form id="addNewItem" method="post" action="dropdownProcess.do" class="form-horizontal">
                      <div class="modal-body">

                        <div class="form-group">
                            <label class="col-sm-3" for="InputType">Dropdown Type<span style="color: red">*</span></label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="InputType" name="nItemType" 
                                       readOnly="readOnly">
                            </div>  
                        </div>

                        <div class="form-group">
                            <label class="col-sm-3" for="InputField">New Item Name<span style="color: red">*</span></label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control" id="InputItemName" name="nItemName"
                                    placeholder="Name" required>
                            </div>    
                        </div>

                      </div> <!--modal body -->

                      <div class="modal-footer">
                        <input type="hidden" id="InputRank" name="nRank"/>
                        <input type="hidden" name="action" value="add"/>
                        <input type="hidden" id="InputType" name="name"/>
                        <!-- Do NOT use name="submit" or id="submit" for the Submit button -->
                        <button type="submit" class="btn btn-primary">Add</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                      </div>
                    </form>

                    </div> <!--modal content -->
                  </div> <!--modal dialog -->
                </div> 
                <!-- End of Add New Item Modal-->
            </div> <!--content-->
        </div>
        <script>
            
            function showPanel() {
                document.getElementById('panelbox').style.display = "block";
            }
            //ready the drag & drop
             $(document).ready(function() { 
                $('#sortable').sortable();
             });

             //passing data for add new item
             $(document).on( "click", '.add_new_item',function() {
                 var dropdownType = $(this).data('type');
                 var rank = $(this).data('rank');
                 
                 $(".modal-body #InputType").val(dropdownType);
                 $(".modal-footer #InputRank").val(rank);
             });
             
             //saving item ordering changes
             function saveChanges() {
                var items = 'items=' + $('#sortable').sortable('serialize');
                items = items.replace(/&/g, ",");
                
                $.ajax({
                    type: "post",
                    data: items,
                    url: "dropdownProcess.do",
                    success: function(){
                        alert("Changes have been saved in database.");
                    }
               })
             }
             
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