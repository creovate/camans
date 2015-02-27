<%-- 
    Document   : createWorker
    Created on : Oct 23, 2014, 11:15:04 AM
    Author     : soemyatmyat
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="camans.entity.Worker"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.DropdownDAO"%>
<%@page import="camans.entity.User"%>
<%@ include file="protect.jsp"%>

<%
    User userLogin = (User) request.getSession().getAttribute("userLogin");
    ArrayList<String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
    ArrayList<String> problemList = DropdownDAO.retrieveAllDropdownListOfProblems();
    ArrayList<String> passTypeList = DropdownDAO.retrieveAllDropdownListByType("Work_pass_type");
    ArrayList<String> jobSectorList = DropdownDAO.retrieveAllDropdownListOfJobSector();
    //ArrayList<String> hospitalList = DropdownDAO.retrieveAllDropdownListOfHosptialType();
    //ArrayList<String> lawFirmList = DropdownDAO.retrieveAllDropdownListOfLawFirms();

    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    java.util.Date today = new java.util.Date();
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
        <!--bootstrap session timeout, added by soemyatmyat-->
        <script src="js/bootstrap-session-timeout.min.js"></script> 

        <script type="text/javascript" src="js/bootstrapValidator.min.js"></script>


        <script src="js/ajax.js"></script>
        <script src="js/core.js"></script>
        <script src="js/delegate.js"></script>
        <script src="js/jquery.validate.js"></script>
        <script src="js/additional-methods.js"></script>
        <link rel="shortcut icon" href="img/twc_logo.png">
        <title>CAMANS</title>


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
                //methods for jquery validator
                jQuery.validator.addMethod("FIN", function(value, element) {
                    return this.optional(element) || /^[A-Z][0-9]{7}[A-Z]$/.test(value) || /^GEN[0-9]{6}$/.test(value);
                }, "Invalid FIN number format. Please check again.");
                jQuery.validator.addMethod("FileSize", function(value, element) {
                    return this.optional(element) || (element.files[0].size <= 1048576);
                }, "Invalid File size. Please Check again.");
                //validation
                $('#createworker_form').validate({
                    //ignore: ":hidden",
                    rules: {
                        finNum: {
                            required: true,
                            FIN: true,
                            remote: {
                                url: "processValidate",
                                type: "POST",
                                data: {
                                    finNum: function() {
                                        return $("#finNum").val();
                                    }
                                }
                            }
                        },
                        facePic: {
                            accept: "image/png,image/jpeg,image/jpg,image/bmp",
                            extension: "png,jpeg,jpg,bmp",
                            FileSize: true
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
            });
            function swapDiv(div_id, curr_id, num) {
                if (num === 1 && $('#createworker_form').valid() === false) {
                    alert('The form is invalid. Please check again');
                } else {

                    var curr_div_id = "#" + curr_id;
                    var val = 0;
                    var missing_input_field = "";
                    if (num === 1) {
                        $('.required', curr_div_id).each(function() {
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

                        //alert("Some fields are missing. Please enter all the required fields.");
                    }
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

            //session time out
            $.sessionTimeout({
                message: 'Your session will be expired in one minute.',
                keepAliveUrl: 'keep-alive.html',
                logoutUrl: 'index.jsp',
                redirUrl: 'logout.jsp',
                warnAfter: 900000,
                redirAfter: 960000
            });</script>
    </head>
    <body id="createCase">
        <jsp:include page="include/navbartop.jsp"/>
        <jsp:include page="include/navbarside.jsp"/>
        <div class="col-md-offset-2 col-md-10">
            <!-- Progress Tracker -->
            <div class="col-md-12">
                <div class="col-md-offset-3 col-md-6" id="progtrckr">
                    <ol class="progtrckr" data-progtrckr-steps="3">
                        <li id="progtrckr_worker_profile" class="progtrckr-done"></li><!--
                        --><li id="progtrckr_job_profile" class="progtrckr-todo"></li><!--
                        --><li id="progtrckr_prob_profile" class="progtrckr-todo"></li>
                    </ol>
                </div>
            </div>
            <!-- Create Case From -->
            <div class="col-md-12">
                <div class="col-xs-12 col-md-12" >
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
                                    <input type="text" class="form-control input-append date dateInput" name="registeredDate" value="<%=sdf.format(today)%>"  />
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
                                    <input type="text" name="createdFor" class="form-control" maxlength="20"/>
                                </div>
                            </div>


                            <div class="form-group">
                                <label for="worker_name" class="col-md-3 control-label " >Name of Worker <span class="required_input">*</span> </label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control required" name="workerName" maxlength="50" required/>
                                </div>
                            </div>


                            <div class="form-group">
                                <label for="worker_fin" class="col-md-3 control-label">FIN <span class="required_input">*</span></label>
                                <div id="fin" class=" col-md-4">
                                    <input type="text" id="finNum"  class="form-control required" name="finNum"/>
                                </div>
                                <div id="finButton" class="col-md-4">
                                    <button type="" id="generateTWC2Fin" class="btn btn-blue ">Generate FIN</button>
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

                            <!--this to appear only if above is selected as other-->
                            <div class="form-group" id="worker_nationality_other_div">
                                <label for="worker_nationality_other_In" class="col-md-3 control-label">Explain if above is other</label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control" name="nationalityMore" maxlength="50"/>
                                </div>
                            </div>


                            <div class="form-group">
                                <label for="worker_dob" class=" col-md-3 control-label">Date of Birth</label>
                                <div class="col-md-4">
                                    <input class="form-control input-append date dateInput" type="text" class="dateInput"  name="dob"/>
                                </div>
                            </div>


                            <div class="form-group btn btn-blue-div col-md-12" >

                                <button type='button' onclick="swapDiv('job_profile', 'worker_profile', 1);" class="btn btn-blue pull-right next_btn" id="next_btn" style="bottom: 0">Next  <span class="glyphicon glyphicon-arrow-right"></span></button>
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
                                    <input type="text" class="form-control required" id="employerName" name="employerName" maxlength="50" required/></div>
                            </div>


                            <div class="form-group">
                                <label for="job_pass_type" class="col-md-3 control-label">Work pass type that comes with the job<span class="required_input">*</span></label>
                                <div class=" col-md-6">
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


                            <!--this to appear only if above is selected as other-->
                            <div class="form-group" id="job_pass_type_other_div">
                                <label for="job_pass_type_other_In" class="col-md-3 control-label">Explain if above is 'Other'</label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control" name="workpassMore" maxlength="50"/></div>
                            </div>


                            <div class="form-group">
                                <label for="job_sector" class="col-md-3 control-label">Job Sector</label>
                                <div class=" col-md-6">
                                    <select class="form-control" name="jobSector" id="job_sector" >
                                        <option value="">Select Job Sector:</option>
                                        <%
                                            for (String jobSectorStr : jobSectorList) {
                                        %>
                                        <option value="<%=jobSectorStr%>"><%=jobSectorStr%></option>
                                        <%
                                            }
                                        %>   
                                    </select>
                                </div>
                            </div>


                            <!--this to appear only if above is selected as other-->
                            <div class="form-group" id="job_sector_other_div">
                                <label for="job_sector_other_In" class="col-md-3 control-label">Explain if above is other</label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control" name="jobSectorMore" maxlength="50"/></div>
                            </div>

                            <div class="form-group">
                                <label for="occupation" class="col-md-3 control-label" >Occupation</label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control" name="occupation" maxlength="50"/></div>
                            </div>


                            <div class="form-group">
                                <label for="job_start_date" class="col-md-3 control-label" >When Job Start?</label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control" name="jobStartDate" maxlength="50"/></div>
                            </div>

                            <div class="form-group">
                                <label for="job_end_date" class="col-md-3 control-label">When Job End?</label>
                                <div class=" col-md-6">
                                    <input type="text"  class="form-control" name="jobEndDate" maxlength="50"/></div>
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
                                <label for="job_remark" class="col-md-3 control-label">Remark about Job:</label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control" name="jobRemark" maxlength="200"/> 
                                </div>
                            </div>


                            <div class="form-group btn btn-blue-div col-md-12" style='position: relative'>

                                <div class="pull-right">
                                    <button type='button' onclick="swapDiv('worker_profile', 'job_profile', -1);" class="btn btn-blue btn btn-blue-default" style="bottom: 0">Back  <span class="glyphicon glyphicon-arrow-left"></span></button>
                                    <button type='button' onclick="swapDiv('prob_profile', 'job_profile', 1);" class="btn btn-blue btn btn-blue-default next_btn"  id="next_btn" style="bottom: 0">Next  <span class="glyphicon glyphicon-arrow-right"></span></button>
                                </div>
                            </div>

                        </div>

                        <!--problem profile-->
                        <div class="sub_div" id="prob_profile" style="display : none">
                            <br/>
                            <h2 id="title">Case Creation Form - Problem Profile</h2> 
                            <br/>

                            <div class='form-group'>
                                <label for='isdate' class="col-md-3 control-label">Problem Registration Date<span class="required_input">*</span>: </label>

                                <div class='col-md-6'>
                                    <input class="form-control dateInput" type='text' name="problemRegDate" value="<%=sdf.format(today)%>" required>
                                </div>
                                <br/>
                            </div>

                            <div class="form-group">
                                <label for="prob_type" class="col-md-3 control-label">Problem Presented<span class="required_input">*</span></label>
                                <div class=" col-md-6"> 
                                    <select name="problem" id="prob_type" class="form-control" required>
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


                            <!--this to appear only if above is selected as other-->
                            <div class="form-group" id="prob_type_other_div">
                                <label for="worker_pass_type_other_In" class="col-md-3 control-label">Explain if above is other</label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control" name="problemMore" maxlength="50" /></div>
                            </div>


                            <div class="form-group" id="job_sector_other_div" >
                                <label for="prob_remark" class="col-md-3 control-label">Remark about Problem:</label>
                                <div class=" col-md-6">
                                    <input type="text" class="form-control" name="problemRemark" maxlength="200"/></div>
                            </div>

                            <div class="form-group btn btn-blue-div col-md-12">

                                <div class="pull-right">
                                    <button  type='button' onclick="swapDiv('job_profile', 'prob_profile', -1);" class="btn btn-blue btn btn-blue-default">Back  <span class="glyphicon glyphicon-arrow-left"></span></button>
                                    <button type='button' onclick="swapDiv('face_pic', 'prob_profile', 1);" class="btn btn-blue next_btn" id="next_btn" >Next  <span class="glyphicon glyphicon-arrow-right"></span></button>
                                </div>
                            </div>
                        </div>

                        <div class="sub_div" id="face_pic" style="display : none">
                            <br/>
                            <h2 id="title">Case Creation Form - Upload Face Photo </h2>
                            <br/>

                            <!--- Face Picture -->
                            <div class="fileinput fileinput-new" data-provides="fileinput">
                                <div class="fileinput-new thumbnail" style="width: 200px; height: 150px;">
                                    <img data-src="holder.js/100%x100%" alt="...">
                                </div>
                                <div class="fileinput-preview fileinput-exists thumbnail" style="max-width: 200px; max-height: 150px;"></div>
                                <div>
                                    <span class="btn btn-default btn-file">
                                        <span class="fileinput-new">Select image</span>
                                        <span class="fileinput-exists">Change</span><input type="file" name="facePic" accept="image/*">
                                    </span>
                                    <a href="#" class="btn btn-blue btn btn-blue-default fileinput-exists" data-dismiss="fileinput">Remove</a>
                                </div>
                            </div>

                            <div class="form-group btn btn-blue-div col-md-12">

                                <div class="pull-right">
                                    <button  type='button' onclick="swapDiv('prob_profile', 'face_pic', -1);" class="btn btn-blue btn btn-blue-default">Back  <span class="glyphicon glyphicon-arrow-left"></span></button>
                                    <button  type='submit' class="btn btn-blue btn btn-blue-default">Submit</button>

                                </div>
                            </div>


                        </div>
                    </form> 
                </div>

            </div>
        </div>

    </body>
</html>
<script>
            /**       
             * form validation 
             $(document).ready(function() {
             $('#createworker_form')
             .bootstrapValidator({
             fields: {
             facePic: {
             validators: {
             file: {
             extension: 'png,jpeg,jpg,bmp',
             type: 'image/png,image/jpeg,image/jpg,image/bmp',
             maxSize: 1024 * 1024,
             message: 'Please choose an image file with a size less than 1M only.'
             }
             }
             },
             //worker
             
             finNum: {
             validators: {
             stringLength: {
             max: 12,
             message: 'This field must be less than 12 characters.'
             },
             notEmpty: {
             message: 'This field cannot be empty.'
             },
             callback: {
             message: 'Wrong answer',
             callback: function(value, validator, $field) {
             var finType1 = /^[G][0-9]{7}[A-Z]$/;
             var finType2 = /^GEN[0-9]{6}$/;
             var finType1Res = finType1.test(value);
             if (finType1.test(value) === false && finType2.test(value) === false) {
             return {
             valid: false,
             message: 'FIN number is incorrect. Please Check again.'
             };
             }
             return true;
             }
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
             workpassType: {
             validators: {
             notEmpty: {
             message: 'This field cannot be empty.'
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
             problem: {
             validators: {
             notEmpty: {
             message: 'This field cannot be empty.'
             }
             }
             },
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
             **/


<!--added by soemyatmyat for generating TWC2 In-house FinNumber-->

            $('#generateTWC2Fin').click(function() {
                $.ajax({
                    type: "post",
                    url: "generateTWC2Fin.do",
                    success: function(msg)
                    {

                        var elem = document.getElementById("finNum");
                        elem.value = msg;
                        //document.getElementById("fin").value = msg;
                        // $("#fin").html("<input type=\"text\" id=\"finNum\" class=\"form-control\" name=\"finNum\" value="
                        // + msg + "/>").fadeIn("slow");
                        //$("#finButton").html("<button type=\"button\" id=\"inputFin\" class=\"btn btn-blue btn btn-blue-default\">" + 
                        //     "Input Fin</button>");
                        $('#createworker_form').formValidation('revalidateField', 'finNum');
                    }
                });
            });
            //session time out


    $(document).ready(function () {
        $.sessionTimeout({
            message: 'Your session will be expired in five minutes.',
            keepAliveUrl: 'keep-alive.html',
            logoutUrl: 'logout.jsp',
            redirUrl: 'logout.jsp',
            warnAfter: 900000, //15 minutes
            redirAfter: 1200000 // 20 minutes
        });
    });

</script>  