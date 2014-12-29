<%-- 
    Document   : createWorker
    Created on : Oct 23, 2014, 11:15:04 AM
    Author     : soemyatmyat
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="camans.entity.Worker"%>
<%@ include file="protect.jsp"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page import="camans.entity.User"%>
<%
    User userLogin = (User) request.getSession().getAttribute("userLogin");
    ArrayList<String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
    ArrayList<String> problemList = DropdownDAO.retrieveAllDropdownListOfProblems();
    ArrayList<String> passTypeList = DropdownDAO.retrieveAllDropdownListOfPassType();
    ArrayList<String> jobSectorList = DropdownDAO.retrieveAllDropdownListOfJobSector();
    ArrayList<String> hospitalList = DropdownDAO.retrieveAllDropdownListOfHosptialType();
    ArrayList<String> lawFirmList = DropdownDAO.retrieveAllDropdownListOfLawFirms();

    String status = (String) request.getSession().getAttribute("status");
    request.getSession().removeAttribute("status");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.min.css" media="screen" />
        <link rel="stylesheet" href="css/bootstrap-theme.min.css" media="screen" />

        <link rel="stylesheet" href="css/custom.css" media="screen" /> 
        <!--jasny-bootstrap v3.1.3 added by smm-->
        <link rel="stylesheet" href="css/jasny-bootstrap.css"/>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
        <link rel="stylesheet" href="css/bootstrapValidator.min.css"/>


        <script src="js/jquery-2.1.1.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
        <script src="js/jquery.steps.js"></script>
        <!--jasny-bootstrap v3.1.3 added by smm-->
        <script src="js/jasny-bootstrap.js"></script>    

        <script type="text/javascript" src="js/bootstrapValidator.min.js"></script>

        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>JSP Page</title>


        <script>
            $(function() {
                $(".dateInput").datepicker({
                    dateFormat: 'dd-M-yy',
                    changeMonth: true,
                    changeYear: true,
                    maxDate: 0,
                    yearRange: "-100:nn"
                });

            });

            //for date inputs
            $(document).ready(function() {

                $('.dateInput').focus(function() {
                    $('.dateInput').blur();
                });
            });

            $(document).ready(function() {
                $('.no_change').focus(function() {
                    $('.no_change').blur();
                });
            });

            function swapDiv(div_id, curr_id, num) {
                var curr_div_id = "#" + curr_id;
                var val = 0;
                var missing_input_field = "";
                if(num === 1){
                $('.required',curr_div_id).each(function() {
                    if (this.value.trim() === '') {
                        missing_input_field = $(this).attr('name');
                        val = 1;
                    }
                });
                }
                if (val === 0) {
                    $('.sub_div').hide();
                    document.getElementById(div_id).style.display = 'block';
                    var li_id = 'progtrckr_' + div_id;
                    if (num === 1) {
                        var div = document.getElementById(li_id);
                        div.setAttribute("class", 'progtrckr-done');
                    } else {
                        li_id = 'progtrckr_' + curr_id;
                        var div = document.getElementById(li_id);
                        div.setAttribute("class", 'progtrckr-todo');
                    }
                    //$('.next_btn').prop('disabled',false);
                } else {
                    //$('.next_btn').prop('disabled',true);
                    if(missing_input_field === "finNum"){
                        alert("FIN Number is required.");
                    }else if(missing_input_field === "workerName"){
                        alert("Worker Name is required.")
                    }else if(missing_input_field === 'employerName'){
                        alert("Employer Name is required.")
                    }
                    //alert("Some fields are missing. Please enter all the required fields.");
                }
            }

            //display others
            function displayOther(div_id) {
                var div = document.getElementById(div_id);
                if (document.getElementById(div_id).value === 'Other' || document.getElementById(div_id).value === "other") {
                    var other_div = div_id + "_other_div";
                    document.getElementById(other_div).style.display = 'block';
                }
            }
        </script>
    </head>
    <body id="createCase">
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>
        <!-- Progress Tracker -->
        <div class="col-md-10">
            <div class="col-md-offset-3 col-md-6" id="progtrckr">
                <ol class="progtrckr" data-progtrckr-steps="3">
                    <li id="progtrckr_worker_profile" class="progtrckr-done"></li><!--
                    --><li id="progtrckr_job_profile" class="progtrckr-todo"></li><!--
                    --><li id="progtrckr_prob_profile" class="progtrckr-todo"></li>
                </ol>
            </div>
        </div>
        <!-- Create Case From -->
        <div class="col-md-10">
            <div class="col-xs-12 col-md-12" >
                <%
                    if (status == null) {
                        java.util.Date date = new java.util.Date();
                        SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");

                %>
                <form method="post" action="createNewCase.do" class="form-horizontal col-md-offset-1 col-md-10" 
                      id="createworker_form" role="form" enctype="multipart/form-data">

                    <!--worker profile-->
                    <div class="sub_div" id="worker_profile">

                        <br/>
                        <h2 id="title">Case Creation Form - Worker Profile</h2>
                        <br/>
                        <div class="form-group">
                            <label for="registration_date_In" class=" col-md-3 control-label">Registration Date <span class="required_input">*</span> </label>
                            <div class="col-md-4">
                                <input type="text" class="form-control input-append date dateInput" name="registeredDate" value="<%=sdf.format(date)%>"  />
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="created_by_In" class="col-md-3 control-label">Created By</label>
                            <div class=" col-md-6">
                                <input type="text" class="form-control no_change" name="createdBy" value="<%=userLogin.getUsername()%>" />
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="created_for_In" class="col-md-3 control-label">Created For</label>
                            <div class=" col-md-6">
                                <input type="text" name="createdFor" class="form-control"/>
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="worker_name" class="col-md-3 control-label " >Name of Worker <span class="required_input">*</span> </label>
                            <div class=" col-md-6">
                                <input type="text" class="form-control required" name="workerName"/>
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="worker_fin" class="col-md-3 control-label">FIN <span class="required_input">*</span></label>
                            <div id="fin" class=" col-md-4">
                                <input type="text" id="finNum"  class="form-control required" name="finNum"/>
                            </div>
                            <div id="finButton" class="col-md-4">
                                <button type="" id="generateTWC2Fin" class="btn btn-default">Generate FIN</button>
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="worker_gender" class="col-md-3 control-label">Gender</label>
                            <div class=" col-md-6">
                                <select class="form-control" name="gender">
                                    <option>Male</option>
                                    <option>Female</option>
                                </select>
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="worker_nationality" class="col-md-3 control-label">Nationality</label>
                            <div class="col-md-6">
                                <select class="form-control" id="worker_nationality" name="nationality" onchange="displayOther(this.id);"/>
                                <%
                                    for (String nationalityStr : nationalityList) {
                                %>
                                <option><%=nationalityStr%></option>
                                <%
                                    }
                                %>                                               
                                </select>
                            </div>
                        </div>

                        <!--this to appear only if above is selected as other-->
                        <div class="form-group" id="worker_nationality_other_div" style="display:none">
                            <label for="worker_nationality_other_In" class="col-md-3 control-label">Explain if above is other</label>
                            <div class=" col-md-6">
                                <input type="text" class="form-control" name="nationalityMore">
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="worker_dob" class=" col-md-3 control-label">Date of Birth</label>
                            <div class="col-md-4">
                                <input class="form-control input-append date dateInput" type="text" class="dateInput"  name="dob"/>
                            </div>
                        </div>


                        <div class="form-group btn-div col-md-12" >
                            <span class="required_input">* Required field</span>
                            <button type='button' onclick="swapDiv('job_profile', 'worker_profile', 1);" class="btn btn-default pull-right next_btn" style="bottom: 0">Next  <span class="glyphicon glyphicon-arrow-right"></span></button>
                        </div>
                    </div>

                    <!--Job Profile-->
                    <div class="sub_div" id="job_profile" style="display : none; position: relative">

                        <br/>
                        <h2 id="title">Case Creation Form - Job Profile</h2>
                        <br/>

                        <div class="form-group">
                            <label for="emp_name" class="col-md-3 control-label" >Name of Employer <span class="required_input">*</span> </label>
                            <div class=" col-md-6">
                                <input type="text" class="form-control required" id="employerName" name="employerName" /></div>
                        </div>


                        <div class="form-group">
                            <label for="job_pass_type" class="col-md-3 control-label">Work pass type that comes with the job<span class="required_input">*</span></label>
                            <div class=" col-md-6">
                                <select name="workpassType" class="form-control" id="job_pass_type" onchange="displayOther(this.id);">
                                    <%
                                        for (String passTypeStr : passTypeList) {
                                    %>
                                    <option><%=passTypeStr%></option>
                                    <%
                                        }
                                    %>   
                                </select>
                            </div>
                        </div>


                        <!--this to appear only if above is selected as other-->
                        <div class="form-group" id="job_pass_type_other_div" style="display:none">
                            <label for="job_pass_type_other_In" class="col-md-3 control-label">Explain if above is 'Other'</label>
                            <div class=" col-md-6">
                                <input type="text" class="form-control" name="workpassMore"/></div>
                        </div>


                        <div class="form-group">
                            <label for="job_sector" class="col-md-3 control-label">Job Sector</label>
                            <div class=" col-md-6">
                                <select class="form-control" name="jobSector" id="job_sector" onchange="displayOther(this.id);" >
                                    <%
                                        for (String jobSectorStr : jobSectorList) {
                                    %>
                                    <option><%=jobSectorStr%></option>
                                    <%
                                        }
                                    %>   
                                </select>
                            </div>
                        </div>


                        <!--this to appear only if above is selected as other-->
                        <div class="form-group" id="job_sector_other_div" style="display:none">
                            <label for="job_sector_other_In" class="col-md-3 control-label">Explain if above is other</label>
                            <div class=" col-md-6">
                                <input type="text" class="form-control" name="jobSectorMore" /></div>
                        </div>

                        <div class="form-group">
                            <label for="occupation" class="col-md-3 control-label" >Occupation</label>
                            <div class=" col-md-6">
                                <input type="text" class="form-control" name="occupation"/></div>
                        </div>


                        <div class="form-group">
                            <label for="job_start_date" class="col-md-3 control-label" >When Job Start?</label>
                            <div class=" col-md-3">
                                <input type="text" class="form-control" name="jobStartDate"/></div>
                        </div>

                        <div class="form-group">
                            <label for="job_end_date" class="col-md-3 control-label">When Job End?</label>
                            <div class=" col-md-3">
                                <input type="text"  class="form-control" name="jobEndDate"/></div>
                        </div>


                        <div class="form-group">
                            <label for="is_tjs" class="col-md-3 control-label">Is this a TJS job?</label>
                            <div class=" col-md-6">
                                <select name="tjs" class="form-control">
                                    <option>No</option>
                                    <option>Yes</option>
                                </select>
                            </div>
                        </div>


                        <div class="form-group" id="job_sector_other_div">
                            <label for="job_remark" class="col-md-3 control-label">Remark</label>
                            <div class=" col-md-6">
                                <input type="text" class="form-control" name="jobRemark"/> 
                            </div>
                        </div>


                        <div class="form-group btn-div col-md-12" style='position: relative'>
                            <span class="required_input">* Required field</span>
                            <div class="pull-right">
                                <button type='button' onclick="swapDiv('worker_profile', 'job_profile', -1);" class="btn btn-default" style="bottom: 0">Back  <span class="glyphicon glyphicon-arrow-left"></span></button>
                                <button type='button' onclick="swapDiv('prob_profile', 'job_profile', 1);" class="btn btn-default next_btn" style="bottom: 0">Next  <span class="glyphicon glyphicon-arrow-right"></span></button>
                            </div>
                        </div>

                    </div>

                    <!--problem profile-->
                    <div class="sub_div" id="prob_profile" style="display : none">
                        <br/>
                        <h2 id="title">Case Creation Form - Problem Profile</h2> 
                        <br/>

                        <div class="form-group">
                            <label for="prob_type" class="col-md-3 control-label">Problem Type<span class="required_input">*</span></label>
                            <div class=" col-md-6"> 
                                <select name="problem" id="prob_type" class="form-control" onchange="displayOther(this.id);">
                                    <%
                                        for (String problemStr : problemList) {
                                    %>
                                    <option><%=problemStr%></option>
                                    <%
                                        }
                                    %>                   
                                </select>
                            </div>
                        </div>


                        <!--this to appear only if above is selected as other-->
                        <div class="form-group" id="prob_type_other_div" style="display:none">
                            <label for="worker_pass_type_other_In" class="col-md-3 control-label">Explain if above is other</label>
                            <div class=" col-md-6">
                                <input type="text" class="form-control" name="problemMore" /></div>
                        </div>


                        <div class="form-group" id="job_sector_other_div" >
                            <label for="prob_remark" class="col-md-3 control-label">Remark</label>
                            <div class=" col-md-6">
                                <input type="text" class="form-control" name="problemRemark" /></div>
                        </div>


                        <div id="injury_div" style="display : none">
                            <div class="form-group">
                                <label for="injury_date" class="col-md-3 control-label" >Injury Date</label>
                                <div class=" col-md-3">
                                    <input type="text" class="dateInput" class="form-control" name="injuryDate"/></div>
                            </div>
                            <div class="form-group">
                                <label for="injury_body_part" class="col-md-3 control-label" >Injury Body Part</label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control" name="injuryBodyPart"/></div>
                            </div>

                            <div class="form-group">
                                <label for="prob_hospital" class="col-md-3 control-label">Current Hospital</label>
                                <div class=" col-md-6">
                                    <select class="form-control" name="currentHosptial" id="prob_hospital" onchange="displayOther(this.id);" >
                                        <%
                                            for (String hospitalStr : hospitalList) {
                                        %>
                                        <option><%=hospitalStr%></option>
                                        <%
                                            }
                                        %> 
                                    </select>
                                </div>
                            </div>


                            <div class="form-group" id="prob_hospital_other_div" style="display:none">
                                <label for="prob_hospital_other_In" class="col-md-3 control-label">Explain if above is other</label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control" name="hospitalMore" /></div>
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="has_lawyer" class="col-md-3 control-label">Does worker have lawyer for this problem?</label>
                            <div class=" col-md-6">
                                <select class="form-control" name="lawyerHas">
                                    <option>No</option>
                                    <option>Yes</option>
                                </select>
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="law_firm_name" class="col-md-3 control-label" >Name of Law Firm</label>
                            <div class=" col-md-6">
                                <select class="form-control" name="lawfirmName" id="lawfirmName" >
                                    <%
                                        for (String lawFirmStr : lawFirmList) {
                                    %>
                                    <option><%=lawFirmStr%></option>
                                    <%
                                        }
                                    %> 
                                </select>

                            </div>
                        </div>


                        <div class="form-group btn-div col-md-12">
                            <span class="required_input">* Required field</span>
                            <div class="pull-right">
                                <button  type='button' onclick="swapDiv('job_profile', 'prob_profile', -1);" class="btn btn-default">Back  <span class="glyphicon glyphicon-arrow-left"></span></button>
                                <button type='button' onclick="swapDiv('face_pic', 'prob_profile', 1);" class="btn btn-default next_btn">Next  <span class="glyphicon glyphicon-arrow-right"></span></button>
                            </div>
                        </div>
                    </div>

                    <div class="sub_div" id="face_pic" style="display : none">
                        <br/>
                        <h2 id="title">Case Creation Form - Upload Face Photo </h2>
                        <br/>

                        <!--
                        <div class="form-group" id="job_sector_other_div" >
                            <label for="facePic" class="col-md-3 control-label">Upload Face Picture</label>
                            <div class=" col-md-6">
                                <input type="file" class="form-control" name="facePic" /></div>
                                
                                
                        </div>
                        -->

                        <!--- Face Picture -->
                        <div class="fileinput fileinput-new" data-provides="fileinput">
                            <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                <img data-src="holder.js/100%x100%" alt="...">
                            </div>
                            <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                            <div>
                                <span class="btn btn-default btn-file">
                                    <span class="fileinput-new">Select image</span>
                                    <span class="fileinput-exists">Change</span><input type="file" name="facePic">
                                </span>
                                <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                            </div>
                        </div>

                        <div class="form-group btn-div col-md-12">
                            <span class="required_input">* Required field</span>
                            <div class="pull-right">
                                <button  type='button' onclick="swapDiv('prob_profile', 'face_pic', -1);" class="btn btn-default">Back  <span class="glyphicon glyphicon-arrow-left"></span></button>
                                <button  type='submit' class="btn btn-default">Submit</button>

                            </div>
                        </div>


                    </div>
                </form> 
                <%
                } else {
                    Worker worker = (Worker) request.getSession().getAttribute("worker");
                %>
                Case for Worker <a href="viewWorker.jsp?worker=<%=worker.getFinNumber()%>"> <%=worker.getFinNumber()%> </a> has been created successfully.<br/>
                To View, please click <a href="viewWorker.jsp?worker=<%=worker.getFinNumber()%>"><%=worker.getFinNumber()%></a>.<br/>
                To create new case for new worker. Please click <a href="createCase.jsp">Create Worker</a>.<br/>

                <%
                    }
                %>
            </div>

        </div>

    </body>
