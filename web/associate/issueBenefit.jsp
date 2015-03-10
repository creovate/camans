<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="camans.dao.*"%>
<%@page import="camans.entity.*"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="../protect.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Job latestJob = null;
    Problem latestProblem = null;
    SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy");
    java.util.Date today = new java.util.Date();
    User userLogin = (User) request.getSession().getAttribute("userLogin");

    //for search result
    ArrayList<Worker> searchWorkers = (ArrayList<Worker>) request.getSession().getAttribute("searchWorkers");
    request.getSession().removeAttribute("searchWorkers");

    Worker worker = null;

    String workerName = "";
    String workerFin = "";
    if (searchWorkers != null && searchWorkers.size() > 0) {
        worker = searchWorkers.get(0);


    }
    String fin = (String) request.getSession().getAttribute("fin");
    request.getSession().removeAttribute("fin");
    if (fin != null && !fin.equals("")) {
        worker = WorkerDAO.retrieveWorkerbyFinNumber(fin);
    }

    String workerFinNum = (String) request.getSession().getAttribute("worker");
    request.getSession().removeAttribute("worker");
    if (workerFinNum != null && !workerFinNum.equals("")) {
        worker = WorkerDAO.retrieveWorkerbyFinNumber(workerFinNum);
    }

    String selectedJob = (String) request.getSession().getAttribute("selectedJob");
    request.getSession().removeAttribute("selectedJob");
    if (selectedJob == null || selectedJob.equals("")) {
        selectedJob = request.getParameter("selectedJob");
    }

    String selectedProb = (String) request.getSession().getAttribute("selectedProb");
    request.getSession().removeAttribute("selectedProb");
    if (selectedProb == null || selectedProb.equals("")) {
        selectedProb = request.getParameter("selectedProb");
    }


    ArrayList<Integer> jobIdList = new ArrayList<Integer>();
    ArrayList<Integer> problemIdList = new ArrayList<Integer>();

    if (worker != null) {
        workerName = worker.getName();
        workerFin = worker.getFinNumber();
        jobIdList = JobDAO.retrieveJobIdsOfWorker(worker);

        if (selectedJob != null) {
            int selectedJobId = Integer.parseInt(selectedJob);
            latestJob = JobDAO.retrieveJobByJobId(selectedJobId);
            problemIdList = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
            latestProblem = ProblemDAO.retrieveProblemByProblemId(problemIdList.get(problemIdList.size() - 1));
        } else {
            latestJob = JobDAO.retrieveJobByJobId(jobIdList.get(jobIdList.size() - 1));
            selectedJob = latestJob.getJobKey() + "";
            problemIdList = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
        }
    }

    if (selectedProb != null) {
        int selectedProbId = Integer.parseInt(selectedProb);
        latestProblem = ProblemDAO.retrieveProblemByProblemId(selectedProbId);
        int selectedJobId = latestProblem.getJobKey();
        selectedJob = selectedJobId + "";
        latestJob = JobDAO.retrieveJobByJobId(selectedJobId);
        problemIdList = ProblemDAO.retrieveProblemsIdsOfWorkerAndJob(worker, latestJob);
    } else if (problemIdList != null && problemIdList.size() > 0) {

        latestProblem = ProblemDAO.retrieveProblemByProblemId(problemIdList.get(problemIdList.size() - 1));
        int probKey = latestProblem.getProbKey();
        selectedProb = probKey + "";
        selectedJob = latestProblem.getJobKey() + "";
    }

    //prepare for benefit dropdowns
    ArrayList<String> foodDropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Food");
    //get transportation benefit dropdown list
    ArrayList<String> faregoDropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Transport");
    ArrayList<String> medDropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Medical & Karunya");
    ArrayList<String> roofDropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Roof");
    ArrayList<String> otherDropdownList = DropdownDAO.retreiveAllDropdownListOfBenefits("Other");

    ArrayList<String> dropdownList = foodDropdownList;

    String successMsg = (String) request.getSession().getAttribute("successBenefitMsg");
    request.getSession().removeAttribute("successBenefitMsg");
    //create case
    if(successMsg == null || successMsg.equals("")){
        successMsg = (String) request.getSession().getAttribute("successCaseMsg");
        request.getSession().removeAttribute("successCaseMsg");
    }
    //r2r
    if(successMsg == null || successMsg.equals("")){
        successMsg = (String) request.getSession().getAttribute("successProbCompMsg");
        request.getSession().removeAttribute("successProbCompMsg");
    }
    
    String errorMsg = (String) request.getSession().getAttribute("errorBenefitMsg");
    request.getSession().removeAttribute("errorBenefitMsg");
    if(errorMsg == null || errorMsg.equals("")){
        errorMsg = (String) request.getSession().getAttribute("errorMsg");
        request.getSession().removeAttribute("errorMsg");
    }
    //r2r
    if(errorMsg == null || errorMsg.equals("")){
        errorMsg = (String) request.getSession().getAttribute("errorProbCompMsg");
        request.getSession().removeAttribute("errorProbCompMsg");
    }
