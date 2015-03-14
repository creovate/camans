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
    ArrayList<String> names = DropdownDAO.retrieveAllDropdownListOfHosipital();
    ArrayList<String> lawFirmNameList = DropdownDAO.retrieveAllDropdownListOfLawFirms();

    String workerFin = request.getParameter("workerFin");
    String jobKeyStr = request.getParameter("selectedJob");
    String option = request.getParameter("option");
    if (option == null) {
        option = (String) request.getSession().getAttribute("option");
        request.getSession().removeAttribute("option");
    }

    String successMsg = (String) request.getSession().getAttribute("successMsg");
    request.getSession().removeAttribute("successMsg");

    String errorMsg = (String) request.getSession().getAttribute("errorMsg");
    request.getSession().removeAttribute("errorMsg");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!--css-->
        <link rel="stylesheet" href="../css/bootstrap.css" media="screen" />
        <link rel="stylesheet" href="../css/custom.css" media="screen" /> 
        <link rel="stylesheet" href="../css/jquery-ui-1.9.2.custom.css">
        <link rel="stylesheet" href="../css/jquery-ui.structure.css">
        <link rel="stylesheet" href="../css/jquery-ui.theme.css">
        <link rel="stylesheet" href="../css/jasny-bootstrap.css"/>
        <!-------------->

        <!--javascript-->
        <script src="../js/jquery-2.1.1.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery-ui.js"></script>
        <script src="../js/jquery.validate.js"></script>
        <script src="../js/additional-methods.js"></script>
        <script src="../js/jasny-bootstrap.js"></script>  

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
            .alert{
                position: absolute;
                z-index: 999;
                top: 18vh;
            }
        </style>
        <script>
            $(document).ready(function() {

                $(".removeBtn").click(function() {
                    var field = $(this).data('field');
                    $("." + field + "dateToRemove").val("");
                });

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

                //methods for jquery validator
                jQuery.validator.addMethod("FIN", function(value, element) {
                    return this.optional(element) || /^[A-Z][0-9]{7}[A-Z]$/.test(value) || /^GEN[0-9]{6}$/.test(value);
                }, "Invalid FIN number format. Please check again.");
                jQuery.validator.addMethod("FileSize", function(value, element) {
                    return this.optional(element) || (element.files[0].size <= 1048576);
                }, "Invalid File size. Please check again.");
                jQuery.validator.addMethod("phNum", function(value, element) {
                    return this.optional(element) || /^[\d|\-|(|)|+|\s]+$/.test(value);
                }, "Invalid Phone number format. Please check again.");
                $('#createworker_form').validate({
                    //ignore: ":hidden",
                    rules: {
                        finNum: {
                            required: true,
                            FIN: true,
                            remote: {
                                url: "../processValidate",
                                type: "POST",
                                data: {
                                    finNum: function() {
                                        return $("#finNum").val();
                                    }
                                }
                            }
                        },
                        workerName: {
                            maxlength: 50,
                            required: true
                        },
                        nationality: {
                            required: true
                        },
                        nationalityMore: {
                            maxlength: 50
                        },
                        createdFor: {
                            maxlength: 20
                        },
                        sgPh: {
                            maxlength: 12,
                            phNum: true
                        },
                        employerName: {
                            maxlength: 50,
                            required: true
                        },
                        workpassMore: {
                            maxlength: 50
                        },
                        jobStartDate: {
                            maxlength: 50
                        },
                        npassno: {
                            maxlength: 20,
                            required: true
                        },
                        problem: {
                            required: true
                        },
                        problemMore: {
                            maxlength: 50
                        },
                        bodyPart: {
                            maxlength: 500
                        },
                        nhospNameMore: {
                            maxlength: 50
                        },
                        nlawyerFirmMore: {
                            maxlength: 50
                        },
                        facePic: {
                            FileSize: true,
                            accept: "image/*",
                            extension: "png,jpeg,jpg,bmp"
                        }
                    },
                    messages: {
                        facePic: "Please choose an image file with a size less than 1M only.",
                        finNum: {
                            remote: "FIN Number already exists. Please check again"
                        }

                    },
                    highlight: function(element) {
                        $(element).closest('.form-group').addClass('has-error');
                    },
                    unhighlight: function(element) {
                        $(element).closest('.form-group').removeClass('has-error');
                    },
                    errorElement: 'span',
                    errorClass: 'help-block',
                    errorPlacement: function(error, element) {
                        if (element.parent('.input-group').length) {
                            error.insertAfter(element.parent());
                        } else {
                            error.insertAfter(element);
                        }
                    }
                });

                $('#addCase').validate({
                    ignore: ":hidden",
                    rules: {
                        jobPassType: {
                            required: true
                        },
                        passMore: {
                            maxlength: 50
                        },
                        workpassMore: {
                            maxlength: 50
                        },
                        employerName: {
                            maxlength: 50,
                            required: true
                        },
                        jobStartDate: {
                            maxlength: 50
                        },
                        npassno: {
                            maxlength: 20,
                            required: true
                        },
                        //problem profile
                        problem: {
                            required: true
                        },
                        problemMore: {
                            maxlength: 50
                        },
                        bodyPart: {
                            maxlength: 500
                        },
                        nhospNameMore: {
                            maxlength: 50
                        },
                        nlawyerFirmMore: {
                            maxlength: 50
                        },
                        facePic: {
                            accept: "image/png,image/jpeg,image/jpg,image/bmp",
                            extension: "png,jpeg,jpg,bmp",
                            FileSize: true
                        }
                    },
                    highlight: function(element) {
                        $(element).closest('.form-group').addClass('has-error');
                    },
                    unhighlight: function(element) {
                        $(element).closest('.form-group').removeClass('has-error');
                    },
                    errorElement: 'span',
                    errorClass: 'help-block',
                    errorPlacement: function(error, element) {
                        if (element.parent('.input-group').length) {
                            error.insertAfter(element.parent());
                        } else {
                            error.insertAfter(element);
                        }
                    }
                });
            });



            function goBack() {
                window.history.back();
            }

        </script>
    </head>
    <body>
        <!-- Nav Bar -->
        <jsp:include page="navbar.jsp"/>
        <!-- End of Nav Bar-->

        <% if (successMsg != null) {
                if (!successMsg.equals("")) {%>

        <div class="alert alert-info col-xs-offset-1 col-xs-10" role="alert">
            <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
            <%=successMsg%>
        </div>

        <% }
            }
            if (errorMsg != null) {
                if (!errorMsg.equals("")) {%>

        <div class="alert alert-danger col-xs-offset-1 col-xs-10" role="alert">
            <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
            <%=errorMsg%>
        </div>

        <% }
            }%>
        <%
            if (option != null) {
                //this is create case
        %>
        <!-- Create Case Form -->
        <div class="col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" >
            <form method="post" action="../createNewCase.do" class="form form-horizontal" 
                  id="createworker_form" role="form" enctype="multipart/form-data">

                <!--worker profile-->
                <h4 style="color:#006c9a">Case Creation Form</h4>
                <h5 style="color:#006c9a">Worker Profile</h5>
                <br/>

                <div class="form-group">
                    <label for="registration_date_In" class="col-xs-4 col-md-3 control-label"><span class="required_input">*</span>Registration date:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control dateInput input-sm" name="registeredDate" value="<%=sdf.format(today)%>"  />
                    </div>
                </div>
                <div class="form-group">
                    <label for="created_by_In" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Created by:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control no_change input-sm" name="createdBy" value="<%=userLogin.getUsername()%>" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="worker_name" class="col-xs-4 col-md-3 col-sm-4 control-label "><span class="required_input">*</span>Worker's name:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="workerName" required/>
                    </div>
                </div>
                <div class="form-group">
                    <label for="worker_fin" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>FIN:</label>
                    <div id="fin" class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" id="finNum"  class="form-control required input-sm" name="finNum"/>
                    </div>


                </div>
                <div class="form-group">
                    <label for="worker_gender" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Gender:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm" name="gender">
                            <option>Male</option>
                            <option>Female</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label for="worker_nationality" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Nationality:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm" id="worker_nationality" name="nationality" />
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
                    <label for="worker_dob" class=" col-md-3 col-xs-4 col-sm-4 control-label">Date of birth:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-append date dateInput input-sm" type="text" class="dateInput"  name="dob"/>
                    </div>
                </div>

                <!--worker complement-->
                <div class="form-group">
                    <label for="worker_dob" class=" col-md-3 col-xs-4 col-sm-4 control-label">Phone:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type="text" class="form-control"  name="sgPh"/>
                    </div>
                </div>

                <!--Job Profile-->
                <hr>
                <h5 style="color:#006c9a">Job Profile</h5>
                <br/>

                <div class="form-group">
                    <label for="emp_name" class="col-md-3 col-xs-4 col-sm-4 control-label" ><span class="required_input">*</span>Employer:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" id="employerName" name="employerName"/></div>
                </div>
                <div class="form-group">
                    <label for="job_pass_type" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Workpass type:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select name="workpassType" class="form-control input-sm" id="job_pass_type" required>
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
                    <label for="job_start_date" class="col-md-3 col-xs-4 col-sm-4 control-label" >When started this job?:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control input-sm" name="jobStartDate"/></div>
                </div>
                <br/>

                <!-- job complement -->
                <div class="form-group">
                    <label for="npasstype" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Current pass type:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7"> 
                        <select name="npasstype" class="form-control input-sm" required>
                            <option value="" selected>Select from list...</option>
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

                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="npassno" />
                    </div><br/><br/>
                </div>
                <div class='form-group'>
                    <label for='nisdate' class="col-md-3 col-xs-4 col-sm-4 control-label">Current pass issued date:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
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
                    <label for='isdate' class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Problem reg date:</label>

                    <div class='col-xs-8 col-sm-7 col-md-7'>
                        <input class="form-control dateInput input-sm" type='text' name="problemRegDate" value="<%=sdf.format(today)%>">
                    </div>
                    <br/>
                </div>
                <div class="form-group">
                    <label for="prob_type" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Problem:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7"> 
                        <select name="problem" id="prob_type" class="form-control input-sm" required="true">
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
                <div class='form-group'>
                    <label for='isdate' class="col-md-3 col-xs-4 col-sm-4 control-label">Date of injury:</label>

                    <div class='col-xs-8 col-sm-7 col-md-7'>
                        <input class="form-control dateInput input-sm" type='text' name="injuryDate">
                    </div>
                    <br/>
                </div>
                <div class='form-group'>
                    <label for='npassno' class="col-md-3 col-xs-4 col-sm-4 control-label">Body part(s) injured:</label>

                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm input-sm" type='text' name="bodyPart" />
                    </div><br/><br/>
                </div>

                <div class='form-group'>
                    <label for='' class="col-md-3 col-xs-4 col-sm-4 control-label">Current hospital:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm" id="nhospName" name="nhospName" >
                            <option value="" selected>Select from list...</option>
                            <%            for (String name : names) {
                            %>
                            <option value="<%=name%>"><%=name%></option>
                            <%

                                }
                            %>  
                        </select>
                    </div><br/><br/>
                </div>
                <div class='form-group'>
                    <label for='nhospNameMore' class="col-md-3 col-xs-4 col-sm-4 control-label">Explain if above is 'Other':</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control input-sm" name="nhospNameMore" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>
                <input type="hidden" name="associate" value="associate"/>
                <div class='form-group'>
                    <label for='lawyerFirm' class="col-md-3 col-xs-4 col-sm-4 control-label">Current law firm: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm" name="nlawyerFirm" >
                            <option value="" selected>Select from list...</option>
                            <%
                                for (String lawFirmName : lawFirmNameList) {
                            %>
                            <option value="<%=lawFirmName%>"><%=lawFirmName%></option>
                            <%
                                }
                            %>
                        </select>
                    </div><br/><br/>
                </div>
                <div class='form-group'>
                    <label for='lawyerHave' class="col-md-3 col-xs-4 col-sm-4 control-label">Explain if above is 'other': </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control input-sm" name="nlawyerFirmMore" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>

                <!--- Face Picture -->
                <div class="col-md-offset-3 col-md-9 col-sm-offset-4 col-sm-8 col-xs-offset-4 col-xs-8 fileinput fileinput-new" data-provides="fileinput">
                    <div class="fileinput-new thumbnail" style="width: 180px; height: 135px;">
                        <img data-src="holder.js/100%x100%" alt="...">
                    </div>
                    <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 180px; max-height: 135px;"></div>
                    <div>
                        <span class="btn btn-default btn-file">
                            <span class="fileinput-new">Select image</span>
                            <span class="fileinput-exists">Change</span><input type="file" name="facePic" accept='image/*'>
                        </span>
                        <a href="#" class="btn btn-blue btn btn-blue-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                    </div>
                </div>

                <div class="pull-right">
                    <button  type='submit' class="btn btn-blue">Submit</button>
                    <button type='' class="btn cancel_btn" style="bottom: 0" onclick="goBack();">Cancel</button>
                </div>
                <br/>
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
        <!-- Add New Job -->
        <div class='col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8'>
            <form method="POST" id='addCase' class="form form-horizontal" action="../createNewCase.do" style="font-size:small">

                <%
                    java.util.Date date = new java.util.Date();


                %>

                <!--Job Profile-->
                <h4 style="color:#006c9a">Add Employer/Job Profile</h4>
                <br/>
                <div class="form-group">
                    <label for="emp_name" class="col-md-3 col-xs-4 col-sm-4 control-label" >Worker's name</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkername" value='<%=selectedWorker.getName()%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="emp_name" class="col-md-3 col-xs-4 col-sm-4 control-label" >FIN</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="emp_name" class="col-md-3 col-xs-4 col-sm-4 control-label" ><span class="required_input">*</span>Employer:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="employerName"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="job_pass_type" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Workpass type</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select name="workpassType" class="form-control input-sm" id="job_pass_type" required>
                            <option value='' selected="">Select from list..</option>
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
                    <label for="job_start_date" class="col-md-3 col-xs-4 col-sm-4 control-label" >When start this job?</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control input-sm" name="jobStartDate"/></div><br/><br/>
                </div>

                <!-- job complement -->
                <div class="form-group">
                    <label for="npasstype" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Current pass type</label>
                    <div class="col-xs-8 col-sm-7 col-md-7"> 
                        <select name="npasstype" class="form-control input-sm" required>
                            <option value="" selected>Select from list...</option>
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
                    <label for='npassno' class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Current pass number</label>

                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="npassno" />
                    </div><br/><br/>
                </div>
                <div class='form-group'>
                    <label for='nisdate' class="col-md-3 col-xs-4 col-sm-4 control-label">Current pass issued date</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput isdateToRemove col-xs-9 col-md-9 input-sm" type='text' name="nisdate" style="width:80%" >
                        <div class="input-group-addon col-xs-1 col-md-1 removeBtn" title="Remove date" data-field="is" style="width:20%;">
                            <span class="glyphicon glyphicon-remove"></span>
                        </div>
                    </div>
                </div>

                <br/>
                <h4 style="color:#006c9a">Add Problem Profile</h4>


                <!--problem profile-->
                <div class="form-group">
                    <label for="worker_pass_type_other_In" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Problem reg date</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput input-sm" type='text' name="problemRegDate" value="<%=sdf.format(today)%>"/></div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="prob_type" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Problem</label>
                    <div class="col-xs-8 col-sm-7 col-md-7"> 
                        <select name="problem" id="prob_type" class="form-control input-sm" required>
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

                <!-- problem complements -->
                <div class='form-group'>
                    <label for='isdate' class="col-md-3 col-xs-4 col-sm-4 control-label">Date of injury</label>

                    <div class='col-xs-8 col-sm-7 col-md-7'>
                        <input class="form-control dateInput input-sm" type='text' name="injuryDate">
                    </div>
                    <br/>
                </div>
                <div class='form-group'>
                    <label for='npassno' class="col-md-3 col-xs-4 col-sm-4 control-label">Body part(s) injured</label>

                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="bodyPart" />
                    </div><br/><br/>
                </div>

                <div class='form-group'>
                    <label for='' class="col-md-3 col-xs-4 col-sm-4 control-label">Current hospital</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm" id="nhospName" name="nhospName" >
                            <option value="" selected>Select from list...</option>
                            <%            for (String name : names) {
                            %>
                            <option value="<%=name%>"><%=name%></option>
                            <%

                                }
                            %>  
                        </select>
                    </div><br/><br/>
                </div>
                <div class='form-group'>
                    <label for='nhospNameMore' class="col-md-3 col-xs-4 col-sm-4 control-label">Explain if above is 'Other'</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control input-sm" name="nhospNameMore" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>

                <div class='form-group'>
                    <label for='lawyerFirm' class="col-md-3 col-xs-4 col-sm-4 control-label">Current law firm</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm" name="nlawyerFirm" >
                            <option value="" selected>Select from list...</option>
                            <%
                                for (String lawFirmName : lawFirmNameList) {
                            %>
                            <option value="<%=lawFirmName%>"><%=lawFirmName%></option>
                            <%
                                }
                            %>
                        </select>
                    </div><br/><br/>
                </div>
                <div class='form-group'>
                    <label for='lawyerHave' class="col-md-3 col-xs-4 col-sm-4 control-label">Explain if above is 'other'</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control input-sm" name="nlawyerFirmMore" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>
                <input type="hidden" id="hiddenWorkerFin" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="associate" value="associate"/>
                <br/><br/>
                <div class="pull-right">
                    <button  type='submit' class="btn btn-blue input-sm">Submit</button>
                    <button type='' class="btn cancel_btn input-sm" style="bottom: 0" onclick="goBack();">Cancel</button>
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
        <!-- Add new problem -->
        <div class='col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8'>
            <form method="POST" id='addCase' class="form form-horizontal" action="../createNewCase.do" style="font-size:small">

                <%
                    java.util.Date date = new java.util.Date();


                %>


                <h4 style="color:#006c9a">Add Problem Profile</h4>


                <!--problem profile-->
                <br/>
                <div class="form-group">
                    <label for="emp_name" class="col-md-3 col-xs-4 col-sm-4 control-label" >Worker's name</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkername" value='<%=selectedWorker.getName()%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="emp_name" class="col-md-3 col-xs-4 col-sm-4 control-label" >FIN</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="emp_name" class="col-md-3 col-xs-4 col-sm-4 control-label" >Employer</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="employer" value="<%=employer%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="worker_pass_type_other_In" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Problem reg date</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput input-sm" type='text' name="problemRegDate" value="<%=sdf.format(today)%>"/></div><br/><br/>
                </div>
                <div class="form-group">
                    <label for="prob_type" class="col-md-3 col-xs-4 col-sm-4 control-label"><span class="required_input">*</span>Problem</label>
                    <div class="col-xs-8 col-sm-7 col-md-7"> 
                        <select name="problem" id="prob_type" class="form-control input-sm" required>
                            <option value="" selected="true">Select from the list...</option>
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

                <!-- problem complements -->
                <div class='form-group'>
                    <label for='isdate' class="col-md-3 col-xs-4 col-sm-4 control-label">Date of injury</label>

                    <div class='col-xs-8 col-sm-7 col-md-7'>
                        <input class="form-control dateInput input-sm" type='text' name="injuryDate">
                    </div>
                    <br/>
                </div>
                <div class='form-group'>
                    <label for='npassno' class="col-md-3 col-xs-4 col-sm-4 control-label">Body part(s) injured</label>

                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="bodyPart" />
                    </div><br/><br/>
                </div>

                <div class='form-group'>
                    <label for='' class="col-md-3 col-xs-4 col-sm-4 control-label">Current hospital</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm" id="nhospName" name="nhospName" >
                            <option value="" selected>Select from list...</option>
                            <%            for (String name : names) {
                            %>
                            <option value="<%=name%>"><%=name%></option>
                            <%

                                }
                            %>  
                        </select>
                    </div><br/><br/>
                </div>
                <div class='form-group'>
                    <label for='nhospNameMore' class="col-md-3 col-xs-4 col-sm-4 control-label">Explain if above is 'Other'</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control input-sm" name="nhospNameMore" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>

                <div class='form-group'>
                    <label for='lawyerFirm' class="col-md-3 col-xs-4 col-sm-4 control-label">Current law firm</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm" name="nlawyerFirm" >
                            <option value="" selected>Select from list...</option>
                            <%
                                for (String lawFirmName : lawFirmNameList) {
                            %>
                            <option value="<%=lawFirmName%>"><%=lawFirmName%></option>
                            <%
                                }
                            %>
                        </select>
                    </div><br/><br/>
                </div>
                <div class='form-group'>
                    <label for='lawyerHave' class="col-md-3 col-xs-4 col-sm-4 control-label">Explain if above is 'other'</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control input-sm" name="nlawyerFirmMore" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>
                <input type="hidden" id="hiddenWorkerFin" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobKey" value="<%=jobKeyStr%>"/>
                <input type="hidden" name="associate" value="associate"/>
                <br/><br/>
                <div class="pull-right">
                    <button  type='submit' class="btn btn-blue">Submit</button>
                    <button type='' class="btn cancel_btn" style="bottom: 0" onclick="goBack();">Cancel</button>
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
