<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.entity.*"%>
<%@page import="camans.dao.*"%>
<script src="js/ajax.js"></script>
<script src="js/core.js"></script>
<script src="js/delegate.js"></script>
<script src="js/jquery.validate.js"></script>
<script src="js/additional-methods.js"></script>



<style>
    input{
        width: 10vh;
    }
    button{
        width : 6vw;
    }
    .btn-danger{
        border-radius: 2%;
    }

    .col-md-12{
        padding:0;
    }
</style>
<%
    /* data collection */
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    User userLogin = (User) request.getSession().getAttribute("userLogin");
    String status = (String) request.getSession().getAttribute("status");
    request.getSession().removeAttribute("status");

    String userRole = userLogin.getRole();
    boolean isAdmin = false;
    if (userRole.equals("Administrator")) {
        isAdmin = true;
    }
    //worker complement passed data
    String workerFin = request.getParameter("workerFin");
    String jobKeyStr = request.getParameter("jobkey");         //passed from viewWorker.jsp
    String probKeyStr = request.getParameter("probkey");
    String profile = request.getParameter("profile");
    String action = request.getParameter("action");
    //end of data collection

    //get worker data
    Worker worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFin);

    java.util.Date regDate = worker.getRegistrationDate();
    String createdBy = worker.getCreatedBy();
    String createdFor = worker.getCreatedFor();
    String workerName = worker.getName();
    String gender = worker.getGender();
    String nationality = worker.getNationality();
    String nationalityMore = worker.getNationalityMore();
    java.util.Date dob = worker.getDateOfBirth();

    //get job data
    int jobKey = Integer.parseInt(jobKeyStr);
    Job job = JobDAO.retrieveJobByJobId(jobKey);

    String empName = job.getEmployerName();
    String wpType = job.getWorkPassType();
    String wpMore = job.getWorkPassMore();
    String jSector = job.getJobSector();
    String jSectorMore = job.getJobSectorMore();
    String occupation = job.getOccupation();
    String startWhen = job.getJobStartDate();
    String endWhen = job.getJobEndDate();
    String isTjs = job.getJobTJS();
    String jRemark = job.getJobRemark();

    //get problem data
    int probKey = Integer.parseInt(probKeyStr);
    Problem problem = ProblemDAO.retrieveProblemByProblemId(probKey);

    java.util.Date pRegDate = problem.getProblemRegisteredDate();
    String problemType = problem.getProblem();
    String pTypeMore = problem.getProblemMore();
    String pRemark = problem.getProblemRemark();

    //get Dropdown data
    ArrayList<String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
    ArrayList<String> problemList = DropdownDAO.retrieveAllDropdownListOfProblems();
    ArrayList<String> passTypeList = DropdownDAO.retrieveAllDropdownListByType("Work_pass_type");
    ArrayList<String> jobSectorList = DropdownDAO.retrieveAllDropdownListOfJobSector();
    ArrayList<String> hospitalList = DropdownDAO.retrieveAllDropdownListOfHosptialType();


    java.util.Date today = new java.util.Date();
    //javascript method to blur the input fields if the action is view
    //if the action is view, 
    /**
     * if the action is view disable the fields if the user chosoe to edit,
     * enable the fields this is similar logic for all 3 categories
     *
     */
    /**
     * if the user click add, it will destroy the view/edit pop up and run a new
     * pop up again which is add pop up if the user click on worker, just
     * display the whole form if the user click on job, disable the fields of
     * worker and get the data previously had if the user click on problem,
     * diable the fields of worker and job and get the prev data.
     *
     */

