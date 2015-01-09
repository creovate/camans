<%-- 
    Document   : dropdownSetting
    Created on : Dec 29, 2014, 2:40:15 PM
    Author     : soemyatmyat
--%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page import="camans.entity.Dropdown"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <body style='background:white'>
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>

        <div class="col-md-10" id="content">
            <!--Page Header-->
            <div class="page-header">
                <center><h2 style="color:#2980b9">Configure Dropdown Settings</h2></center>    
            </div>
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
                    list = DropdownDAO.retrieveAllDropdownListByType(type);
                }    
                String title = null;         
             if (type.equals("Accommodation_type")) { 
                title = "Accommodation Type";
                out.println("Accommodation Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Accommodation_type">Accommodation Type</a>,             
            <% }%>
            <% if (type.equals("Accom_provided_type")) { 
                title = "Accommodation Provided Type";
                out.println("Accommodation Provided Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Accom_provided_type">Accommodation Provided Type</a>,
            <% }%>
            <% if (type.equals("Agent_location_type")) { 
                title = "Agent Location Type";
                out.println("Agent Location Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Agent_location_type">Agent Location Type</a>, 
            <% }%>
            <% if (type.equals("Bene_type_food")) { 
                title = "Benefit Type (Food)";
                out.println("Benefit Type (Food), ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Bene_type_food">Benefit Type (Food)</a>,
            <% }%>
            <% if (type.equals("Bene_type_medical")) { 
                title = "Benefit Type (Medical & Karunya)";
                out.println("Benefit Type (Medical & Karunya), ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Bene_type_medical">Benefit Type (Medical & Karunya)</a>,
            <% }%>
            <% if (type.equals("Bene_type_roof")) { 
                title = "Benefit Type (Roof)";
                out.println("Benefit Type (Roof), ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Bene_type_roof">Benefit Type (Roof)</a>,
            <% }%>
            <% if (type.equals("Bene_type_transport")) { 
                title = "Benefit Type (Transport)";
                out.println("Benefit Type (Transport), ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Bene_type_transport">Benefit Type (Transport)</a>,
            <% }%>
            <% if (type.equals("Bene_type_other")) { 
                title = "Benefit Type (Other)";
                out.println("Benefit Type (Other), ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Bene_type_other">Benefit Type (Other)</a>,
            <% }%>
            <% if (type.equals("Complaint_mode_type")) { 
                title = "Complaint Mode Type";
                out.println("Complaint Mode Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Complaint_mode_type">Complaint Mode Type</a>,
            <% }%>
            <% if (type.equals("Complaint_type")) { 
                title = "Complaint Type";
                out.println("Complaint Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Complaint_type">Complaint Type</a>, 
            <% }%>
            <% if (type.equals("Casemilestone_criminal_type")) { 
                title = "Criminal Mile Stone";
                out.println("Criminal Mile Stone, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Casemilestone_criminal_type">Criminal Mile Stone</a>,
            <% }%>
            <% if (type.equals("DigitalType")) { 
                title = "Digital Type";
                out.println("Digital Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=DigitalType">Digital Type</a>, 
            <% }%>
            <% if (type.equals("Discuss_where_type")) { 
                title = "Discuss where Type";
                out.println("Discuss where Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Discuss_where_type">Discuss where Type</a>,
            <% }%>
            <% if (type.equals("Hospital_name")) { 
                title = "Hospital Name";
                out.println("Hospital Name, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Hospital_name">Hospital Name</a>, 
            <% }%>
            <% if (type.equals("IPA_pass_type")) { 
                title = "IPA Pass Type";
                out.println("IPA Pass Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=IPA_pass_type">IPA Pass Type</a>,
            <% }%>
            <% if (type.equals("Job_sector_type")) { 
                title = "Job Sector";
                out.println("Job Sector, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Job_sector_type">Job Sector</a>, 
            <% }%>
            <% if (type.equals("Lawyer_firm")) { 
                title = "Lawyer Firm";
                out.println("Lawyer Firm, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Lawyer_firm">Lawyer Firm</a>,
            <% }%>
            <% if (type.equals("MainLang")) { 
                title = "Main Language Type";
                out.println("Main Language Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=MainLang">Main Language Type</a>, 
            <% }%>
            <% if (type.equals("MC_status_type")) { 
                title = "MC Status";
                out.println("MC Status, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=MC_status_type">MC Status</a>,
            <% }%>
            <% if (type.equals("Nationality_type")) { 
                title = "Nationality";
                out.println("Nationality, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Nationality_type">Nationality</a>,
            <% }%>
            <% if (type.equals("Miles_nc_reached")) { 
                title = "Non Criminal Mile Stones";
                out.println("Non Criminal Mile Stones, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Miles_nc_reached">Non Criminal Mile Stones</a>,
            <% }%>
            <% if (type.equals("Pass_type")) { 
                title = "Pass Type";
                out.println("Pass Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Pass_type">Pass Type</a>, 
            <% }%>
            <% if (type.equals("Problem_type")) { 
                title = "Problem Type";
                out.println("Problem Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Problem_type">Problem Type</a>,
            <% }%>
            <% if (type.equals("Salary_payment_type")) { 
                title = "Salary Payment Type";
                out.println("Salary Payment Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Salary_payment_type">Salary Payment Type</a>, 
            <% }%>
            <% if (type.equals("Spoken_english_standard")) { 
                title = "Spoken English Standard";
                out.println("Spoken English Standard, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Spoken_english_standard">Spoken English Standard</a>,
            <% }%>
            <% if (type.equals("Ttr_status_type")) { 
                title = "TTR Status";
                out.println("TTR Status, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Ttr_status_type">TTR Status</a>,
            <% }%>
            <% if (type.equals("Wicamon_status")) { 
                title = "Wica Status";
                out.println("Wica Status, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Wicamon_status">Wica Status</a>,
            <% }%>
            <% if (type.equals("Work_history_how_type")) { 
                title = "Work History How Type";
                out.println("Work History How Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Work_history_how_type">Work History How Type</a>,
            <% }%>
            <% if (type.equals("Work_pass_type")) { 
                title = "Work Pass Type";
                out.println("Work Pass Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Work_pass_type">Work Pass Type</a>,
            <% }%>
            <% if (type.equals("Workplace_direct_type")) { 
                title = "Work Place Direct Type";
                out.println("Work Place Direct Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Workplace_direct_type">Work Place Direct Type</a>, 
            <% }%>
            <% if (type.equals("Workplace_type")) { 
                title = "Work Place Type";
                out.println("Work Place Type, ");
                } else { %>
            <a href="dropdownSetting.jsp?name=Workplace_type">Work Place Type</a>
            <% }%>
            <br/><br/>
            
            
            <% String successMsg = (String) request.getSession().getAttribute("successMsg");
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
                                <b><%=title%></b>
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
                        <label class="col-sm-3" for="InputField">Item Name<span style="color: red">*</span></label>
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

        </script>
    </body>
        
</html>