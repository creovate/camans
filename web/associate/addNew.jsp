<%-- 
    Document   : addNew
    Created on : Mar 4, 2015, 1:28:56 AM
    Author     : Nyein Su
--%>

<%@page import="camans.entity.Job"%>
<%@page import="camans.dao.JobDAO"%>
<%@page import="camans.entity.Worker"%>
<%@page import="camans.dao.WorkerDAO"%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.entity.User"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="../protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    java.util.Date today = new java.util.Date();

    User userLogin = (User) request.getSession().getAttribute("userLogin");

    ArrayList<String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
    ArrayList<String> problemList = DropdownDAO.retrieveAllDropdownListOfProblems();
    ArrayList<String> passTypeList = DropdownDAO.retrieveAllDropdownListByType("Work_pass_type");
    ArrayList<String> jobSectorList = DropdownDAO.retrieveAllDropdownListOfJobSector();
    ArrayList<String> workpassTypes = DropdownDAO.retrieveAllDropdownListByType("Pass_type");

    String workerFin = request.getParameter("workerFin");
    String jobKeyStr = request.getParameter("selectedJob");
    String option = request.getParameter("option");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--css-->
        <link rel="stylesheet" href="../css/bootstrap.css" media="screen" />
        <link rel="stylesheet" href="../css/custom.css" media="screen" /> 
        <link rel="stylesheet" href="../css/jquery-ui-1.9.2.custom.css">
        <link rel="stylesheet" href="../css/jquery-ui.structure.css">
        <link rel="stylesheet" href="../css/jquery-ui.theme.css">
        <!-------------->

        <!--javascript-->
        <script src="../js/jquery-2.1.1.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery-ui-1.9.2.custom.js"></script>
        <!------------->

        <!--tab icon-->
        <link rel="shortcut icon" href="../img/twc_logo.png">

        <!--page title-->
        <title>CAMANS</title>
        <style>
            form{
                margin-bottom: 5%;
            }
            h4, h5{
                padding: 1%;
            }
        </style>
        <script>
            $(document).ready(function() {
                //initializing data picker
                $(".dateInput").datepicker({
                    dateFormat: 'dd-M-yy',
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: "-100:nn"
                });
                //disabling manual input
                $('.dateInput').focus(function() {
                    $('.dateInput').blur();
                });
                $('.no_change').focus(function() {
                    $('.no_change').blur();
                });

                $('#generateTWC2Fin').click(function() {
                    $.ajax({
                        type: "post",
                        url: "../generateTWC2Fin.do",
                        success: function(msg)
                        {

                            var elem = document.getElementById("finNum");
                            elem.value = msg;
                            $('#createworker_form').formValidation('revalidateField', 'finNum');
                        }
                    });
                });
            });


        </script>
    </head>
    <body>
        <!-- Nav Bar -->
        <jsp:include page="navbar.jsp"/>
        <!-- End of Nav Bar-->

        <%
            if (option != null) {
                //this is create case
%>
        <!-- Create Case Form -->
        <div class="col-xs-12 col-md-12" >
            <form method="post" action="../createNewCase.do" class="form form-horizontal" 
                  id="createworker_form" role="form">

                <!--worker profile-->
                <h4 style="color:#006c9a">Case Creation Form</h4>
                <h5 style="color:#006c9a">Worker Profile</h5>
                <br/>

                <div class="form-group">
                    <label for="registration_date_In" class="col-xs-4 col-md-3 control-label">Registration Date <span class="required_input">*</span> </label>
                    <div class="col-md-4 col-sm-7 col-xs-8">
                        <input type="text" class="form-control dateInput input-sm" name="registeredDate" value="<%=sdf.format(today)%>"  />
                    </div>
                </div>


                <div class="form-group">
                    <label for="created_by_In" class="col-md-3 col-xs-4 col-sm-4 control-label">Created By</label>
                    <div class="col-sm-7 col-md-6 col-xs-8">
                        <input type="text" class="form-control no_change" name="createdBy" value="<%=userLogin.getUsername()%>" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="worker_name" class="col-xs-4 col-md-3 col-sm-4 control-label " >Name of Worker <span class="required_input">*</span> </label>
                    <div class="col-xs-8 col-sm-7 col-md-6">
                        <input type="text" class="form-control required" name="workerName"/>
                    </div>
                </div>


                <div class="form-group">
                    <label for="worker_fin" class="col-md-3 col-xs-4 col-sm-4 control-label">FIN <span class="required_input">*</span></label>
                    <div id="fin" class=" col-md-4 col-xs-8 col-sm-7">
                        <input type="text" id="finNum"  class="form-control required" name="finNum"/>
                    </div>

                    <div id="finButton" class="col-md-4 col-xs-offset-6 col-xs-4 col-sm-offset-9 col-sm-2" style="margin-top: 5%">
                        <button type="button" id="generateTWC2Fin" class="btn btn-blue input-sm">Generate FIN</button>
                    </div>
                </div>


                <div class="form-group">
                    <label for="worker_gender" class="col-md-3 col-xs-4 col-sm-4 control-label">Gender<span class="required_input">*</span></label>
                    <div class="col-xs-8 col-sm-7 col-md-6">
                        <select class="form-control" name="gender">
                            <option>Male</option>
                            <option>Female</option>
                        </select>
                    </div>
                </div>


                <div class="form-group">
                    <label for="worker_nationality" class="col-md-3 col-xs-4 col-sm-4 control-label">Nationality<span class="required_input">*</span></label>
                    <div class="col-xs-8 col-sm-7 col-md-6">
                        <select class="form-control" id="worker_nationality" name="nationality" />
                        <option value="">Select Nationality:</option>
                        <%
                            for (String nationalityStr : nationalityList) {
                        %>
                        <option value="<%=nationalityStr%>"><%=nationalityStr%></option>
                        <%
                            }
                        %>                                               
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="worker_dob" class=" col-md-3 col-xs-4 col-sm-4 control-label">Date of Birth</label>
                    <div class="col-xs-8 col-sm-7 col-md-4">
                        <input class="form-control input-append date dateInput" type="text" class="dateInput"  name="dob"/>
                    </div>
                </div>


                <!--Job Profile-->
                <hr>
                <h5 style="color:#006c9a">Job Profile</h5>
                <br/>

                <div class="form-group">
                    <label for="emp_name" class="col-md-3 col-xs-4 col-sm-4 control-label" >Employer <span class="required_input">*</span> </label>
                    <div class="col-xs-8 col-sm-7 col-md-6">
                        <input type="text" class="form-control required" id="employerName" name="employerName"/></div>
                </div>


                <div class="form-group">
                    <label for="job_pass_type" class="col-md-3 col-xs-4 col-sm-4 control-label">Work pass type<span class="required_input">*</span></label>
                    <div class="col-xs-8 col-sm-7 col-md-6">
                        <select name="workpassType" class="form-control" id="job_pass_type" required>
                            <option value="">Select Work Pass Type:</option>
                            <%
                                for (String passTypeStr : passTypeList) {
                            %>
                            <option value="<%=passTypeStr%>"><%=passTypeStr%></option>
                            <%
                                }
                            %>   
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="job_start_date" class="col-md-3 col-xs-4 col-sm-4 control-label" >When started this job?</label>
                    <div class="col-xs-8 col-sm-7 col-md-6">
                        <input type="text" class="form-control" name="jobStartDate"/></div>
                </div>
                <br/>
                <!-- job complement -->
                <div class="form-group">
                    <label for="npasstype" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Current pass type:</label>
                    <div class="col-xs-8 col-sm-7 col-md-6"> 
                        <select name="npasstype" class="form-control input-sm" required>
                            <option value="">Select from list...</option>
                            <%
                                for (String workpassType : workpassTypes) {
                            %>
                            <option value="<%=workpassType%>"><%=workpassType%></option>
                            <%
                                }
                            %>                   
                        </select>
                    </div><br/><br/>
                </div>

                <div class='form-group'>
                    <label for='npassno' class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Current pass number:</label>

                    <div class="col-xs-8 col-sm-7 col-md-6">
                        <input class="form-control input-sm" type='text' name="npassno" />
                    </div><br/><br/>
                </div>
                <div class='form-group'>
                    <label for='nisdate' class="col-md-3 col-xs-4 col-sm-4 control-label">Current pass issued date:</label>
                    <div class="col-xs-8 col-sm-7 col-md-6">
                        <input class="form-control dateInput isdateToRemove col-xs-9 col-md-9 input-sm" type='text' name="nisdate" style="width:80%" >
                        <div class="input-group-addon col-xs-1 col-md-1 removeBtn" title="Remove date" data-field="is" style="width:20%;">
                            <span class="glyphicon glyphicon-remove"></span>
                        </div>
                    </div>
                </div>

                <!--problem profile-->
                <hr>
                <h5 style="color:#006c9a">Problem Profile</h5>
                <br/>

                <div class='form-group'>
                    <label for='isdate' class="col-md-3 col-xs-4 col-sm-4 control-label">Problem Reg Date<span class="required_input">*</span>: </label>

                    <div class='col-xs-8 col-sm-7 col-md-6'>
                        <input class="form-control dateInput" type='text' name="problemRegDate" value="<%=sdf.format(today)%>">
                    </div>
                    <br/>
                </div>

                <div class="form-group">
                    <label for="prob_type" class="col-md-3 col-xs-4 col-sm-4 control-label">Problem<span class="required_input">*</span></label>
                    <div class="col-xs-8 col-sm-7  col-md-6"> 
                        <select name="problem" id="prob_type" class="form-control">
                            <option value="">Select Problem..</option>
                            <%
                                for (String problemStr : problemList) {
                            %>
                            <option value="<%=problemStr%>"><%=problemStr%></option>
                            <%
                                }
                            %>                   
                        </select>
                    </div>
                </div>

                <!-- problem complements -->



                <input type="hidden" name="associate" value="associate"/>
                <button  type='submit' class="btn btn-blue pull-right">Submit</button>
            </form> 
        </div>

        <!-- End of Create Case-->
        <%

        } else {
            //continue with add new job or problem

            Worker selectedWorker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
            if (jobKeyStr == null) {
                //if the selectedJob is null, it is adding new job

        %>
        <div class='row'>
            <form method="POST" id='addCase' class="form complement_detailed_form col-xs-12 col-sm-12 col-md-12" action="../createNewCase.do" style="font-size:small">

                <%
                    java.util.Date date = new java.util.Date();


                %>

                <!--Job Profile-->
                <h4 style="color:#006c9a">Add Employer/Job Profile</h4>
                <br/>
                <div class="form-group">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Worker's name</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required" name="wkername" value='<%=selectedWorker.getName()%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >FIN</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Employer<span class="required_input">*</span> </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required" name="employerName"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="job_pass_type" class="col-xs-4 col-sm-5 col-md-5 control-label">Workpass type<span class="required_input">*</span></label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select name="workpassType" class="form-control" id="job_pass_type" required>
                            <option value=''>Select from list..</option>
                            <%
                                for (String passTypeStr : passTypeList) {
                            %>
                            <option value='<%=passTypeStr%>'><%=passTypeStr%></option>
                            <%
                                }
                            %>   
                        </select>
                    </div><br/><br/>
                </div>

                <div class="form-group">
                    <label for="job_start_date" class="col-xs-4 col-sm-5 col-md-5 control-label" >When start this job?</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control" name="jobStartDate"/></div><br/><br/>
                </div>

                <br/>
                <h4 style="color:#006c9a">Add Problem Profile</h4>


                <!--problem profile-->
                <div class="form-group">
                    <label for="worker_pass_type_other_In" class="col-xs-4 col-sm-5 col-md-5 control-label">Problem reg date<span class="required_input">*</span>:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput" type='text' name="problemRegDate" value="<%=sdf.format(today)%>"/></div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="prob_type" class="col-xs-4 col-sm-5 col-md-5 control-label">Problem<span class="required_input">*</span></label>
                    <div class="col-xs-8 col-sm-7 col-md-7"> 
                        <select name="problem" id="prob_type" class="form-control" required>
                            <option value="">Select from the list...</option>
                            <%
                                for (String problemStr : problemList) {
                            %>
                            <option value="<%=problemStr%>"><%=problemStr%></option>
                            <%
                                }
                            %>                   
                        </select>
                    </div><br/>
                </div>
                <input type="hidden" id="hiddenWorkerFin" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="associate" value="associate"/>
                <br/><br/>
                <div class="pull-right">
                    <button  type='submit' class="btn btn-blue">Submit</button>
                    <button type='' class="btn cancel_btn" style="bottom: 0">Cancel</button>
                </div>
                <br/><br/>
            </form> 
        </div>
        <%                } else {
            //else, it is adding new problem to selected job
            int jobKey = Integer.parseInt(jobKeyStr);
            Job selectedJob = JobDAO.retrieveJobByJobId(jobKey);
            String employer = selectedJob.getEmployerName();
        %>
        <div class='row'>
            <form method="POST" id='addCase' class="form complement_detailed_form col-xs-12 col-sm-12 col-md-12" action="../createNewCase.do" style="font-size:small">

                <%
                    java.util.Date date = new java.util.Date();


                %>


                <h4 style="color:#006c9a">Add Problem Profile</h4>


                <!--problem profile-->
                <br/>
                <div class="form-group">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Worker's name</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required" name="wkername" value='<%=selectedWorker.getName()%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >FIN</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Employer</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required" name="employer" value="<%=employer%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="worker_pass_type_other_In" class="col-xs-4 col-sm-5 col-md-5 control-label">Problem reg date<span class="required_input">*</span>:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput" type='text' name="problemRegDate" value="<%=sdf.format(today)%>"/></div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="prob_type" class="col-xs-4 col-sm-5 col-md-5 control-label">Problem<span class="required_input">*</span></label>
                    <div class="col-xs-8 col-sm-7 col-md-7"> 
                        <select name="problem" id="prob_type" class="form-control" required>
                            <option value="">Select from the list...</option>
                            <%
                                for (String problemStr : problemList) {
                            %>
                            <option value="<%=problemStr%>"><%=problemStr%></option>
                            <%
                                }
                            %>                   
                        </select>
                    </div><br/>
                </div>
                <input type="hidden" id="hiddenWorkerFin" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobKey" value="<%=jobKeyStr%>"/>
                <input type="hidden" name="associate" value="associate"/>
                <br/><br/>
                <div class="pull-right">
                    <button  type='submit' class="btn btn-blue">Submit</button>
                    <button type='' class="btn cancel_btn" style="bottom: 0">Cancel</button>
                </div>
                <br/><br/>
            </form> 
        </div>
        <%
                }
            }
        %>
    </body>
</html>