%>
<!DOCTYPE html>
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
        <script src="../js/jquery.validate.js"></script>
        <script type="text/javascript" src="../js/bootstrapValidator.min.js"></script>   
        <!------------->

        <!--tab icon-->
        <link rel="shortcut icon" href="../img/twc_logo.png">

        <!--page title-->
        <title>CAMANS</title>
        <style>
            label{
                color: #006c9a;
            }

            #searchBox{
                margin-bottom: 2%;
            }
            #searcResult{
                background-color: #ededed;

                padding-left: 0;
                padding-right: 0;
            }

            #folderImg{
                width: 20vw;
            }
            input{
                width: 100%;
            }
            input.form-control{
                width: 100%;
            }

            #issueBene{
                border-left: 1px solid #CCC;
                border-right: 1px solid #CCC;
            }
            
            .alert{
                position: absolute;
                z-index: 999;
                top: 18vh;
            }
        </style>
        <script>
            function goBack() {
                window.history.back();
            }

            function toggleBenefitDDL() {
                var selected = $('#benefitCategory').val();

                $('#nbenetype').empty();
                if (selected === "Food") {

            <%             for (int i = 0; i < foodDropdownList.size(); i++) {
                    String ddlItem = foodDropdownList.get(i);
            %>

                    $('#nbenetype').append("<option><%=ddlItem%></option>");

            <%
                }
            %>

                } else if (selected === "Transport") {
            <%          for (int i = 0; i < faregoDropdownList.size(); i++) {
                    String ddlItem = faregoDropdownList.get(i);
            %>

                    $('#nbenetype').append("<option><%=ddlItem%></option>");
            <%
                }
            %>
                    //alert("farego");
                } else if (selected === "Medical & Karunya") {
            <%
                for (int i = 0; i < medDropdownList.size(); i++) {
                    String ddlItem = medDropdownList.get(i);
            %>
                    $('#nbenetype').append("<option><%=ddlItem%></option>");
            <%
                }
            %>
                    //alert("med");
                } else if (selected === "Roof") {
            <%               for (int i = 0; i < roofDropdownList.size(); i++) {
                    String ddlItem = roofDropdownList.get(i);
            %>
                    $('#nbenetype').append("<option><%=ddlItem%></option>");
            <%
                }
            %>
                    //alert("roof");
                } else if (selected === "Other") {
            <%
                for (int i = 0; i < otherDropdownList.size(); i++) {
                    String ddlItem = otherDropdownList.get(i);
            %>
                    $('#nbenetype').append("<option><%=ddlItem%></option>");
            <%
                }
            %>
                }
                $('#btnHistory').attr("onclick", "window.location = 'benefection.jsp?worker=<%=workerFin%>&selectedJob=<%= selectedJob%>&selectedProb=<%=selectedProb%>&beneCategory=" + selected + "&action=viewRecent';");


            }

            $(document).ready(function() {
                $('.alert').fadeOut(9999);
//methods for jquery validator
                jQuery.validator.addMethod("FIN", function(value, element) {
                    return this.optional(element) || /^[A-Z][0-9]{7}[A-Z]$/.test(value) || /^GEN[0-9]{6}$/.test(value);
                }, "Invalid FIN number format. Please check again.");
                $('#searchForm').validate({
                    //ignore: ":hidden",
                    rules: {
                        fin: {
                            required: true,
                            FIN: true
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
                $('#add_benefit')
                        .bootstrapValidator({
                    fields: {
                        ngivenby: {
                            validators: {
                                stringLength: {
                                    max: 20,
                                    message: 'This field must not exceed 20 characters.'
                                },
                                notEmpty: {
                                    message: 'Given by cannot be empty.'
                                }

                            }
                        },
                        nisDate: {
                            validators: {
                                notEmpty: {
                                    message: 'Date given cannot be empty.'
                                }
                            }
                        },
                        nbenetype: {
                            validators: {
                                notEmpty: {
                                    message: 'This field cannot be empty.'
                                }
                            }
                        },
                        nsernum: {
                            validators: {
                                stringLength: {
                                    max: 30,
                                    message: 'This field must not exceed 30 characters.'
                                }
                            }
                        },
                        npurpose: {
                            validators: {
                                stringLength: {
                                    max: 200,
                                    message: 'This field must not exceed 200 characters.'
                                }
                            }
                        },
                        nremark: {
                            validators: {
                                stringLength: {
                                    max: 500,
                                    message: 'This field must not exceed 500 characters.'
                                }
                            }
                        },
                        nvalue: {
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
        <!-- Search Box -->
        <div id="searchBox" class="col-xs-12 col-sm-offset-1 col-sm-10 col-md-offset-2 col-md-8">
            <h4 style="color:#006c9a">Search Worker by FIN</h4>

            <!-- Search Worker form-->
            <form class="form-inline" id="searchForm" method="POST" action="../searchWorker.do">
                <div class="form-group col-xs-9 col-sm-8 col-md-8">
                    <%
                        if (fin != null) {
                    %>
                    <input type="text" class="form-control" name="fin"  id="finNum" value="<%=fin%>" placeholder="FIN Number" required style='width:100%;'>
                    <%
                    } else {
                    %>
                    <input type="text" class="form-control" id="finNum" name="fin" placeholder="FIN Number" required style='width:100%;'>
                    <%                    }
                    %>

                </div>
                <input type="hidden" name="associate" value="associate"/>
                <button type="submit" class="btn btn-blue col-xs-3 col-sm-3 col-md-3">Search</button>
            </form>
        </div>
        <!-- End of Search Box -->

        <%
            if (worker != null) {
                //there will be only one worker with this fin number

        %>
        <!-- Search Result & issue Benefits -->

        <!-- Search Result -->
        <br/>
        <!--div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 col-xs-12" id="searcResult"-->
        <div class="col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-3 col-sm-6" id="searcResult">
            <br/>
            <label class="col-xs-5">Worker Name</label><p class="col-xs-6"><%=workerName%></p><br/>
            <label class="col-xs-5">FIN Number</label><p class="col-xs-6"><%=workerFin%></p><br/>

            <!-- TO DO :: RELATED TWO DROPDOWNS SO THAT THE PROBLEM LIST REFER TO THE JOB SELECTED -->
            <label class="col-xs-4">Employer</label>
            <div class="col-xs-8">
                <form method="POST" action="../changeToSelected">
                    <select class="col-xs-6 col-md-6 form-control input-sm" id="jobList" name='selectedJob' onchange="this.form.submit();">
                        <%
                            for (int i = jobIdList.size() - 1; i >= 0; i--) {
                                int id = jobIdList.get(i);
                                Job job = JobDAO.retrieveJobByJobId(id);
                                String employer = job.getEmployerName();
                                if (latestJob != null && latestJob.getJobKey() == id) {
                        %>
                        <option value='<%=id%>' selected><%=employer%></option>
                        <%
                        } else {
                        %>
                        <option value='<%=id%>'><%=employer%></option>
                        <%    }
                            }
                        %>
                    </select>
                    <input type='hidden' name="workerFin" value="<%=workerFin%>"/>
                    <input type="hidden" name='selectedType' value='job'/>
                    <input type='hidden' name='associate' value="associate"/>
                </form>

            </div>

            <br/><br/><br/><br/>
            <label class="col-xs-4">Problem</label>
            <div class="col-xs-8">
                <form method="POST" action="../changeToSelected">
                    <select class="col-xs-6 col-md-6 form-control input-sm" id="probList" name="selectedProblem" onchange="this.form.submit();">
                        <%

                            for (int i = problemIdList.size() - 1; i >= 0; i--) {
                                int probId = problemIdList.get(i);
                                Problem problem = ProblemDAO.retrieveProblemByProblemId(problemIdList.get(i));
                                String probType = problem.getProblem();
                                if (latestProblem != null && latestProblem.getProbKey() == probId) {
                        %>
                        <option value='<%=probId%>' selected><%=probType%></option>
                        <%
                        } else {
                        %>
                        <option value='<%=probId%>'><%=probType%></option>
                        <%              }
                            }
                        %>


                    </select>
                    <input type='hidden' name="workerFin" value="<%=workerFin%>"/>
                    <input type="hidden" name='selectedType' value='problem'/>
                    <input type='hidden' name='associate' value="associate"/>
                </form>
            </div>
            <br/><br/><br/>
            <div style="padding: 0 2%">
                <button type="button" class='btn btn-blue btn-sm' onclick="window.location = 'addNew.jsp?workerFin=<%=workerFin%>';"><span class="glyphicon glyphicon-plus"></span> Job</button>
                <button type="button" class='btn btn-blue btn-sm' onclick="window.location = 'addNew.jsp?workerFin=<%=workerFin%>&selectedJob=<%=latestJob.getJobKey()%>';"><span class="glyphicon glyphicon-plus"></span> Problem</button>
                <button type="button" class='btn btn-blue btn-sm pull-right' onclick="window.location = 'caseSummary.jsp?worker=<%=workerFin%>&selectedJob=<%=latestJob.getJobKey()%>&selectedProb=<%=latestProblem.getProbKey()%>';">Case Summary</button>
            </div>
            <br/>
        </div>
        <!-- End of Search Result -->


        <!-- Issue Benefits -->
        <div class="col-xs-12 col-md-offset-2 col-md-8 col-sm-offset-3 col-sm-6" id="issueBene">
            <br/>
            <div class="row" style="padding-right: 5%;">
                <h4 class="col-xs-8" style="color:#006c9a">Issue Benefits</h4>
                <button class="col-xs-3 col-sm-3 col-md-3 btn btn-blue btn-sm pull-right" onclick="window.location = 'addComplements.jsp?workerFin=<%=workerFin%>&selectedJob=<%=latestJob.getJobKey()%>&selectedProb=<%=latestProblem.getProbKey()%>&complement=r2r&action=add';">R2R</button>
            </div>

            <form method="POST" id='add_benefit' class="form form-horizontal" action="../addBenefit.do"  style="height:100%">
                <br/>
                <div class='form-group'>
                    <label for='nbenetype' class="control-label col-xs-4 col-sm-4">Benefits: </label>
                    <div class="col-xs-8 col-sm-4">
                        <select class="form-control input-sm" id="benefitCategory" name="benefitCategory" onchange="toggleBenefitDDL();">
                            <option value="Food">Meal Cards</option>
                            <option value="Transport">FareGo</option>
                            <option value="Medical & Karunya">Medical & Karunya</option>
                            <option value="Roof">Roof</option>
                            <option value="Other">Others</option>
                        </select>
                        <br/>
                    </div>
                    <button type='button' style='margin-right: 5%;' class='btn btn-blue btn-sm pull-right ' id='btnHistory' onclick="window.location = 'benefection.jsp?worker=<%=workerFin%>&selectedJob=<%=latestJob.getJobKey()%>&selectedProb=<%=latestProblem.getProbKey()%>&beneCategory=Food&action=viewRecent';">View History</button>

                </div>

                <br/>

                <div class='form-group'>
                    <label for='nisDate' class="control-label col-xs-4 col-sm-4"><span style="color: red">*</span>Issued Date: </label>
                    <div class="col-xs-8 col-sm-4">
                        <input class="form-control dateInput input-sm" type='text' name="nisDate" value="<%=sdf.format(today)%>">
                    </div>
                </div>
                <div class='form-group'>
                    <label for='ngivenby' class="control-label col-xs-4 col-sm-4" ><span style="color: red">*</span>Given By: </label>
                    <div class="col-xs-8 col-sm-4">
                        <input class="form-control input-sm" type='text' name="ngivenby"/>
                    </div>
                </div>
                <div class='form-group'>
                    <label for='nbenetype' class="control-label col-xs-4 col-sm-4"><span style="color: red">*</span>Benefit Type:</label>
                    <div class="col-xs-8 col-sm-4">
                        <select class="form-control input-sm" id="nbenetype" name="nbenetype">
                            <%
                                for (String dropdownItem : dropdownList) {
                                    if (dropdownItem.equals("Meal card")) {
                            %>
                            <option value ="<%=dropdownItem%>" selected><%= dropdownItem%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=dropdownItem%>"><%=dropdownItem%></option>
                            <%
                                    }

                                }
                            %>  
                        </select>
                    </div>
                </div>
                <div class='form-group'>
                    <label for='nsernum' class="control-label col-xs-4 col-sm-4">Serial Number: </label>
                    <div class="col-xs-8 col-sm-4">
                        <input class="form-control input-sm" type='text' name="nsernum">
                    </div>
                </div>
                <div class='form-group'>
                    <label for='nremark' class="control-label col-xs-4 col-sm-4">Remarks: </label>
                    <div class="col-xs-8 col-sm-4">
                        <textarea class="form-control input-sm" name="nremark" rows="3"></textarea>
                    </div>
                </div>
                <div class='form-group'>
                    <label for='nvalue' class="control-label col-xs-4 col-sm-4">Value of Benefit(S$): </label>
                    <div class="col-xs-8 col-sm-4">
                        <input class="form-control input-sm" type='text' name="nvalue">
                    </div>
                </div>
                <input type="hidden" name="workerFinNum" value="<%=workerFin%>"/>
                <input type="hidden" name="jobkey" value="<%=latestJob.getJobKey()%>"/>
                <input type="hidden" name="probKey" value="<%=latestProblem.getProbKey()%>"/>
                <input type="hidden" name="associate" value="associate"/>
                <input type="hidden" name="action" value="add"/>

                <div class="form-group btn_group pull-right">
                    <button type='submit' class="btn btn-blue modal_btn">Save</button>
                    <button type='button' onclick="window.location = 'home.jsp'" class='btn modal_btn cancel_btn'>Cancel</button>
                </div>

            </form>
        </div>
        <!-- End of Issue Benefits -->


        <!-- End of Search Result & issue Benefits -->
        <%        } else {
        %>
        <!-- Not Found Message & Directory -->
        <div class='row'>
            <div class="col-md-offset-1 col-md-10 col-sm-offset-1 col-sm-10 col-xs-offset-1 col-xs-10">
                <p style="color:red">Sorry! The worker does not exist in the system.
                </p>
                <p><b>Do you want to create new case?</b></p><br/>

                <!--To do : option buttons to create worker-->
                <div class="col-md-offset-2 col-md-8 col-sm-offset-1 col-sm-10 col-xs-12">
                    <a href="addNew.jsp?workerFin=<%=fin%>&option=createCase"><img class="img-responsive center-block" src="../img/folder.png" id="folderImg"/></a>
                </div>
            </div>
        </div>
        <!-- End of Not Found Message & Directory -->
        <%        }
        %>



    </body>
</html>
