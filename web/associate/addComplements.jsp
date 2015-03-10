<%-- 
    Document   : addComplements
    Created on : Mar 6, 2015, 10:33:08 PM
    Author     : Nyein Su
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="camans.entity.*"%>
<%@page import="camans.dao.*"%>
<%@ include file="../protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    java.util.Date today = new java.util.Date();

    User userLogin = (User) session.getAttribute("userLogin");

    String workerFin = request.getParameter("workerFin");
    String jobKeyStr = request.getParameter("selectedJob");
    int jobKey = Integer.parseInt(jobKeyStr);
    String probKeyStr = request.getParameter("selectedProb");
    int probKey = Integer.parseInt(probKeyStr);
    String complement = request.getParameter("complement");
    String action = request.getParameter("action");

    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);
    Job selectedJob = JobDAO.retrieveJobByJobId(jobKey);
    Problem selectedProb = ProblemDAO.retrieveProblemByProblemId(probKey);

    String workerName = "";
    String employer = "";
    String problem = "";

    if (worker != null) {
        workerName = worker.getName();
    }
    if (selectedJob != null) {
        employer = selectedJob.getEmployerName();
    }
    if (selectedProb != null) {
        problem = selectedProb.getProblem();
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
        <link rel="stylesheet" href="../css/bootstrapValidator.min.css"/>
        <!-------------->

        <!--javascript-->
        <script src="../js/jquery-2.1.1.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery-ui-1.9.2.custom.js"></script>
        <script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>   
        <!------------->

        <!--tab icon-->
        <link rel="shortcut icon" href="../img/twc_logo.png">

        <!--page title-->
        <title>CAMANS</title>
        <style>
            h4, h5{
                padding: 3%;
                color:#006c9a;
            }
            .btn_group{
                margin-top: 5%;
                margin-right: 2%;
            }
            .form-group{
                padding: 0;
            }
            input.form-control.input-sm{
                width: 100%;
            }
            select.form-control.input-sm{
                width:100%;
            }
            .alert{
                position: absolute;
                z-index: 999;
                top: 18vh;
            }
        </style>
        <script>
            $(document).ready(function() {
                $('.alert').fadeOut(9999);
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
                //worker complement validation
                $('#workerComplement')
                        .bootstrapValidator({
                    fields: {
                        //sgPhone & homePhone
                        nsgPhNum: {
                            validators: {
                                stringLength: {
                                    max: 12,
                                    message: 'Phone No must not exceed 12 characters.'
                                },
                                regexp: {
                                    regexp: /^[\d|\-|(|)|+|\s]+$/,
                                    message: 'Phone No can contain space, - , () , + and digits only.'
                                },
                                notEmpty: {
                                    message: 'Phone No. cannot be empty.'
                                }
                            }
                        }
                    }
                });

                $('#jobComplement')
                        .bootstrapValidator({
                    fields: {
                        //pass details
                        npasstype: {
                            validators: {
                                notEmpty: {
                                    message: 'Pass type cannot be empty.'
                                }
                            }
                        },
                        npasstypeMore: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'Pass type must not exceed 50 characters.'
                                }
                            }
                        },
                        npassno: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'Pass number must not exceed 20 characters.'
                                },
                                notEmpty: {
                                    message: 'Pass number cannot be empty.'
                                }
                            }
                        },
                        nissuer: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'Agency name must not exceed 20 characters.'
                                }
                            }
                        },
                        nremark: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'Remarks must not exceed 200 characters.'
                                }
                            }
                        }
                    }
                });

                $('#problemComplements')
                        .bootstrapValidator({
                    fields: {
                        //hospital
                        nhospName: {
                            validators: {
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                }
                            }
                        },
                        nhospNameMore: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must not exceed 50 characters.'
                                }
                            }
                        },
                        nhospDoctor: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must not exceed 200 characters.'
                                }
                            }
                        },
                        //lawyer
                        nlawyerFirm: {
                            validators: {
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                }
                            }
                        },
                        nlawyerFirmMore: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must not exceed 50 characters.'
                                }
                            }
                        },
                        nlawyerName: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must not exceed 200 characters.'
                                }
                            }
                        },
                        //wica status
                        nwicaStatus: {
                            validators: {
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                }
                            }
                        },
                        nwicaStatusMore: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must not exceed 200 characters.'
                                }
                            }
                        },
                        //non criminal milestone
                        nmilestoneNCReached: {
                            validators: {
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                }
                            }
                        },
                        nmilestoneNCReachedMore: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must not exceed 200 characters.'
                                }
                            }
                        },
                        //ttr
                        nttrStatus: {
                            validators: {
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                }
                            }
                        },
                        nttrStatusMore: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must not exceed 200 characters.'
                                }
                            }
                        },
                        nttrDepartureDate: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must not exceed 50 characters.'
                                }
                            }
                        },
                        nttrEmployerName: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must not exceed 50 characters.'
                                }
                            }
                        },
                        nttrJob: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must not exceed 200 characters.'
                                }
                            }
                        },
                        nttrremark: {
                            validators: {
                                stringLength: {
                                    max: 500,
                                    message: 'Remarks must not exceed 500 characters.'
                                }
                            }
                        },
                        nr2rTime: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'This field must be less than 20 characters.'
                                }
                            }
                        },
                        nr2rHosp: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'This field must be less than 20 characters.'
                                },
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                }
                            }
                        },
                        nr2rDept: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        nr2r1: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'This field must be less than 20 characters.'
                                }
                            }
                        },
                        nr2r2: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'This field must be less than 20 characters.'
                                }
                            }
                        },
                        nr2rPurpose: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        nr2rPreApptNotes: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must be less than 200 characters.'
                                }
                            }
                        },
                        nr2rPostApptNotes: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must be less than 200 characters.'
                                }
                            }
                        },
                        nr2rFeedback: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must be less than 200 characters.'
                                }
                            }
                        },
                        nr2rMed: {
                            validators: {
                                regexp: {
                                    regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                                    message: 'This value must have maximum 2 decimal place.'
                                }
                            }
                        },
                        nr2rOut: {
                            validators: {
                                regexp: {
                                    regexp: /^(\d+)?(,\d+)*(\.[0-9]{1,2})?$/,
                                    message: 'This value must have maximum 2 decimal place.'
                                }
                            }
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

        <div class="alert alert-danger" role="alert">
            <a style="cursor:pointer" class="close" data-dismiss="alert">&times;</a>
            <%=errorMsg%>
        </div>

        <% }
            }%>

        <div class="row">
            <%
                if (complement != null) {
                    if (complement.equals("sgPhone")) {
            %>
            <form method="POST" action="../addWorkerComplement.do" class="form form-inline col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" id='workerComplement'>
                <h4>Add worker's phone</h4>

                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Worker's name:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkername" value='<%=workerName%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >FIN:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Employer:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="employer" value="<%=employer%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nPhNum' class="col-xs-4 col-sm-5 col-md-5 control-label"><span style="color: red">*</span>Phone number:</label>
                    <div class='col-xs-8 col-sm-7 col-md-7'>
                        <input class="form-control input-sm" type='text' name="nsgPhNum" required>
                    </div><br/><br/>
                </div>

                <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="selectedJob" value="<%=jobKey%>"/>
                <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
                <input type="hidden" name="complementName" value="WorkerSgPhNum"/>
                <input type="hidden" name="associate" value="associate"/>


                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue  modal_btn add_comp">Save</button>
                    <button type='button' class='btn modal_btn add_comp cancel_btn' onclick="goBack();">Cancel</button>
                </div>
            </form>
            <%
            } else if (complement.equals("passType")) {
                ArrayList<String> workpassTypes = DropdownDAO.retrieveAllDropdownListByType("Pass_type");
            %>
            <form method="POST" action="../addJobComplement.do" class="form form-inline col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" id='jobComplement'>
                <h4>Add worker's current pass</h4>

                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Worker's name:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkername" value='<%=workerName%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >FIN:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Employer:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="employer" value="<%=employer%>" readonly="true"/>
                    </div><br/><br/>
                </div>

                <!-- details about complement -->
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="npasstype" class="col-xs-4 col-sm-5 col-md-5 control-label"><span class="required_input">*</span>Current pass type:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7"> 
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

                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='npassno' class="col-xs-4 col-sm-5 col-md-5 control-label"><span class="required_input">*</span>Current pass number:</label>

                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="npassno" />
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nisdate' class="col-xs-4 col-sm-5 col-md-5 control-label">Current pass issued date:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput isdateToRemove col-xs-9 col-md-9 input-sm" type='text' name="nisdate" style="width:80%" >
                        <div class="input-group-addon col-xs-1 col-md-1 removeBtn" title="Remove date" data-field="is" style="width:20%;">
                            <span class="glyphicon glyphicon-remove"></span>
                        </div>
                    </div>
                </div>

                <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
                <input type="hidden" name="selectedProb" value="<%=probKey%>"/>
                <input type="hidden" name="complementName" value="JobPassDetails"/>
                <input type="hidden" name="associate" value="associate"/>
                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue  modal_btn add_comp btn-sm">Save</button>
                    <button type='button' class='btn modal_btn add_comp cancel_btn btn-sm' onclick="goBack();">Cancel</button>
                </div>
            </form>
            <%
            } else if (complement.equals("hospital")) {
                ArrayList<String> names = DropdownDAO.retrieveAllDropdownListOfHosipital();
            %>
            <form method="POST" action="../addProblemComplement.do" class="form form-inline col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" id='problemComplements'>
                <h4>Add current hospital</h4>

                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Worker's name:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkername" value='<%=workerName%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >FIN:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Employer:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="employer" value="<%=employer%>" readonly="true"/>
                    </div><br/><br/>
                </div>

                <!-- details about complement -->
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='' class="col-xs-4 col-sm-5 col-md-5 control-label"><span class="required_input">*</span>Date of update: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>" style='width: 100%;'>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='' class="col-xs-4 col-sm-5 col-md-5 control-label"><span class="required_input">*</span>Current hospital:</label>
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
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nhospNameMore' class="col-xs-4 col-sm-5 col-md-5 control-label">Explain if above is 'Other':</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control" name="nhospNameMore" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>

                <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
                <input type="hidden" name="probKey" value="<%=probKey%>"/>
                <input type="hidden" name="complementName" value="hospital"/>
                <input type="hidden" name="associate" value="associate"/>
                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue  modal_btn add_comp btn-sm">Save</button>
                    <button type='button' class='btn modal_btn add_comp cancel_btn btn-sm' onclick="goBack();">Cancel</button>
                </div>
            </form>
            <%
            } else if (complement.equals("lawFirm")) {
                ArrayList<String> lawFirmNameList = DropdownDAO.retrieveAllDropdownListOfLawFirms();
            %>
            <form method="POST" action="../addProblemComplement.do" class="form form-inline col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" id='problemComplements'>
                <h4>Add current law firm</h4>

                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Worker's name:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkername" value='<%=workerName%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >FIN:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Employer:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="employer" value="<%=employer%>" readonly="true"/>
                    </div><br/><br/>
                </div>

                <!-- details about complement -->
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='lawyerUpdate' class="col-xs-4 col-sm-5 col-md-5 control-label">Date of update<span style="color: red">*</span>: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput" type='text' name="ndate"  value="<%=sdf.format(today)%>" style='width:100%'>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='lawyerFirm' class="col-xs-4 col-sm-5 col-md-5 control-label">Current law firm<span style="color: red">*</span>: </label>
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
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='lawyerHave' class="col-xs-4 col-sm-5 col-md-5 control-label">Explain if above is 'other': </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control" name="nlawyerFirmMore" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>

                <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
                <input type="hidden" name="probKey" value="<%=probKey%>"/>
                <input type="hidden" name="complementName" value="lawyer"/>
                <input type="hidden" name="associate" value="associate"/>
                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue  modal_btn add_comp btn-sm">Save</button>
                    <button type='button' class='btn modal_btn add_comp cancel_btn btn-sm' onclick="goBack();">Cancel</button>
                </div>
            </form>
            <%
            } else if (complement.equals("wicaStatus")) {
                ArrayList<String> wicaList = DropdownDAO.retrieveAllDropdownListOfWica();
            %>
            <form method="POST" action="../addProblemComplement.do" class="form form-inline col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" id='problemComplements'>
                <h4>Add WICA status</h4>

                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Worker's name</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkername" value='<%=workerName%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >FIN</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Employer</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="employer" value="<%=employer%>" readonly="true"/>
                    </div><br/><br/>
                </div>

                <!-- details about complement -->
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nwicaUpdate' class="col-xs-4 col-sm-5 col-md-5 control-label"><span style="color: red">*</span>Wica update date: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>"  style='width:100%;'>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nwicaStatus' class="col-xs-4 col-sm-5 col-md-5 control-label"><span style="color: red">*</span>WICA status:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm"  name="nwicaStatus" >
                            <option value="" selected>Select from list...</option>
                            <%
                                for (String tempStatus : wicaList) {
                            %>
                            <option value="<%=tempStatus%>"><%=tempStatus%></option>
                            <%

                                }
                            %>  
                        </select>
                    </div><br/><br/>
                </div>

                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nwicaStatusMore' class="col-xs-4 col-sm-5 col-md-5 control-label">Explain if above is 'Other': </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control input-sm" name="nwicaStatusMore" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nwicaPoints' class="col-xs-4 col-sm-5 col-md-5 control-label">WICA points: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="nwicaPoints"/>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nwicaDollars' class="col-xs-4 col-sm-5 col-md-5 control-label">WICA $: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="nwicaDollars">
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nwicaRemarks' class="col-xs-4 col-sm-5 col-md-5 control-label">Wica remarks: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control input-sm" name="nremark" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>

                <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
                <input type="hidden" name="probKey" value="<%=probKey%>"/>
                <input type="hidden" name="associate" value="associate"/>
                <input type="hidden" name="complementName" value="wica"/>
                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue  modal_btn add_comp btn-sm">Save</button>
                    <button type='button' class='btn modal_btn add_comp cancel_btn btn-sm' onclick="goBack();">Cancel</button>
                </div>
            </form>
            <%
            } else if (complement.equals("ncm")) {
                //non criminal case milestone
                ArrayList<String> ncList = DropdownDAO.retrieveAllDropdownListOfMilestoneNonCriminal();
            %>
            <form method="POST" action="../addProblemComplement.do" class="form form-inline col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" id='problemComplements'>
                <h4>Add milestone NC</h4>

                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Worker's name</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkername" value='<%=workerName%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >FIN</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Employer</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="employer" value="<%=employer%>" readonly="true"/>
                    </div><br/><br/>
                </div>

                <!-- details about complement -->
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='milestoneNCDate' class="col-xs-4 col-sm-5 col-md-5 control-label"><span style="color: red">*</span>Date of update: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput" type='text' name="ndate" value="<%=sdf.format(today)%>" style='width:100%;'></div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nmilestoneNCReached' class="col-xs-4 col-sm-5 col-md-5 control-label"><span style="color: red">*</span>Milestone reached:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm" id="ncReached" name="nmilestoneNCReached" >
                            <option value="" selected>Select from list...</option>
                            <%
                                for (String reached : ncList) {
                            %>
                            <option value="<%=reached%>"><%=reached%></option>
                            <%

                                }
                            %>  
                        </select></div><br/><br/>
                </div>

                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nmilestoneNCReachedMore' class="col-xs-4 col-sm-5 col-md-5 control-label">Explain if above is 'Other': </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control" name="nmilestoneNCReachedMore" rows="3" style='width:100%;'></textarea>
                    </div><br/><br/>
                </div>

                <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
                <input type="hidden" name="probKey" value="<%=probKey%>"/>
                <input type="hidden" name="complementName" value="ncmilestone"/>
                <input type="hidden" name="associate" value="associate"/>
                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue  modal_btn add_comp btn-sm">Save</button>
                    <button type='button' class='btn modal_btn add_comp cancel_btn btn-sm' onclick="goBack();">Cancel</button>
                </div>
            </form>
            <%
            } else if (complement.equals("ttr")) {
                ArrayList<String> ttrList = DropdownDAO.retrieveAllDropdownListOfTTRStatus();
            %>
            <form method="POST" action="../addProblemComplement.do" class="form form-inline col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" id='problemComplements'>
                <h4>Add TTR</h4>

                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Worker's name</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkername" value='<%=workerName%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >FIN</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Employer</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="employer" value="<%=employer%>" readonly="true"/>
                    </div><br/><br/>
                </div>

                <!-- details about complement -->
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='ttrUpdate' class="col-xs-4 col-sm-5 col-md-5 control-label"><span style="color: red">*</span>Date of update: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput input-sm" type='text' name="ndate" value="<%=sdf.format(today)%>">
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nttrStatus' class="col-xs-4 col-sm-5 col-md-5 control-label"><span style="color: red">*</span>Transfer, TJS, repat status:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <select class="form-control input-sm" name="nttrStatus" >
                            <option value="" selected>Select from list...</option>
                            <%
                                for (String tempStatus : ttrList) {
                            %>
                            <option value="<%=tempStatus%>"><%=tempStatus%></option>
                            <%

                                }
                            %>  
                        </select>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='nttrStatusMore' class="col-xs-4 col-sm-5 col-md-5 control-label">Explain if above is 'Other': </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control input-sm" name="nttrStatusMore" rows="3" style="width:100%"></textarea>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='ttrDepartureDate' class="col-xs-4 col-sm-5 col-md-5 control-label">Departure date:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="nttrDepartureDate">
                    </div><br/><br/>
                </div>

                <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
                <input type="hidden" name="probKey" value="<%=probKey%>"/>
                <input type="hidden" name="complementName" value="ttr"/>
                <input type="hidden" name="associate" value="associate"/>
                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue  modal_btn add_comp btn-sm">Save</button>
                    <button type='button' class='btn modal_btn add_comp cancel_btn btn-sm' onclick="goBack();">Cancel</button>
                </div>
            </form>
            <%
            } else if (complement.equals("refer")) {
                String phNum = "";
                if (worker != null) {

                    ArrayList<Integer> sgPhList = WorkerComplementsDAO.retrieveSgCountryPhoneNumIdsOfWorker(worker);
                    if (sgPhList != null && sgPhList.size() > 0) {
                        WorkerSgPhNum sgPh = WorkerComplementsDAO.retrieveWorkerSgPhNumById(sgPhList.get(sgPhList.size() - 1));
                        phNum = sgPh.getPhNumber();
                    }

                }
            %>
            <form method="POST" action="../referCase.do"  id='caseReferral_form' class="form form-inline col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" >
                <h4>Refer Case</h4>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='refDate' id="refDate_lbl" class="col-xs-4 col-sm-5 col-md-5 control-label">Referred Date:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="refDate" value="<%=sdf.format(today)%>" readonly='true'>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='workerName' id="workerName_lbl" class="col-xs-4 col-sm-5 col-md-5 control-label">Name of Worker: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm no_change" type='text' name="workerName" value="<%=workerName%>" readonly='true'>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='workerName' id="workerFin_lbl" class="col-xs-4 col-sm-5 col-md-5 control-label">Worker FIN Number: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm no_change" type='text' name="workerFin" value="<%=workerFin%>" readonly='true'>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='phNum' class="col-xs-4 col-sm-5 col-md-5 control-label" id="phNum_lbl">Worker Phone Number: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm no_change" type='text' name="phNum" value="<%=phNum%>" readonly='true'>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='empName' id="empName_lbl" class="col-xs-4 col-sm-5 col-md-5 control-label">Employer Name: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm no_change" type='text' name="empName" value="<%=employer%>" readonly='true'>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='probType' id="probType_lbl" class="col-xs-4 col-sm-5 col-md-5 control-label">Problem: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm no_change" type='text' name="probType" value="<%=problem%>" readonly='true'>
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='refDesc' class="col-xs-4 col-sm-5 col-md-5 control-label">Description: </label><div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class='form-control' row='3' name="refDesc" style="width:100%"></textarea>
                    </div><br/><br/>
                </div>
                <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
                <input type="hidden" name="probkey" value="<%=probKey%>"/>
                <input type="hidden" name="referredBy" value="<%=userLogin.getNricNumber()%>"/>
                <input type="hidden" name="associate" value="associate"/>
                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue modal_btn ">Refer</button>
                    <button type='button' class='btn modal_btn cancel_btn' onclick="goBack();">Cancel</button>

                </div>
            </form>
            <%
            } else if (complement.equals("r2r")) {
            %>
            <form method="POST" action="../addProblemComplement.do" class="form form-inline col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-2 col-sm-8" id='problemComplements'>
                <h4>Add R2R appointment</h4>
                <button type="button" class='btn btn-blue pull-right btn-sm' onclick="window.location = 'r2r.jsp?worker=<%=workerFin%>&selectedJob=<%=jobKeyStr%>&selectedProb=<%=probKeyStr%>&action=viewHistory';">View R2R History</button><br/><br/><br/>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Worker's name:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkername" value='<%=workerName%>' readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >FIN:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="wkerFin" value="<%=workerFin%>" readonly="true"/>
                    </div><br/><br/>
                </div>
                <div class="form-group col-md-12 col-sm-12 col-xs-12">
                    <label for="emp_name" class="col-xs-4 col-sm-5 col-md-5 control-label" >Employer:</label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input type="text" class="form-control required input-sm" name="employer" value="<%=employer%>" readonly="true"/>
                    </div><br/><br/><br/>
                </div>

                <!-- details about complement -->
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='r2rDate' class="col-xs-4 col-sm-5 col-md-5 control-label">Date of appointment<span style="color: red">*</span>: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control dateInput input-sm" type='text' name="ndate" value="<%=sdf.format(today)%>">
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='r2rTime' class="col-xs-4 col-sm-5 col-md-5 control-label">Time of appointment: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="nr2rTime">
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='r2rHosp' class="col-xs-4 col-sm-5 col-md-5 control-label">Hospital for appointment<span style="color: red">*</span>: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="nr2rHosp">
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='r2rDept' class="col-xs-4 col-sm-5 col-md-5 control-label">Department/doctor for appointment: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="nr2rDept">
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='r2r1' class="col-xs-4 col-sm-5 col-md-5 control-label">R2R first volunteer: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="nr2r1">
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='r2r2' class="col-xs-4 col-sm-5 col-md-5 control-label">R2R second volunteer: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="nr2r2">
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='r2rPurpose' class="col-xs-4 col-sm-5 col-md-5 control-label">Purpose of appointment: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <input class="form-control input-sm" type='text' name="nr2rPurpose">
                    </div><br/><br/>
                </div>
                <div class='form-group col-md-12 col-sm-12 col-xs-12'>
                    <label for='r2rPreApptNotes' class="col-xs-4 col-sm-5 col-md-5 control-label">Pre-appointment notes: </label>
                    <div class="col-xs-8 col-sm-7 col-md-7">
                        <textarea class="form-control" name="nr2rPreApptNotes" rows="3" style='width:100%'></textarea>
                    </div><br/><br/>
                </div>

                <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobkey" value="<%=jobKey%>"/>
                <input type="hidden" name="probKey" value="<%=probKey%>"/>
                <input type="hidden" name="complementName" value="r2r"/>
                <input type="hidden" name="associate" value="associate"/>
                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue  modal_btn add_comp btn-sm">Save</button>
                    <button type='button' class='btn modal_btn add_comp cancel_btn btn-sm' onclick="goBack();">Cancel</button>
                </div>
            </form>
            <%
                    }
                }
            %>
        </div>
    </body>
</html>