</html>
<script>

            //form validation 
            $(document).ready(function() {


                $('#createworker_form')
                        .bootstrapValidator({
                    fields: {
                        //worker
                        workerName: {
                            validators: {
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                },
                                stringLength: {
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        finNum: {
                            validators: {
                                stringLength: {
                                    max: 12,
                                    message: 'This field must be less than 12 characters.'
                                },
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                },
                                regexp: {
                                    regexp: /^[A-Z][0-9]{7}[A-Z]/,
                                    message: 'FIN must start with an alphabet followed by 7 digits and ends with an alphabet.'
                                },
                                remote: {
                                    message: 'The FIN Number already exists.',
                                    url: 'processValidate',
                                    data: function(validator) {
                                        return {
                                            finNum: validator.getFieldElements('finNum').val()
                                        };
                                    }
                                }
                            }
                        },
                        nationalityMore: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        createdFor: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'This field must be less than 20 characters.'
                                }
                            }
                        },
                        //job Profile
                        employerName: {
                            validators: {
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                },
                                stringLength: {
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        workpassMore: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        jobSectorMore: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        occupation: {
                            validators: {
                                stringLength: {
                                    min: 0,
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        jobStartDate: {
                            validators: {
                                stringLength: {
                                    min: 0,
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        jobEndDate: {
                            validators: {
                                stringLength: {
                                    min: 0,
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        jobRemark: {
                            validators: {
                                stringLength: {
                                    min: 0,
                                    max: 200,
                                    message: 'This field must be less than 200 characters.'
                                }
                            }
                        },
                        //problem profile
                        problemMore: {
                            validators: {
                                stringLength: {
                                    max: 50,
                                    message: 'This field must be less than 50 characters.'
                                }
                            }
                        },
                        problemRemark: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must be less than 200 characters.'
                                }
                            }
                        }
                    }

                });

            });


<!--added by soemyatmyat for generating TWC2 In-house FinNumber-->

            $('#generateTWC2Fin').click(function() {
                $.ajax({
                    type: "post",
                    url: "generateTWC2Fin.do",
                    success: function(msg)
                    {
                        $("#fin").html("<input type=\"text\" id=\"finNum\" class=\"form-control\" name=\"finNum\" value="
                                + msg + "/>").fadeIn("slow");
                        //$("#finButton").html("<button type=\"button\" id=\"inputFin\" class=\"btn btn-default\">" + 
                        //     "Input Fin</button>");
                    }
                });
            });


</script>  