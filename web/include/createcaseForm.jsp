<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.entity.*"%>
<%@page import="camans.dao.*"%>

<script>
    function edit(stub_name, title) {
        var fieldset_div = document.getElementsByTagName('fieldset');
        $(fieldset_div).prop('disabled', false);
        $("span.ui-dialog-title").text('Edit ' + title);
        $(".edit_btn").toggle();
        $(".save_btn").show();
        //$(".add_btn").toggle();
    }
    ;

    $(function() {
        $(".dateInput").datepicker({
            dateFormat: 'dd-M-yy',
            changeMonth: true,
            changeYear: true,
            maxDate: 0
        });

    });

    //for date inputs
    $(document).ready(function() {

        $('.dateInput').focus(function() {

            $('.dateInput').blur();

        });

    });
    
    //for date inputs
    $(document).ready(function() {

        $('.no_change').focus(function() {

            $('.no_change').blur();

        });

    });

    $('.cancel_btn').click(function() {
        $('#pop_up_content').dialog("destroy");
        $('#pop_up_content').empty();
    });

    $(document).ready(function() {
        $('#addCase')
                .bootstrapValidator({
            fields: {
                //worker
                createdFor: {
                    validators: {
                        stringLength: {
                            max: 20,
                            message: 'This field must be less than 20 characters.'
                        }
                    }
                },
                workerName: {
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
                //job Profile
                passCurrent: {
                    validators: {
                        notEmpty: {
                            message: 'This field cannot be empty.'
                        }
                    }
                },
                passMore: {
                    validators: {
                        stringLength: {
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                employerName: {
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
                            max: 50,
                            message: 'This field must be less than 50 characters.'
                        }
                    }
                },
                /**what are the validating criteria for these???
                 ** 
                 passNumber
                 passIssueDate
                 workpassType
                 workpassTypeMore
                 **
                 **/

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

    function swapDiv(div_id, curr_id, num) {
                var curr_div_id = "#" + curr_id;
                var val = 0;
                if(num === 1){
                $('.required',curr_div_id).each(function() {
                    if (this.value.trim() === '') {
                        //alert(this);
                        val = 1;
                    }
                });
                }
                if (val === 0) {
                    $('.sub_div').hide();
                    document.getElementById(div_id).style.display = 'block';
                    
                } else {
                    alert("Some fields are missing. Please enter all the required fields.");
                }
            };
            
</script>

<style>
    input{
        width: 10vh;
    }
</style>
<%
    /* data collection */
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    User userLogin = (User) request.getSession().getAttribute("userLogin");
    String status = (String) request.getSession().getAttribute("status");
    request.getSession().removeAttribute("status");
    
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
    HashMap<Integer, String> nationalityList = DropdownDAO.retrieveAllDropdownListOfNationalities();
    HashMap<Integer, String> problemList = DropdownDAO.retrieveAllDropdownListOfProblems();
    HashMap<Integer, String> passTypeList = DropdownDAO.retrieveAllDropdownListOfPassType();
    HashMap<Integer, String> jobSectorList = DropdownDAO.retrieveAllDropdownListOfJobSector();
    HashMap<Integer, String> hospitalList = DropdownDAO.retrieveAllDropdownListOfHosptialType();
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
        $(document).ready(function(){
            var action_val = "<%=action%>";
    if(action_val === 'add'){
        //alert(action_val);
        var profile_val = "<%=profile%>";
        if(profile_val === 'problem'){
                //start from problem
                $('#job_profile').prop('disabled', true);
                $('#job_profile').hide();
                $('#prob_profile').show();
                $("#hiddenWorkerFin").after('<input type="hidden" id="hiddenJobKey" name="jobKey" value="<%=jobKey%>"/>');
        }
    }
});

//display others
    function displayOther(div_id) {
                var div = document.getElementById(div_id);
                if (document.getElementById(div_id).value === 'Other') {
                    var other_div = div_id + "_other_div";
                    document.getElementById(other_div).style.display = 'block';
                }
            }
        
    </script>

<%
    if (action.equals("view") && profile.equals("worker")) {
%>

<form method="POST" action="editStubs.do" id='worker_stub' class="form complement_detailed_form "  >
    <br/>
    <fieldset disabled>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Worker Registration Date: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control dateInput" type='text' name="date" value="<%=sdf.format(regDate)%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label ">Created By: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control no_change" type='text' name="createdBy" value="<%=createdBy%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Created For: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="createdFor" value="<%=createdFor%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Worker's Name: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="wkerName" value="<%=workerName%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label ">FIN Number: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control no_change" type='text' name="workerFin" value="<%=workerFin%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
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
        <div class='form-group'>
            <div class='col-md-5'>
                <label for="worker_nationality" class="control-label">Nationality</label>
            </div>
            <div class='col-md-7'>
                <select class="form-control" id="worker_nationality" name="nationality" onchange="displayOther(this.id);">
                    <%
                        for (String nationalityStr : nationalityList.values()) {
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
        <div class="form-group" id="worker_nationality_other_div" >
            <div class='col-md-5'>
                <label for="worker_nationality_other_In" class="control-label">Explain if above is other</label>
            </div>
            <div class='col-md-7'>
                <input type="text" class="form-control" name="nationalityMore" value="<%=nationalityMore%>">
            </div>
            <br/>
            <br/>
        </div>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Date of Birth: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control dateInput" type='text' name="dob" value="<%=dob%>">
            </div>
            <br/>
            <br/>
        </div><br/>
    </fieldset>
            <input type="hidden" id="stub_name" name="stub" value="worker"/>
    <button type='button' onclick="edit('worker_stub', 'Worker Stub');" class="btn modal_btn edit_btn">Edit</button>
    <button style="display:none" type='submit' class="btn modal_btn save_btn">Save</button>
    <button type='button' class='btn modal_btn edit_comp cancel_btn pull-right'>Cancel</button>
</form>

<%
} else if (action.equals("view") && profile.equals("job")) {
%>
<form method="POST" id='job_stub' action="editStubs.do" class="form complement_detailed_form "  >
    <br/>
    <fieldset disabled>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Employer Name: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="empName" value="<%=empName%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for="worker_nationality" class="control-label">WorkpassType</label>
            </div>
            <div class='col-md-7'>
                <select class="form-control" id="workpass" name="wpType" onchange="displayOther(this.id);">
                    <%
                        for (String passTypeStr : passTypeList.values()) {
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
        <div class="form-group" id="workpass_other_div" >
            <div class='col-md-5'>
                <label for="worker_nationality_other_In" class="control-label">Explain if above is other</label>
            </div>
            <div class='col-md-7'>
                <input type="text" class="form-control" name="wpMore" value="<%=wpMore%>">
            </div>
            <br/>
            <br/>
        </div>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for="worker_nationality" class="control-label">Job Sector</label>
            </div>
            <div class='col-md-7'>
                <select class="form-control" id="jSector" name="jobSector" onchange="displayOther(this.id);">
                    <%
                        for (String jobSectorStr : jobSectorList.values()) {
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
        <div class="form-group" id="jSector_other_div" >
            <div class='col-md-5'>
                <label for="jSecotr_other_In" class="control-label">Explain if above is other</label>
            </div>
            <div class='col-md-7'>
                <input type="text" class="form-control" name="jobSecotrMore" value="<%=wpMore%>">
            </div>
            <br/>
            <br/>
        </div>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Occupation: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="occupation" value="<%=occupation%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Job Start Date: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="jobStartDate" value="<%=startWhen%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Job End Date: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="jobEndDate" value="<%=endWhen%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Is This a TJS job?: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="isTjs" value="<%=isTjs%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Remark about this Job: </label>
            </div>
            <div class='col-md-7'>
                <textarea class="form-control" name="jobRemark" rows="3" maxlength="200" ></textarea>
            </div>
            <br/>
        </div><br/>
    </fieldset>
            <input type="hidden" id="stub_name" name="stub" value="job"/>
            <input type="hidden" id="job_name" name="workerFin" value="<%=workerFin%>"/>
            <input type="hidden" id="job_name" name="jobKey" value="<%=jobKey%>"/>
    <button type='button' onclick="edit('job_stub', 'Job Stub');" class="btn modal_btn edit_btn">Edit</button>
    <button style="display:none" type='submit' class="btn modal_btn save_btn">Save</button>
    <button type='button' class='btn modal_btn edit_comp cancel_btn pull-right'>Cancel</button>
    <button style="display:none" type='button' class="btn modal_btn add_btn pull-right" onclick="add('job')">Add</button>
</form>

<%
} else if (action.equals("view") && profile.equals("problem")) {
%>
<form method="POST" action="editStubs.do" id='problem_stub' class="form complement_detailed_form "  >
    <br/>
    <fieldset disabled>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Problem Registration Date: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control dateInput" type='text' name="pRegDate" value="<%=sdf.format(pRegDate)%>">
            </div>
            <br/>
        </div><br/>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for="worker_nationality" class="control-label">Problem:</label>
            </div>
            <div class='col-md-7'>
                <select class="form-control" id="workpass" name="problem" onchange="displayOther(this.id);">
                    <%
                        for (String problemStr : problemList.values()) {
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
        <div class="form-group" id="workpass_other_div" >
            <div class='col-md-5'>
                <label for="worker_nationality_other_In" class="control-label">Explain if above is other</label>
            </div>
            <div class='col-md-7'>
                <input type="text" class="form-control" name="problemMore" value="<%=pTypeMore%>">
            </div>
            <br/>
            <br/>
        </div>
        <div class='form-group'>
            <div class='col-md-5'>
                <label for='isdate' class="control-label">Remark about this Problem: </label>
            </div>
            <div class='col-md-7'>
                <input class="form-control" type='text' name="problemRemark" value="<%=pRemark%>">
            </div>
            <br/>
        </div><br/>
    </fieldset>
            <input type="hidden" id="stub_name" name="stub" value="problem"/>
            <input type="hidden" id="job_name" name="workerFin" value="<%=workerFin%>"/>
            <input type="hidden" id="job_name" name="jobKey" value="<%=jobKey%>"/>
            <input type="hidden" id="job_name" name="probKey" value="<%=probKey%>"/>
    <button type='button' onclick="edit('problem_stub', 'problem Stub');" class="btn modal_btn edit_btn">Edit</button>
    <button style="display:none" type='submit' class="btn modal_btn save_btn">Save</button>
    <button type='button' class='btn modal_btn edit_comp cancel_btn pull-right'>Cancel</button>
    <button style="display:none"  type='button' class="btn modal_btn add_btn pull-right" onclick="add('problem')">Add</button>
</form>

<%
} else if (action.equals("add")) {
%>

<form method="POST" id='addCase' class="form complement_detailed_form " action="createNewCase.do" style="font-size:small">

    <%
            java.util.Date date = new java.util.Date();
            

    %>
    
    <!--Job Profile-->
    <div class="sub_div" id="job_profile" style="position: relative">
        <h3>Case Creation Form - Job Profile</h3><br/>

        <div class="form-group">
            <label for="emp_name" class="col-md-5 control-label" >Name of Employer <span class="required_input">*</span> </label>
            <div class=" col-md-7">
                <input type="text" class="form-control required" name="employerName" required/></div><br/><br/>
        </div>


        <div class="form-group">
            <label for="job_pass_type" class="col-md-5 control-label">Work pass type that comes with the job<span class="required_input">*</span></label>
            <div class=" col-md-7">
                <select name="workpassType" class="form-control" id="job_pass_type" onchange="displayOther(this.id)" required>
                    <%
                        for (String passTypeStr : passTypeList.values()) {
                    %>
                    <option><%=passTypeStr%></option>
                    <%
                        }
                    %>   
                </select>
            </div><br/><br/>
        </div>


        <!--this to appear only if above is selected as other-->
        <div class="form-group" id="job_pass_type_other_div" >
            <label for="job_pass_type_other_In" class="col-md-5 control-label">Explain if above is 'Other'</label>
            <div class=" col-md-7">
                <input type="text" class="form-control" name="workpassMore"/></div><br/><br/>
        </div>


        <div class="form-group">
            <label for="job_sector" class="col-md-5 control-label">Job Sector</label>
            <div class=" col-md-7">
                <select class="form-control" name="jobSector" id="job_sector" onchange="displayOther(this.id)" required>
                    <%
                        for (String jobSectorStr : jobSectorList.values()) {
                    %>
                    <option><%=jobSectorStr%></option>
                    <%
                        }
                    %>   
                </select>
            </div><br/><br/>
        </div>


        <!--this to appear only if above is selected as other-->
        <div class="form-group" id="job_sector_other_div" >
            <label for="job_sector_other_In" class="col-md-5 control-label">Explain if above is other</label>
            <div class=" col-md-7">
                <input type="text" class="form-control" name="jobSectorMore" /></div><br/><br/>
        </div>


        <div class="form-group">
            <label for="occupation" class="col-md-5 control-label" >Occupation</label>
            <div class=" col-md-7">
                <input type="text" class="form-control" name="occupation" /></div><br/><br/>
        </div>


        <div class="form-group">
            <label for="job_start_date" class="col-md-3 control-label" >Start Date</label>
            <div class=" col-md-3">
                <input type="text" class="form-control" name="jobStartDate" /></div>
            </div>

        <div class="form-group">
            <label for="job_end_date" class="col-md-3 control-label">End Date </label>
            <div class=" col-md-3">
                <input type="text"  class="form-control" name="jobEndDate" /></div><br/><br/>
        </div>


        <div class="form-group">
            <label for="is_tjs" class="col-md-5 control-label">Is this a TJS job?</label>
            <div class=" col-md-7">
                <select name="tjs" class="form-control">
                    <option>No</option>
                    <option>Yes</option>
                </select>
            </div><br/><br/>
        </div>


        <div class="form-group" id="job_sector_other_div">
            <label for="job_remark" class="col-md-5 control-label">Remark</label>
            <div class=" col-md-7">
                <input type="text" class="form-control" name="jobRemark" /> 
            </div><br/><br/>
        </div>


        <div class="form-group btn-div col-md-12" style='position: relative'>
            <span class="required_input">* Required field</span>
            <div class="pull-right">
                <button type='button' onclick="swapDiv('worker_profile', 'job_profile', -1);" class="btn btn-default" style="bottom: 0">Back  <span class="glyphicon glyphicon-arrow-left"></span></button>
                <button type='button' onclick="swapDiv('prob_profile', 'job_profile', 1);" class="btn btn-default " style="bottom: 0">Next  <span class="glyphicon glyphicon-arrow-right"></span></button>
            </div><br/><br/>
        </div>

    </div>

    <!--problem profile-->
    <div class="sub_div" id="prob_profile" style="display : none">
        <br/>
        <h3 id="title">Case Creation Form - Problem Profile</h3> 
        <br/>

        <div class="form-group">
            <label for="worker_pass_type_other_In" class="col-md-5 control-label">Problem Registration Date<span class="required_input">*</span>:</label>
            <div class=" col-md-7">
                <input class="form-control dateInput" type='text' name="registeredDate" value="<%=sdf.format(pRegDate)%>" /></div><br/><br/>
        </div>
        <div class="form-group">
            <label for="prob_type" class="col-md-5 control-label">Problem Type<span class="required_input">*</span></label>
            <div class=" col-md-7"> 
                <select name="problem" id="prob_type" class="form-control" onchange="displayOther(this.id);" required>
                    <%
                        for (String problemStr : problemList.values()) {
                    %>
                    <option><%=problemStr%></option>
                    <%
                        }
                    %>                   
                </select>
            </div><br/><br/>
        </div>


        <!--this to appear only if above is selected as other-->
        <div class="form-group" id="prob_type_other_div" >
            <label for="worker_pass_type_other_In" class="col-md-5 control-label">Explain if above is other</label>
            <div class=" col-md-7">
                <input type="text" class="form-control" name="problemMore" /></div><br/><br/>
        </div>


        <div class="form-group" id="job_sector_other_div" >
            <label for="prob_remark" class="col-md-5 control-label">Remark</label>
            <div class=" col-md-7">
                <input type="text" class="form-control" name="problemRemark" /></div><br/><br/>
        </div>


        <div id="injury_div" style="display : none">
            <div class="form-group">
                <label for="injury_date" class="col-md-5 control-label" >Injury Date</label>
                <div class=" col-md-7">
                    <input type="text" class="dateInput" class="form-control" name="injuryDate"/></div><br/><br/>
            </div>
            <div class="form-group">
                <label for="injury_body_part" class="col-md-5 control-label" >Injury Body Part</label>
                <div class=" col-md-7">
                    <input type="text" class="form-control" name="injuryBodyPart"/></div><br/><br/>
            </div>

            <div class="form-group">
                <label for="prob_hospital" class="col-md-5 control-label">Current Hospital</label>
                <div class=" col-md-7">
                    <select class="form-control" name="currentHosptial" id="prob_hospital" onchange="displayOther(this.id)" >
                        <%
                            for (String hospitalStr : hospitalList.values()) {
                        %>
                        <option><%=hospitalStr%></option>
                        <%
                            }
                        %> 
                    </select>
                </div><br/><br/>
            </div>
                    
            

            <div class="form-group" id="prob_hospital_other_div" >
                <label for="prob_hospital_other_In" class="col-md-5 control-label">Explain if above is other</label>
                <div class=" col-md-7">
                    <input type="text" class="form-control" name="hospitalMore" /></div>
            </div><br/><br/>
        </div>


        <div class="form-group">
            <label for="has_lawyer" class="col-md-5 control-label">Does worker have lawyer for this problem?</label>
            <div class=" col-md-7">
                <select class="form-control" name="lawyerHas">
                    <option>No</option>
                    <option>Yes</option>
                </select>
            </div><br/><br/>
        </div>

    
        <div class="form-group"  style="display: none">
            <label for="law_firm_name" class="col-md-5 control-label">Name of Law Firm</label>
            <div class=" col-md-7">
                <input type="text" class="form-control" name="lawfirmName"/>
            </div><br/><br/>
        </div>

             <input type="hidden" id="hiddenWorkerFin" name="workerFinNum" value="<%=workerFin%>"/>
        <div class="form-group btn-div col-md-12">
            <span class="required_input">* Required field</span>
            <div class="pull-right">
                <button  type='button' onclick="swapDiv('job_profile', 'prob_profile', -1);" class="btn btn-default">Back  <span class="glyphicon glyphicon-arrow-left"></span></button>
                <button  type='submit' class="btn btn-default">Submit</button>
            </div>
        </div>
    </div>
</form> 
<%}%>

<script>
/////Change to Add pop up/////
function add(stub) {

$('#pop_up_content').empty();

$("#pop_up_content").load('include/createcaseForm.jsp?workerFin=<%=workerFin%>&jobkey=<%=jobKey%>&probkey=<%=probKey%>&profile=' + stub + '&action=add').dialog({modal: true, minHeight: $(window).height() - 350, minWidth: $(window).width() - 750, width:(window).width()-200, resizable: false, title: div_title, draggable: false, close: function() {
    $(this).dialog('destroy');
    $('#pop_up_content').empty();
}
});

}



</script>