%>
<script>
    //for not type-able inputs
    $(document).ready(function() {
        $('.dateInput').focus(function() {

            $('.dateInput').blur();

        });

        $('.no_change').focus(function() {
            $('.no_change').blur();

        });


        $(".dateInput").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0,
            yearRange: "-100:nn"
        });

        $('.control-label').addClass("pull-left");
        $('.form-control').addClass('input-sm');

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
                jobSectorMore: {
                    maxlength: 50
                },
                occupation: {
                    maxlength: 50
                },
                jobStartDate: {
                    maxlength: 50
                },
                jobEndDate: {
                    maxlength: 50
                },
                jobRemark: {
                    maxlength: 200
                },
                //problem profile
                problem: {
                    required: true
                },
                problemMore: {
                    maxlength: 50
                },
                problemRemark: {
                    maxlength: 200
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

        /**
         * Edit worker particulars validation
         **/
        //methods for jquery validator
        jQuery.validator.addMethod("FIN", function(value, element) {
            return this.optional(element) || /^[A-Z][0-9]{7}[A-Z]$/.test(value) || /^GEN[0-9]{6}$/.test(value);
        }, "Invalid FIN number format. Please check again.");
        jQuery.validator.addMethod("FileSize", function(value, element) {
            return this.optional(element) || (element.files[0].size <= 1048576);
        }, "Invalid File size. Please Check again.");
        //validation
        $('#finNum').change(function() {

            var rules = $("input[name='finNum']").rules();

            var isAdded = false;
            for (var i in rules) {
                //alert(i);
                //alert(i + ":" + rules[i]);
                if (i === 'remote') {
                    //alert(i + ":" + rules[i]);
                    // alert("remote spotted");
                    isAdded = true;

                }
            }
            if ($('#finNum').val() !== $("#hiddenFin").val()) {
                //alert('hello');

                if (isAdded === false) {
                    //alert('going to add');
                    $('#finNum').rules('add', {
                        remote: {
                            url: "processValidate",
                            type: "POST",
                            data: {
                                finNum: function() {
                                    return $("#finNum").val();
                                }
                            }
                        }
                    });
                    //alert("added");
                    rules = $("input[name='finNum']").rules();
                    for (var i in rules) {
                        //alert(i);
                        //alert("end of validation : " + i + ":" + rules[i]);

                    }
                }


            } else {
                if (isAdded === true) {
                    //alert("going to remove");
                    $('#finNum').rules('remove', 'remote');
                    //alert("removed");
                }
            }


        });

        $('#worker_stub').validate({
            //ignore: ":hidden",
            rules: {
                finNum: {
                    required: true,
                    FIN: true
                },
                wkerName: {
                    maxlength: 50,
                    required: true
                },
                nationalityMore: {
                    maxlength: 50
                },
                createdFor: {
                    maxlength: 20
                }
            },
            messages: {
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

        /**
         * Edit Job particulars validation
         **/
        $('#job_stub')
                .bootstrapValidator({
            fields: {
                wpMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                empName: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        },
                        notEmpty: {
                            message: 'This field cannot be empty.'
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
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                jobStartDate: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                jobEndDate: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                jobRemark: {
                    validators: {
                        stringLength: {
                            max: 200,
                            message: 'This field must be less than 200 characters.'
                        }
                    }
                }
            }
        });

        /**
         * Edit Problem particulars validation
         **/
        $('#problem_stub')
                .bootstrapValidator({
            fields: {
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

        //display
        var action_val = "<%=action%>";
        if (action_val === 'add') {
            //alert(action_val);
            var profile_val = "<%=profile%>";
            if (profile_val === 'problem') {
                //start from problem
                $('#job_profile').prop('disabled', true);
                $('#job_profile').hide();
                $('#prob_profile').show();
                $("#hiddenWorkerFin").after('<input type="hidden" id="hiddenJobKey" name="jobKey" value="<%=jobKey%>"/>');
            }
        }
        $('.cancel_btn').click(function() {
            $('#pop_up_content').dialog("destroy");
            //$(this).dialog("destroy");
            $('#pop_up_content').empty();
        });

        /**
         * Add Job & Problem particulars validation
         **/
        $("#job_next_btn").click(function() {
            $('#addCase').valid();
        });

    });




    function swapDiv(div_id, curr_id, num) {
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

            //$('.next_btn').prop('disabled',false);
        } else {
            //$('.next_btn').prop('disabled',true);
            var missing_inputStr = "";
            if (missing_input_field === "finNum") {
                missing_inputStr = "FIN Number is required.";
            } else if (missing_input_field === "workerName") {
                missing_inputStr = "Worker Name is required.";
            } else if (missing_input_field === 'employerName') {
                missing_inputStr = "Employer Name is required.";
            }
            //$(".alert-danger").text(missing_inputStr);
        }
    }
    ;

    function edit(stub_name, title) {
        var fieldset_div = document.getElementsByTagName('fieldset');
        $(fieldset_div).prop('disabled', false);
        $("span.ui-dialog-title").text('Edit ' + title);
        $(".edit_btn").toggle();
        $(".save_btn").show();
        $('.delete_btn').hide();
        //$(".add_btn").toggle();
        if (<%= isAdmin%> == true) {
            $('#finNum').removeClass('no_change');
        }
    }
    ;


</script>

<%
    if (action.equals("view") && profile.equals("worker")) {
%>

<form method="POST" action="editStubs.do" id='worker_stub' class="form complement_detailed_form "  >
    <br/>
    <fieldset disabled>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Worker Registration Date: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control dateInput" type='text' name="date" value="<%=sdf.format(regDate)%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label ">Created By: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control no_change" type='text' name="createdBy" value="<%=createdBy%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Created For: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="createdFor" value="<%=createdFor%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Worker's Name: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="wkerName" value="<%=workerName%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label ">FIN Number: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control no_change" id="finNum" type='text' name="finNum" value="<%=workerFin%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for="worker_gender" class="control-label">Gender:</label>
            </div>
            <div class='col-md-7'>
                <select class="form-control" name="gender">
                    <%
                        if (gender.equalsIgnoreCase("male")) {
                    %>
                    <option selected>Male</option>
                    <option>Female</option>
                    <%                } else {
                    %>
                    <option>Male</option>
                    <option selected>Female</option>
                    <%                    }
                    %>
                </select>
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for="worker_nationality" class="control-label">Nationality</label>
            </div>
            <div class='col-md-7'>
                <select class="form-control" id="worker_nationality" name="nationality">
                    <%
                        for (String nationalityStr : nationalityList) {
                            if (nationality.equals(nationalityStr)) {
                    %>
                    <option selected><%=nationalityStr%></option>
                    <%
                    } else {
                    %>
                    <option><%=nationalityStr%></option>
                    <%
                            }
                        }
                    %>                                               
                </select>
            </div>
            <br/>
        </div><br/>
        <div class="form-group col-sm-12 col-md-12">
            <div class='col-md-5'>
                <label for="worker_nationality_other_In" class="control-label">Explain if above is other</label>
            </div>
            <div class='col-md-7'>
                <textarea class="form-control" name="nationalityMore" rows="3"><%=(nationalityMore == null) ? "" : nationalityMore%></textarea>
            </div>
            <br/>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Date of Birth: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control dateInput" type='text' name="dob" value="<%=(dob == null) ? "" : sdf.format(dob)%>">
            </div>
            <br/>
            <br/>
        </div><br/>
    </fieldset>

    <input type="hidden" id="stub_name" name="stub" value="worker"/>
    <input type='hidden' name='hiddenFin' id="hiddenFin" value='<%=workerFin%>'/>
    <div class="form-group pull-right">
        <button type='button' onclick="edit('worker_stub', 'Worker Stub');" class="btn btn-blue modal_btn edit_btn">Edit</button>
        <button style="display:none" type='submit' class="btn btn-blue modal_btn save_btn">Save</button>
        <%
            if (userRole.equals("Administrator")) {
        %>
        <button type='button' onclick="deleteStub('worker');" class="btn btn-danger modal_btn delete_btn">Delete</button>
        <%        }
        %>
        <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
    </div>
</form>

<%
} else if (action.equals("view") && profile.equals("job")) {
%>
<form method="POST" id='job_stub' action="editStubs.do" class="form complement_detailed_form "  >
    <br/>
    <fieldset disabled>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Employer Name: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="empName" value="<%=empName%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for="worker_nationality" class="control-label">WorkpassType</label>
            </div>
            <div class='col-md-7'>
                <select class="form-control" id="workpass" name="wpType" onchange="displayOther(this.id);">
                    <%
                        for (String passTypeStr : passTypeList) {
                            if (wpType.equals(passTypeStr)) {
                    %>
                    <option selected><%=passTypeStr%></option>
                    <%
                    } else {
                    %>
                    <option><%=passTypeStr%></option>
                    <%
                            }
                        }
                    %>                                               
                </select>
            </div>
            <br/>
        </div><br/>
        <div class="form-group  col-sm-12 col-md-12">
            <div class='col-md-5'>
                <label for="worker_nationality_other_In" class="control-label">Explain if above is other</label>
            </div>
            <div class='col-md-7'>
                <textarea class="form-control" name="wpMore" rows="3"><%=(wpMore == null) ? "" : wpMore%></textarea>
            </div>
            <br/>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for="worker_nationality" class="control-label">Job Sector</label>
            </div>
            <div class='col-md-7'>
                <select class="form-control" id="jSector" name="jobSector" onchange="displayOther(this.id);">
                    <%
                        for (String jobSectorStr : jobSectorList) {
                            if (jSector.equals(jobSectorStr)) {
                    %>
                    <option selected><%=jobSectorStr%></option>
                    <%
                    } else {
                    %>
                    <option><%=jobSectorStr%></option>
                    <%
                            }
                        }
                    %>                                               
                </select>
            </div>
            <br/>
        </div><br/>
        <div class="form-group col-sm-12 col-md-12">
            <div class='col-md-5'>
                <label for="jSecotr_other_In" class="control-label">Explain if above is other</label>
            </div>
            <div class='col-md-7'>
                <textarea class="form-control" name="jobSectorMore" rows="3"><%=(jSectorMore == null) ? "" : jSectorMore%></textarea>
            </div>
            <br/>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Occupation: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="occupation" value="<%=occupation%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Job Start Date: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="jobStartDate" value="<%=startWhen%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Job End Date: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="jobEndDate" value="<%=endWhen%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Is This a TJS job?: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="isTjs" value="<%=isTjs%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Remark about this Job: </label>
            </div>
            <div class='col-md-7'>
                <textarea class="form-control" name="jobRemark" rows="3" ><%=jRemark%></textarea>
            </div>
            <br/>
        </div><br/>
    </fieldset>
    <p class="alert-danger"></p>
    <input type="hidden" id="stub_name" name="stub" value="job"/>
    <input type="hidden" id="job_name" name="finNum" value="<%=workerFin%>"/>
    <input type="hidden" id="job_name" name="jobKey" value="<%=jobKey%>"/>
    <div class="form-group pull-right">
        <button type='button' onclick="edit('job_stub', 'Job Stub');" class="btn btn-blue modal_btn edit_btn">Edit</button>
        <button style="display:none" type='submit' class="btn btn-blue modal_btn save_btn">Save</button>
        <%
            if (userRole.equals("Administrator")) {
        %>
        <button type='button' onclick="deleteStub('job');" class="btn btn-danger modal_btn delete_btn">Delete</button>
        <%        }
        %>
        <button type='button' class='btn edit_comp cancel_btn'>Cancel</button>
        <button style="display:none" type='button' class="btn btn-blue modal_btn add_btn" onclick="add('job');">Add</button>
    </div>
</form>

<%
} else if (action.equals("view") && profile.equals("problem")) {
%>
<form method="POST" action="editStubs.do" id='problem_stub' class="form complement_detailed_form "  >
    <br/>
    <fieldset disabled>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Problem Registration Date: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control dateInput" type='text' name="problemRegDate" value="<%=sdf.format(pRegDate)%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for="worker_nationality" class="control-label">Problem:</label>
            </div>
            <div class='col-md-7'>
                <select class="form-control" id="workpass" name="problem" onchange="displayOther(this.id);">
                    <%
                        for (String problemStr : problemList) {
                            if (problemType.equals(problemStr)) {
                    %>
                    <option selected><%=problemStr%></option>
                    <%
                    } else {
                    %>
                    <option><%=problemStr%></option>
                    <%
                            }
                        }
                    %>                                               
                </select>
            </div>
            <br/>
        </div><br/>
        <div class="form-group col-sm-12 col-md-12">
            <div class='col-md-5'>
                <label for="worker_nationality_other_In" class="control-label">Explain if above is other</label>
            </div>
            <div class='col-md-7'>
                <textarea class="form-control" name="problemMore" rows="3"><%=(pTypeMore == null) ? "" : pTypeMore%></textarea>
            </div>
            <br/>
            <br/>
        </div><br/>
        <div class='form-group col-sm-12 col-md-12'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Remark about this Problem: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="problemRemark" value="<%=pRemark%>">
            </div>
            <br/>
        </div><br/>
    </fieldset>
    <p class="alert-danger"></p>
    <input type="hidden" id="stub_name" name="stub" value="problem"/>
    <input type="hidden" id="job_name" name="finNum" value="<%=workerFin%>"/>
    <input type="hidden" id="job_name" name="jobKey" value="<%=jobKey%>"/>
    <input type="hidden" id="job_name" name="probKey" value="<%=probKey%>"/>
    <div class="form-group pull-right">
        <button type='button' onclick="edit('problem_stub', 'problem Stub');" class="btn btn-blue modal_btn edit_btn">Edit</button>
        <button style="display:none" type='submit' class="btn btn-blue modal_btn save_btn">Save</button>
        <%
            if (userRole.equals("Administrator")) {
        %>
        <button type='button' onclick="deleteStub('problem');" class="btn btn-danger modal_btn delete_btn">Delete</button>
        <%        }
        %>
        <button type='button' class='btn modal_btn edit_comp cancel_btn'>Cancel</button>
        <button style="display:none"  type='button' class="btn btn-blue modal_btn add_btn" onclick="add('problem');">Add</button>
    </div>
</form>

<%
} else if (action.equals("add") && profile.equals("job")) {
%>

<form method="POST" id='addCase' class="form complement_detailed_form " action="createNewCase.do" style="font-size:small">

    <%
        java.util.Date date = new java.util.Date();


    %>

    <!--Job Profile-->
    <div class="sub_div" id="new_job_profile">
        <br/>
        <div class="form-group col-sm-12 col-md-12">
            <label for="emp_name" class="col-md-5 control-label" >Name of Employer <span class="required_input">*</span> </label>
            <div class=" col-md-7">
                <input type="text" class="form-control required" name="employerName"/></div><br/><br/>
        </div>


        <div class="form-group col-sm-12 col-md-12">
            <label for="job_pass_type" class="col-md-5 control-label">Work pass type that comes with the job<span class="required_input">*</span></label>
            <div class=" col-md-7">
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


        <!--this to appear only if above is selected as other-->
        <div class="form-group col-sm-12 col-md-12" id="job_pass_type_other_div" >
            <label for="job_pass_type_other_In" class="col-md-5 control-label">Explain if above is 'Other'</label>
            <div class=" col-md-7">
                <textarea class="form-control" name="workpassMore" rows="3"></textarea>
            </div><br/><br/></div>


        <div class="form-group col-sm-12 col-md-12">
            <label for="job_sector" class="col-md-5 control-label">Job Sector</label>
            <div class=" col-md-7">
                <select class="form-control" name="jobSector" id="job_sector" >
                    <option value=''>Select from list..</option>
                    <%
                        for (String jobSectorStr : jobSectorList) {
                    %>
                    <option value='<%=jobSectorStr%>'><%=jobSectorStr%></option>
                    <%
                        }
                    %>   
                </select>
            </div><br/><br/>
        </div>


        <!--this to appear only if above is selected as other-->
        <div class="form-group col-sm-12 col-md-12" id="job_sector_other_div" >
            <label for="job_sector_other_In" class="col-md-5 control-label">Explain if above is 'other'</label>
            <div class=" col-md-7">
                <textarea class="form-control" name="jobSectorMore" rows="3"></textarea></div><br/><br/>
        </div>


        <div class="form-group col-sm-12 col-md-12">
            <label for="occupation" class="col-md-5 control-label" >Occupation</label>
            <div class=" col-md-7">
                <input type="text" class="form-control" name="occupation"/></div><br/><br/>
        </div>


        <div class="form-group col-sm-12 col-md-12">
            <label for="job_start_date" class="col-md-5 control-label" >Start Date</label>
            <div class=" col-md-7">
                <input type="text" class="form-control" name="jobStartDate"/></div><br/><br/>
        </div>

        <div class="form-group col-sm-12 col-md-12">
            <label for="job_end_date" class="col-md-5 control-label">End Date</label>
            <div class=" col-md-7">
                <input type="text"  class="form-control" name="jobEndDate"/></div><br/><br/>
        </div>


        <div class="form-group col-sm-12 col-md-12">
            <label for="is_tjs" class="col-md-5 control-label">Is this a TJS job?</label>
            <div class=" col-md-7">
                <select name="tjs" class="form-control">
                    <option>No</option>
                    <option>Yes</option>
                </select>
            </div><br/><br/>
        </div>


        <div class="form-group col-sm-12 col-md-12" id="job_sector_other_div">
            <label for="job_remark" class="col-md-5 control-label">Remark</label>
            <div class=" col-md-7">
                <textarea class='form-control' name='jobRemark' rows='3'></textarea> 
            </div><br/><br/>
        </div>

        <p class="alert-danger"></p>
        <br/><br/>
        <div>
            <button type='button' class="btn cancel_btn pull-left" style="top: 2%; bottom: 2%;">Cancel</button>
            <div class="pull-right">
                <button type='button' onclick="swapDiv('new_prob_profile', 'new_job_profile', 1);" class="btn btn-blue btn btn-blue-default " id="job_next_btn" style="top: 2%; bottom: 2%;">Next  <span class="glyphicon glyphicon-arrow-right"></span></button>
            </div>
        </div>
        <br/><br/>

    </div>

    <!--problem profile-->
    <div class="sub_div" id="new_prob_profile" style="display : none">
        <br/>
        <div class="form-group col-sm-12 col-md-12">
            <label for="worker_pass_type_other_In" class="col-md-5 control-label">Problem Registration Date<span class="required_input">*</span>:</label>
            <div class=" col-md-7">
                <input class="form-control dateInput" type='text' name="problemRegDate" value="<%=sdf.format(today)%>" autofocus/></div><br/><br/>
        </div>
        <div class="form-group col-sm-12 col-md-12">
            <label for="prob_type" class="col-md-5 control-label">Problem Type<span class="required_input">*</span></label>
            <div class=" col-md-7"> 
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
            </div><br/><br/>
        </div>


        <!--this to appear only if above is selected as other-->
        <div class="form-group col-sm-12 col-md-12" id="prob_type_other_div" >
            <label for="worker_pass_type_other_In" class="col-md-5 control-label">Explain if above is other</label>
            <div class=" col-md-7">
                <textarea class="form-control" name="problemMore" rows="3"></textarea>
            </div><br/><br/>
        </div>


        <div class="form-group col-sm-12 col-md-12" id="job_sector_other_div" >
            <label for="prob_remark" class="col-md-5 control-label">Remark</label>
            <div class=" col-md-7">
                <textarea class='form-control' name='problemRemark' rows="3"></textarea>
            </div>
            <br/><br/>

        </div>

        <input type="hidden" id="hiddenWorkerFin" name="workerFinNum" value="<%=workerFin%>"/>
        <br/><br/>
        <div>
            <button type='' class="btn cancel_btn" style="bottom: 0">Cancel</button>
            <div class="pull-right">
                <button  type='button' onclick="swapDiv('new_job_profile', 'new_prob_profile', -1);" class="btn btn-blue ">Back  <span class="glyphicon glyphicon-arrow-left"></span></button>
                <button  type='submit' class="btn btn-blue">Submit</button>
            </div>
        </div>
    </div>
</form> 
<%} else if (action.equals("add") && profile.equals("problem")) {
%>
<form method="POST" id='addCase' class="form create_case_form " action="createNewCase.do" style="font-size:small">

    <%
        java.util.Date date = new java.util.Date();


    %>

    <!--problem profile-->
    <div class="sub_div" id="new_prob_profile">
        <br/>
        <div class="form-group col-sm-12 col-md-12">
            <label for="worker_pass_type_other_In" class="col-md-5 control-label">Problem Registration Date<span class="required_input">*</span>:</label>
            <div class=" col-md-7">
                <input class="form-control dateInput" type='text' name="problemRegDate" value="<%=sdf.format(today)%>"/></div><br/><br/>
        </div>
        <div class="form-group col-sm-12 col-md-12">
            <label for="prob_type" class="col-md-5 control-label">Problem Type<span class="required_input">*</span></label>
            <div class=" col-md-7"> 
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
            </div><br/><br/>
        </div>


        <!--this to appear only if above is selected as other-->
        <div class="form-group col-sm-12 col-md-12" id="prob_type_other_div" >
            <label for="worker_pass_type_other_In" class="col-md-5 control-label">Explain if above is other</label>
            <div class=" col-md-7">
                <textarea class="form-control" name="problemMore" rows="3"></textarea></div><br/><br/>
        </div>


        <div class="form-group col-sm-12 col-md-12" id="job_sector_other_div" >
            <label for="prob_remark" class="col-md-5 control-label">Remark</label>
            <div class=" col-md-7">
                <textarea class='form-control' name='problemRemark' rows="3"></textarea></div><br/><br/>
        </div>

        <input type="hidden" id="hiddenWorkerFin" name="workerFinNum" value="<%=workerFin%>"/>
        <br/><br/>
        <div class="form-group col-sm-12 col-md-12">
            <button type='button' class="btn cancel_btn" style="bottom: 0">Cancel</button>
            <div class="pull-right">
                <button  type='submit' class="btn btn-blue">Submit</button>
            </div>
        </div>
    </div>
</form> 

<%
    }%>

<div id="delete-stub-dialog" title="Confirmation" hidden>

    <br/>
    <p>Are you sure you want to delete this item?</p>
    <br/>
    <form method="POST" action="deleteStub.do" id='delete_pop_up' class="delete_confirmation_form"  >
        <input type="hidden" id="hidden-stub" name="stub"/>
        <input type="hidden" name="workerFinNum" value="<%=workerFin%>" />
        <input type="hidden" name="jobKey" value="<%=jobKey%>" />
        <input type="hidden" name="probKey" value="<%=probKey%>" />
        <div class="form-group pull-right">
            <button type='submit' class="btn btn-blue">Okay</button>
            <button type='button' class='btn confirm_cancel_btn'>Cancel</button>
        </div>
    </form> 

</div>

<script>
/////Change to Add pop up/////
    function add(stub) {
        $('#pop_up_content').empty();
        $("#pop_up_content").load('include/createcaseForm.jsp?workerFin=<%=workerFin%>&jobkey=<%=jobKey%>&probkey=<%=probKey%>&profile=' + stub + '&action=add').dialog({
            modal: true,
            position: ['center', 80],
            minWidth: $(window).width() - 750,
            title: div_title,
            resizable: false,
            draggable: false, close: function() {
                $(this).dialog('destroy');
                $('#pop_up_content').empty();
            }
        });

    }

    $('.confirm_cancel_btn').click(function() {
        $('#delete-stub-dialog').dialog('destroy');
    });

    function deleteStub(stub) {
        $("#hidden-stub").val(stub);
        $('#delete-stub-dialog').dialog({
            position: ['center', 150],
            resizable: false,
            draggable: false,
            close: function() {
                $(this).dialog('destroy');
            }
        });
    }



</script>
